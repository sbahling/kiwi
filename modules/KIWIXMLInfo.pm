#================
# FILE          : KIWIXMLInfo.pm
#----------------
# PROJECT       : OpenSUSE Build-Service
# COPYRIGHT     : (c) 2011 SUSE LINUX Products GmbH, Germany
#               :
# AUTHOR        : Robert Schweikert <rschweikert@novell.com>
#               :
# BELONGS TO    : Operating System images
#               :
# DESCRIPTION   : This module is used to upgrade and validate the
#               : XML file, describing the image to be created
#               :
# STATUS        : Development
#----------------
package KIWIXMLInfo;
#==========================================
# Modules
#------------------------------------------
use strict;
use warnings;
require Exporter;
use File::Find;
use XML::LibXML;

#==========================================
# KIWI Modules
#------------------------------------------
use KIWICommandLine;
use KIWILog;
use KIWIQX;
use KIWIXML;

#==========================================
# Exports
#------------------------------------------
our @ISA    = qw (Exporter);
our @EXPORT = qw ();

#==========================================
# Constructor
#------------------------------------------
sub new {
	# ...
	# Create the info object.
	# ---
	#==========================================
	# Object setup
	#------------------------------------------
	my $this  = {};
	my $class = shift;
	bless $this,$class;
	#==========================================
	# Module Parameters
	#------------------------------------------
	my $kiwi = shift;
	my $cmdL = shift;
	my $xml  = shift;
	#==========================================
	# Constructor setup
	#------------------------------------------
	if (! defined $kiwi) {
		$kiwi = new KIWILog("tiny");
	}
	#==========================================
	# Check pre-conditions
	#------------------------------------------
	if (! defined $cmdL) {
		my $msg = 'KIWIXMLInfo: expecting KIWICommandLine object as '
			. 'second argument.';
		$kiwi -> error ($msg);
		$kiwi -> failed();
		return;
	}
	my $configDir = $cmdL -> getConfigDir();
	if (! defined $configDir) {
		my $msg = 'Invalid KIWICommandLine object, no configuration '
			. 'directory.';
		$kiwi -> error ($msg);
		$kiwi -> failed();
		return;
	}
	if (! $main::global) {
		$kiwi -> error  ("Globals object not found");
		$kiwi -> failed ();
		return;
	}
	#==========================================
	# Reset logging target if requested
	#------------------------------------------
	my $logFile = $cmdL -> getLogFile();
	if ($logFile) {
		$kiwi -> info ("Setting log file to: $logFile\n");
			if (! $kiwi -> setLogFile ( $logFile )) {
				return;
			}
	}
	#==========================================
	# Store object data
	#------------------------------------------
	$this->{addlRepos}      = $cmdL -> getAdditionalRepos();
	$this->{buildProfiles}  = $cmdL -> getBuildProfiles();
	$this->{configDir}      = $configDir;
	$this->{ignoreRepos}    = $cmdL -> getIgnoreRepos();
	$this->{kiwi}           = $kiwi;
	$this->{packageManager} = $cmdL -> getPackageManager();
	$this->{replRepo}       = $cmdL -> getReplacementRepo();
	$this->{gdata}          = $main::global -> getGlobals();
	$this->{cmdL}           = $cmdL;
	$this->{xml}            = $xml;
	return $this;
}

#==========================================
# getXMLInfoTree
#------------------------------------------
sub getXMLInfoTree {
	# ...
	# Return the tree object
	# ---
	my $this     = shift;
	my $requests = shift;
	my $infoRequests = $this -> __checkRequests($requests);
	if (! $infoRequests) {
		return;
	}
	return $this -> __getTree($infoRequests);
}

#==========================================
# printXMLInfo
#------------------------------------------
sub printXMLInfo {
	# ...
	# Print the XML information
	# ---
	my $this     = shift;
	my $requests = shift;
	my $kiwi = $this->{kiwi};
	my $infoRequests = $this -> __checkRequests($requests);
	if (! $infoRequests) {
		return;
	}
	my $outfile = qxx ("mktemp -q /tmp/kiwi-xmlinfo-XXXXXX 2>&1");
	my $code = $? >> 8; chomp $outfile;
	if ($code != 0) {
		$kiwi -> error  ("Couldn't create tmp file: $outfile: $!");
		$kiwi -> failed ();
		return;
	}
	$this -> {kiwi} -> info ("Reading image description [ListXMLInfo]...\n");
	my $infoTree = $this -> __getTree($infoRequests);
	if (! $infoTree) {
		return;
	}
	# Violates 3 argument open rule FIXME
	open (my $F, "|xsltproc $this->{gdata}->{Pretty} - | cat > $outfile"); ## no critic
	print $F $infoTree -> toString();
	close $F;
	system ("cat $outfile");
	$kiwi -> info ("Requested information written to: $outfile\n");
	return 1;
}

#==========================================
# Private helper methods
#------------------------------------------
#==========================================
# __checkRequests
#------------------------------------------
sub __checkRequests {
	# ...
	# Verify that the information requested is a supported request
	# ---
	my $this     = shift;
	my $requests = shift;
	my $kiwi = $this -> {kiwi};
	if (! $requests) {
		my $msg = 'No information requested, nothing todo.';
		$kiwi -> error ($msg);
		$kiwi -> failed ();
		return;
	}
	if (! ref $requests) {
		my $msg = 'Expecting ARRAY_REF as first argument for info requests.';
		$kiwi -> error ($msg);
		$kiwi -> failed ();
		return;
	}
	my @infoReq = @{$requests};
	#==========================================
	# Verify the requested information is available
	#------------------------------------------
	my %supportedInfoReq;
	$supportedInfoReq{'packages'}      = 'List of packages to be installed';
	$supportedInfoReq{'patterns'}      = 'List configured patterns';
	$supportedInfoReq{'profiles'}      = 'List profiles';
	$supportedInfoReq{'repo-patterns'} = 'List available patterns from repos';
	$supportedInfoReq{'overlay-files'} = 'List of files in root overlay';
	$supportedInfoReq{'archives'}      = 'List of tar archives to be installed';
	$supportedInfoReq{'size'}          = 'List install/delete size estimation';
	$supportedInfoReq{'sources'}       = 'List configured source URLs';
	$supportedInfoReq{'types'}         = 'List configured types';
	$supportedInfoReq{'version'}       = 'List name and version';
	my @infoList;
	for my $info (@infoReq) {
		if (defined $supportedInfoReq{$info}) {
			push @infoList, $info;
			next;
		}
		my $msg = "Requested information option $info not supported, "
			. 'ignoring.';
		$kiwi -> warning ($msg);
		$kiwi -> skipped();
	}
	if (! @infoList) {
		my $msg = 'None of the specified information options are available.';
		$kiwi -> error ($msg);
		$kiwi -> failed ();
		$kiwi -> info   ("Choose between the following:\n");
		for my $info (sort keys %supportedInfoReq) {
			my $s = sprintf ("--> %-15s:%s\n",$info,$supportedInfoReq{$info});
			$kiwi -> info ($s);
		}
		return;
	}
	return \@infoList;
}

#==========================================
# __cleanMountPnts
#------------------------------------------
sub __cleanMountPnts {
	# ...
	# Clean up any mount points, i.e. unmount and remove the directory
	# ---
	my $this   = shift;
	my $mounts = shift;
	my @mountPnts = @{$mounts};
	my $kiwi = $this->{kiwi};

	for my $dir (@mountPnts) {
		next if ! defined $dir;
		qxx ("umount $dir ; rmdir $dir 2>&1");
		my $code = $? >> 8;
		if ($code != 0) {
			my $msg = 'Could not clean mount point "'
				. "$dir"
				. '". Please unmount manually and remove the directory.';
			$kiwi -> warning ($msg);
			$kiwi -> skipped();
		}
	}
	return 1;
}

#==========================================
# __getTree
#------------------------------------------
sub __getTree {
	# ...
	# Create the information XML tree
	# ---
	my $this     = shift;
	my $requests = shift;
	my $kiwi     = $this -> {kiwi};
	my $xml      = $this -> {xml};
	if (! $xml) {
		$xml = $this -> __xmlSetup();
	}
	if (! $xml) {
		return;
	}
	my $mountDirs = $this -> __setupRepoMounts($xml);
	if (! $mountDirs) {
		return;
	}
	my @infoRequests = @{$requests};
	my $meta;
	my $delete;
	my $solfile;
	my $satlist;
	my $solp;
	my $rpat;
	#==========================================
	# Initialize XML imagescan element
	#------------------------------------------
	my $scan = new XML::LibXML::Element ("imagescan");
	$scan -> setAttribute ("description",$this->{configDir});
	#==========================================
	# Walk through selection list
	#------------------------------------------
	my $generateWanted;
	for my $info (@infoRequests) {
		SWITCH: for ($info) {
			#==========================================
			# overlay-files
			#------------------------------------------
			/^overlay-files/ && do {
				my %result;
				$generateWanted = sub  {
					my $filehash = shift;
					my $basedir  = shift;
					return sub {
						my $file = $File::Find::name;
						if (! -d $file) {
							$file =~ s/$basedir//;
							$file = "[root/]$file";
							$filehash->{$file} = $basedir;
						}
					};
				};
				if (! -d $this->{configDir}."/root") {
					$kiwi -> info ("No overlay root directory present\n");
				} else {
					my $wref = &$generateWanted (
						\%result,$this->{configDir}."/root/"
					);
					my $rdir = $this->{configDir}."/root";
					find({ wanted => $wref, follow => 0 }, $rdir);
					if (! %result) {
						$kiwi -> info ("No overlay files found\n");
					} else {
						foreach my $file (sort keys %result) {
							my $overlay = new XML::LibXML::Element ("overlay");
							$overlay -> setAttribute ("file","$file");
							$scan -> appendChild ($overlay);
						}
					}
				}
				last SWITCH;
			};
			#==========================================
			# repo-patterns
			#------------------------------------------
			/^repo-patterns/ && do {
				if (! $meta) {
					($meta,$delete,$solfile,$satlist,$solp,$rpat) =
						$xml->getInstallSize();
					if (! $meta) {
						$kiwi -> failed();
						$this -> __cleanMountPnts($mountDirs);
						return;
					}
				}
				if (! $rpat) {
					$kiwi -> info ("No patterns in repo solvable\n");
				} else {
					foreach my $p (@{$rpat}) {
						next if ($p eq "\n");
						$p =~ s/^\s+//;
						$p =~ s/\s+$//;
						my $pattern = new XML::LibXML::Element ("repopattern");
						$pattern -> setAttribute ("name","$p");
						$scan -> appendChild ($pattern);
					}
				}
				last SWITCH;
			};
			#==========================================
			# patterns
			#------------------------------------------
			/^patterns/      && do {
				if (! $meta) {
					($meta,$delete,$solfile,$satlist,$solp) =
						$xml->getInstallSize();
					if (! $meta) {
						$kiwi -> failed();
						$this -> __cleanMountPnts($mountDirs);
						return;
					}
				}
				if (! keys %{$meta}) {
					$kiwi -> info ("No packages/patterns solved\n");
				} else {
					foreach my $p (sort keys %{$meta}) {
						if ($p =~ /pattern:(.*)/) {
							my $name = $1;
							my $pattern = new XML::LibXML::Element ("pattern");
							$pattern -> setAttribute ("name","$name");
							$scan -> appendChild ($pattern);
						}
					}
				}
				last SWITCH;
			};
			#==========================================
			# types
			#------------------------------------------
			/^types/         && do {
				foreach my $t ($xml -> getTypes()) {
					my %type = %{$t};
					my $type = new XML::LibXML::Element ("type");
					$type -> setAttribute ("name","$type{type}");
					$type -> setAttribute ("primary","$type{primary}");
					if (defined $type{boot}) {
						$type -> setAttribute ("boot","$type{boot}");
					}
					$scan -> appendChild ($type);
				}
				last SWITCH;
			};
			#==========================================
			# sources
			#------------------------------------------
			/^sources/       && do {
				my %repos = $xml -> getRepository();
				for my $url (keys %repos) {
					my $source = new XML::LibXML::Element ("source");
					$source -> setAttribute ("path","$url");
					$source -> setAttribute ("type",$repos{$url}->[0]);
					if ($repos{$url}->[2]) {
						$source -> setAttribute ("priority",$repos{$url}->[2]);
					}
					if ($repos{$url}->[3]) {
						$source -> setAttribute ("username",$repos{$url}->[3]);
					}
					if ($repos{$url}->[4]) {
						$source -> setAttribute ("password",$repos{$url}->[4]);
					}
					$scan -> appendChild ($source);
				}
				last SWITCH;
			};
			#==========================================
			# size
			#------------------------------------------
			/^size/          && do {
				if (! $meta) {
					($meta,$delete,$solfile,$satlist,$solp) =
						$xml->getInstallSize();
					if (! $meta) {
						$kiwi -> failed();
						$this -> __cleanMountPnts($mountDirs);
						return;
					}
				}
				my $size = 0;
				my %meta = %{$meta};
				foreach my $p (keys %meta) {
					my @metalist = split (/:/,$meta{$p});
					$size += $metalist[0];
				}
				my $sizenode = new XML::LibXML::Element ("size");
				if ($size > 0) {
					$sizenode -> setAttribute ("rootsizeKB","$size");
				}
				$size = 0;
				if ($delete) {
					foreach my $del (@{$delete}) {
						if ($meta{$del}) {
							my @metalist = split (/:/,$meta{$del});
							$size += $metalist[0];
						}
					}
				}
				if ($size > 0) {
					$sizenode -> setAttribute ("deletionsizeKB","$size");
				}
				$scan -> appendChild ($sizenode);
				last SWITCH;
			};
			#==========================================
			# packages
			#------------------------------------------
			/^packages/     && do {
				if (! $meta) {
					($meta,$delete,$solfile,$satlist,$solp) =
						$xml->getInstallSize();
					if (! $meta) {
						$kiwi -> failed();
						$this -> __cleanMountPnts($mountDirs);
						return;
					}
				}
				if (! keys %{$meta}) {
					$kiwi -> info ("No packages/patterns solved\n");
				} else {
					foreach my $p (sort keys %{$meta}) {
						if ($p =~ /pattern:.*/) {
							next;
						}
						my @m = split (/:/,$meta->{$p});
						my $repo = $m[4]; $repo =~ s/ /:/g;
						my $pacnode = new XML::LibXML::Element ("package");
						$pacnode -> setAttribute ("name","$p");
						$pacnode -> setAttribute ("arch","$m[1]");
						$pacnode -> setAttribute ("version","$m[2]");
						$pacnode -> setAttribute ("sum","$m[3]");
						$pacnode -> setAttribute ("repo",$repo);
						$scan -> appendChild ($pacnode);
					}
				}
				last SWITCH;
			};
			/^archives/      && do {
				my @archives = $xml -> getArchiveList();
				if ((scalar @archives) == 0) {
					$kiwi -> info ("No archives available\n");
				} else {
					foreach my $archive (@archives) {
						my $anode = new XML::LibXML::Element ("archive");
						$anode -> setAttribute ("name","$archive");
						$scan -> appendChild ($anode);
					}
				}
				last SWITCH;
			};
			#==========================================
			# profiles
			#------------------------------------------
			/^profiles/      && do {
				my @profiles = $xml -> getProfiles ();
				if ((scalar @profiles) == 0) {
					$kiwi -> info ("No profiles available\n");
				} else {
					foreach my $profile (@profiles) {
						my $name = $profile -> {name};
						my $desc = $profile -> {description};
						my $pnode = new XML::LibXML::Element ("profile");
						$pnode -> setAttribute ("name","$name");
						$pnode -> setAttribute ("description","$desc");
						$scan -> appendChild ($pnode);
					}
				}
				last SWITCH;
			};
			#==========================================
			# version
			#------------------------------------------
			/^version/       && do {
				my $version = $xml -> getImageVersion();
				my $appname = $xml -> getImageName();
				my $vnode = new XML::LibXML::Element ("image");
				$vnode -> setAttribute ("version","$version");
				$vnode -> setAttribute ("name","$appname");
				$scan -> appendChild ($vnode);
			};
		}
	}
	$this -> __cleanMountPnts($mountDirs);

	return $scan;
}

#==========================================
# __setupRepoMounts
#------------------------------------------
sub __setupRepoMounts {
	# ...
	# Setup mount points and mount any repositories that need to be mounted
	# locally
	# ---
	my $this = shift;
	my $xml  = shift;
	my $kiwi = $this->{kiwi};
	my $uhash= $xml -> getURLHash();
	my @mountPnts;
	if ($uhash) {
		for my $source (keys %{$uhash}) {
			#==========================================
			# iso:// sources
			#------------------------------------------
			if ($source =~ /^iso:\/\/(.*\.iso)/) {
				my $iso  = $1;
				if (! -f $iso) {
					return \@mountPnts;
				}
				my $dir  = $uhash->{$source};
				my $data = qxx ("mkdir -p $dir; mount -o loop $iso $dir 2>&1");
				my $code = $? >> 8;
				if ($code != 0) {
					$kiwi -> error  ("Failed to loop mount ISO path: $data");
					$kiwi -> failed ();
					rmdir $dir;
					if (@mountPnts) {
						$this -> __cleanMountPnts(\@mountPnts);
					}
					return;
				}
				push @mountPnts, $dir;
			}
		}
	}
	return \@mountPnts;
}

#==========================================
# __xmlSetup
#------------------------------------------
sub __xmlSetup {
	# ...
	# Configure the XML object to suitably collect all requested information
	# ---
	my $this = shift;
	my $kiwi = $this->{kiwi};
	my $cmdL = $this->{cmdL};
	#==========================================
	# Setup the XML
	#------------------------------------------
	my $buildProfs = $this -> {buildProfiles};
	my $configDir  = $this -> {configDir};
	my $locator = new KIWILocator($kiwi);
	my $controlFile = $locator -> getControlFile ($configDir);
	if (! $controlFile) {
		return;
	}
	my $validator = new KIWIXMLValidator (
		$kiwi,$controlFile,
		$this->{gdata}->{Revision},
		$this->{gdata}->{Schema},
		$this->{gdata}->{SchemaCVT}
	);
	my $isValid = $validator ? $validator -> validate() : undef;
	if (! $isValid) {
		return;
	}
	my $xml = new KIWIXML (
		$kiwi, $configDir, $cmdL->getBuildType(), $buildProfs, $cmdL
	);
	if (! defined $xml) {
		return;
	}
	my $pkgMgr = $this -> {packageManager};
	if ($pkgMgr) {
		$xml -> setPackageManager($pkgMgr);
	}
	my $ignore = $this -> {ignoreRepos};
	if ($ignore) {
		$xml -> ignoreRepositories ();
	}
	if ($this -> {replRepo}) {
		my %replRepo = %{$this -> {replRepo}};
		$xml -> setRepository (
			$replRepo{repositoryType},
			$replRepo{repository},
			$replRepo{repositoryAlias},
			$replRepo{respositoryPriority}
		);
	}
	if ($this -> {addlRepos}) {
		my %addlRepos = %{$this -> {addlRepos}};
		$xml -> addRepository (
			$addlRepos{repositoryTypes},
			$addlRepos{repositories},
			$addlRepos{repositoryAlia},
			$addlRepos{repositoryPriorities}
		);
	}
	return $xml;
}

1;
