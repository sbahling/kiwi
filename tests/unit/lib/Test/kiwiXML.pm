#================
# FILE          : xml.pm
#----------------
# PROJECT       : OpenSUSE Build-Service
# COPYRIGHT     : (c) 2011 Novell Inc.
#               :
# AUTHOR        : Robert Schweikert <rschweikert@suse.com>
#               :
# BELONGS TO    : Operating System images
#               :
# DESCRIPTION   : Unit test implementation for the KIWIXMLValidator module.
#               :
# STATUS        : Development
#----------------
package Test::kiwiXML;

use strict;
use warnings;

use Common::ktLog;
use Common::ktTestCase;
use base qw /Common::ktTestCase/;

use KIWIXML;
use KIWICommandLine;

# All tests will need to be adjusted once KIWXML turns into a stateless
# container and the ctor receives the config.xml file name as an argument.
# At this point the test data location should also change.
#
# Complete unit testing of the XML object may not be possible until the
# conversion to a stateless container is complete

#==========================================
# Constructor
#------------------------------------------
sub new {
	# ...
	# Construct new test case
	# ---
	my $this = shift -> SUPER::new(@_);
	$this -> {dataDir} = $this -> getDataDir() . '/kiwiXML/';
	$this -> {kiwi} = new  Common::ktLog();
	$this -> {cmdL} = new KIWICommandLine($this->{kiwi});

	return $this;
}

#==========================================
# test_getBootTheme
#------------------------------------------
sub test_getBootTheme {
	# ...
	# Verify proper return of getBootTheme method
	# ---
	my $this = shift;
	my $kiwi = $this -> {kiwi};
	my $confDir = $this->{dataDir} . 'preferenceSettings';
	my $xml = new KIWIXML(
		$this -> {kiwi}, $confDir, undef, undef,$this->{cmdL}
	);
	my $value = $xml -> getBootTheme();
	my $msg = $kiwi -> getMessage();
	$this -> assert_str_equals('No messages set', $msg);
	my $msgT = $kiwi -> getMessageType();
	$this -> assert_str_equals('none', $msgT);
	my $state = $kiwi -> getState();
	$this -> assert_str_equals('No state set', $state);
	# Test this condition last to get potential error messages
	$this -> assert_str_equals('bluestar', $value);
}

#==========================================
# test_getImageDefaultDestination
#------------------------------------------
sub test_getImageDefaultDestination {
	# ...
	# Verify proper return of getImageDefaultDestination method
	# ---
	my $this = shift;
	my $kiwi = $this -> {kiwi};
	my $confDir = $this->{dataDir} . 'preferenceSettings';
	my $xml = new KIWIXML(
		$this -> {kiwi}, $confDir, undef, undef,$this->{cmdL}
	);
	my $value = $xml -> getImageDefaultDestination();
	my $msg = $kiwi -> getMessage();
	$this -> assert_str_equals('No messages set', $msg);
	my $msgT = $kiwi -> getMessageType();
	$this -> assert_str_equals('none', $msgT);
	my $state = $kiwi -> getState();
	$this -> assert_str_equals('No state set', $state);
	# Test this condition last to get potential error messages
	$this -> assert_str_equals('/work/tmp', $value);
}

#==========================================
# test_getImageDefaultRoot
#------------------------------------------
sub test_getImageDefaultRoot {
	# ...
	# Verify proper return of getImageDefaultRoot method
	# ---
	my $this = shift;
	my $kiwi = $this -> {kiwi};
	my $confDir = $this->{dataDir} . 'preferenceSettings';
	my $xml = new KIWIXML(
		$this -> {kiwi}, $confDir, undef, undef,$this->{cmdL}
	);
	my $value = $xml -> getImageDefaultRoot();
	my $msg = $kiwi -> getMessage();
	$this -> assert_str_equals('No messages set', $msg);
	my $msgT = $kiwi -> getMessageType();
	$this -> assert_str_equals('none', $msgT);
	my $state = $kiwi -> getState();
	$this -> assert_str_equals('No state set', $state);
	# Test this condition last to get potential error messages
	$this -> assert_str_equals('/var/tmp', $value);
}

#==========================================
# test_getImageDisplayName
#------------------------------------------
sub test_getImageDisplayName {
	# ...
	# Verify proper return of getImageDisplayName method
	# ---
	my $this = shift;
	my $kiwi = $this -> {kiwi};
	my $confDir = $this->{dataDir} . 'preferenceSettings';
	my $xml = new KIWIXML(
		$this -> {kiwi}, $confDir, undef, undef,$this->{cmdL}
	);
	my $value = $xml -> getImageDisplayName();
	my $msg = $kiwi -> getMessage();
	$this -> assert_str_equals('No messages set', $msg);
	my $msgT = $kiwi -> getMessageType();
	$this -> assert_str_equals('none', $msgT);
	my $state = $kiwi -> getState();
	$this -> assert_str_equals('No state set', $state);
	# Test this condition last to get potential error messages
	$this -> assert_str_equals('testcase', $value);
}

#==========================================
# test_getImageID
#------------------------------------------
sub test_getImageID {
	# ...
	# Verify proper return of getImageID method
	# ---
	my $this = shift;
	my $kiwi = $this -> {kiwi};
	my $confDir = $this->{dataDir} . 'preferenceSettings';
	my $xml = new KIWIXML(
		$this -> {kiwi}, $confDir, undef, undef,$this->{cmdL}
	);
	my $value = $xml -> getImageID();
	my $msg = $kiwi -> getMessage();
	$this -> assert_str_equals('No messages set', $msg);
	my $msgT = $kiwi -> getMessageType();
	$this -> assert_str_equals('none', $msgT);
	my $state = $kiwi -> getState();
	$this -> assert_str_equals('No state set', $state);
	# Test this condition last to get potential error messages
	$this -> assert_str_equals('3030150', $value);
}

#==========================================
# test_getImageName
#------------------------------------------
sub test_getImageName {
	# ...
	# Verify proper return of getImageName method
	# ---
	my $this = shift;
	my $kiwi = $this -> {kiwi};
	my $confDir = $this->{dataDir} . 'preferenceSettings';
	my $xml = new KIWIXML(
		$this -> {kiwi}, $confDir, undef, undef,$this->{cmdL}
	);
	my $value = $xml -> getImageName();
	my $msg = $kiwi -> getMessage();
	$this -> assert_str_equals('No messages set', $msg);
	my $msgT = $kiwi -> getMessageType();
	$this -> assert_str_equals('none', $msgT);
	my $state = $kiwi -> getState();
	$this -> assert_str_equals('No state set', $state);
	# Test this condition last to get potential error messages
	$this -> assert_str_equals('testCase-preference-settings', $value);
}

#==========================================
# test_getImageSize
#------------------------------------------
sub test_getImageSizeNotAdditive {
	# ...
	# Verify proper return of getImageSize method
	# ---
	my $this = shift;
	my $kiwi = $this -> {kiwi};
	my $confDir = $this->{dataDir} . 'preferenceSettings';
	my $xml = new KIWIXML(
		$this -> {kiwi}, $confDir, undef, undef,$this->{cmdL}
	);
	my $value = $xml -> getImageSize();
	my $msg = $kiwi -> getMessage();
	$this -> assert_str_equals('No messages set', $msg);
	my $msgT = $kiwi -> getMessageType();
	$this -> assert_str_equals('none', $msgT);
	my $state = $kiwi -> getState();
	$this -> assert_str_equals('No state set', $state);
	# Test this condition last to get potential error messages
	$this -> assert_str_equals('20G', $value);
}

#==========================================
# test_getImageSizeAdditiveBytes
#------------------------------------------
sub test_getImageSizeAdditiveBytesNotAdditive {
	# ...
	# Verify proper return of getImageSizeAdditiveBytes method
	# ---
	my $this = shift;
	my $kiwi = $this -> {kiwi};
	my $confDir = $this->{dataDir} . 'preferenceSettings';
	my $xml = new KIWIXML(
		$this -> {kiwi}, $confDir, undef, undef,$this->{cmdL}
	);
	my $value = $xml -> getImageSizeAdditiveBytes();
	my $msg = $kiwi -> getMessage();
	$this -> assert_str_equals('No messages set', $msg);
	my $msgT = $kiwi -> getMessageType();
	$this -> assert_str_equals('none', $msgT);
	my $state = $kiwi -> getState();
	$this -> assert_str_equals('No state set', $state);
	# Test this condition last to get potential error messages
	$this -> assert_str_equals('0', $value);
}

#==========================================
# test_getImageSizeBytes
#------------------------------------------
sub test_getImageSizeBytesNotAdditive {
	# ...
	# Verify proper return of getImageSizeBytes method
	# ---
	my $this = shift;
	my $kiwi = $this -> {kiwi};
	my $confDir = $this->{dataDir} . 'preferenceSettings';
	my $xml = new KIWIXML(
		$this -> {kiwi}, $confDir, undef, undef,$this->{cmdL}
	);
	my $value = $xml -> getImageSizeBytes();
	my $msg = $kiwi -> getMessage();
	$this -> assert_str_equals('No messages set', $msg);
	my $msgT = $kiwi -> getMessageType();
	$this -> assert_str_equals('none', $msgT);
	my $state = $kiwi -> getState();
	$this -> assert_str_equals('No state set', $state);
	# Test this condition last to get potential error messages
	$this -> assert_str_equals('21474836480', $value);
}

#==========================================
# test_getImageTypeAndAttributes
#------------------------------------------
sub test_getImageTypeAndAttributesSimple {
	# ...
	# Verify proper return of getImageTypeAndAttributes method
	# ---
	my $this = shift;
	my $kiwi = $this -> {kiwi};
	my $confDir = $this->{dataDir} . 'preferenceSettings';
	my $xml = new KIWIXML(
		$this -> {kiwi}, $confDir, undef, undef,$this->{cmdL}
	);
	my $typeInfo = $xml -> getImageTypeAndAttributes();
	my $msg = $kiwi -> getMessage();
	$this -> assert_str_equals('No messages set', $msg);
	my $msgT = $kiwi -> getMessageType();
	$this -> assert_str_equals('none', $msgT);
	my $state = $kiwi -> getState();
	$this -> assert_str_equals('No state set', $state);
	# Test this condition last to get potential error messages
	$this -> assert_str_equals('vmx', $typeInfo->{type});
}

#==========================================
# test_getImageVersion
#------------------------------------------
sub test_getImageVersion {
	# ...
	# Verify proper return of getImageVersion method
	# ---
	my $this = shift;
	my $kiwi = $this -> {kiwi};
	my $confDir = $this->{dataDir} . 'preferenceSettings';
	my $xml = new KIWIXML(
		$this -> {kiwi}, $confDir, undef, undef,$this->{cmdL}
	);
	my $value = $xml -> getImageVersion();
	my $msg = $kiwi -> getMessage();
	$this -> assert_str_equals('No messages set', $msg);
	my $msgT = $kiwi -> getMessageType();
	$this -> assert_str_equals('none', $msgT);
	my $state = $kiwi -> getState();
	$this -> assert_str_equals('No state set', $state);
	# Test this condition last to get potential error messages
	$this -> assert_str_equals('13.20.26', $value);
}

#==========================================
# test_getLocale
#------------------------------------------
sub test_getLocale {
	# ...
	# Verify proper return of getLocale method
	# ---
	my $this = shift;
	my $kiwi = $this -> {kiwi};
	my $confDir = $this->{dataDir} . 'preferenceSettings';
	my $xml = new KIWIXML(
		$this -> {kiwi}, $confDir, undef, undef,$this->{cmdL}
	);
	my $value = $xml -> getLocale();
	my $msg = $kiwi -> getMessage();
	$this -> assert_str_equals('No messages set', $msg);
	my $msgT = $kiwi -> getMessageType();
	$this -> assert_str_equals('none', $msgT);
	my $state = $kiwi -> getState();
	$this -> assert_str_equals('No state set', $state);
	# Test this condition last to get potential error messages
	$this -> assert_str_equals('en_US', $value);
}

#==========================================
# test_getOEMAlignPartition
#------------------------------------------
sub test_getOEMAlignPartition {
	# ...
	# Verify proper return of getOEMAlignPartition method
	# ---
	my $this = shift;
	my $kiwi = $this -> {kiwi};
	my $confDir = $this->{dataDir} . 'oemSettings';
	my $xml = new KIWIXML(
		$this -> {kiwi}, $confDir, undef, undef,$this->{cmdL}
	);
	my $value = $xml -> getOEMAlignPartition();
	my $msg = $kiwi -> getMessage();
	$this -> assert_str_equals('No messages set', $msg);
	my $msgT = $kiwi -> getMessageType();
	$this -> assert_str_equals('none', $msgT);
	my $state = $kiwi -> getState();
	$this -> assert_str_equals('No state set', $state);
	# Test this condition last to get potential error messages
	$this -> assert_str_equals('true', $value);
}

#==========================================
# test_getOEMBootTitle
#------------------------------------------
sub test_getOEMBootTitle {
	# ...
	# Verify proper return of getOEMBootTitle method
	# ---
	my $this = shift;
	my $kiwi = $this -> {kiwi};
	my $confDir = $this->{dataDir} . 'oemSettings';
	my $xml = new KIWIXML(
		$this -> {kiwi}, $confDir, undef, undef,$this->{cmdL}
	);
	my $value = $xml -> getOEMBootTitle();
	my $msg = $kiwi -> getMessage();
	$this -> assert_str_equals('No messages set', $msg);
	my $msgT = $kiwi -> getMessageType();
	$this -> assert_str_equals('none', $msgT);
	my $state = $kiwi -> getState();
	$this -> assert_str_equals('No state set', $state);
	# Test this condition last to get potential error messages
	$this -> assert_str_equals('Unit Test', $value);
}

#==========================================
# test_getOEMBootWait
#------------------------------------------
sub test_getOEMBootWait {
	# ...
	# Verify proper return of getOEMBootWait method
	# ---
	my $this = shift;
	my $kiwi = $this -> {kiwi};
	my $confDir = $this->{dataDir} . 'oemSettings';
	my $xml = new KIWIXML(
		$this -> {kiwi}, $confDir, undef, undef,$this->{cmdL}
	);
	my $value = $xml -> getOEMBootWait();
	my $msg = $kiwi -> getMessage();
	$this -> assert_str_equals('No messages set', $msg);
	my $msgT = $kiwi -> getMessageType();
	$this -> assert_str_equals('none', $msgT);
	my $state = $kiwi -> getState();
	$this -> assert_str_equals('No state set', $state);
	# Test this condition last to get potential error messages
	$this -> assert_str_equals('false', $value);
}

#==========================================
# test_getOEMKiwiInitrd
#------------------------------------------
sub test_getOEMKiwiInitrd {
	# ...
	# Verify proper return of getOEMKiwiInitrd method
	# ---
	my $this = shift;
	my $kiwi = $this -> {kiwi};
	my $confDir = $this->{dataDir} . 'oemSettings';
	my $xml = new KIWIXML(
		$this -> {kiwi}, $confDir, undef, undef,$this->{cmdL}
	);
	my $value = $xml -> getOEMKiwiInitrd();
	my $msg = $kiwi -> getMessage();
	$this -> assert_str_equals('No messages set', $msg);
	my $msgT = $kiwi -> getMessageType();
	$this -> assert_str_equals('none', $msgT);
	my $state = $kiwi -> getState();
	$this -> assert_str_equals('No state set', $state);
	# Test this condition last to get potential error messages
	$this -> assert_str_equals('true', $value);
}

#==========================================
# test_getOEMPartitionInstall
#------------------------------------------
sub test_getOEMPartitionInstall {
	# ...
	# Verify proper return of getOEMPartitionInstall method
	# ---
	my $this = shift;
	my $kiwi = $this -> {kiwi};
	my $confDir = $this->{dataDir} . 'oemSettings';
	my $xml = new KIWIXML(
		$this -> {kiwi}, $confDir, undef, undef,$this->{cmdL}
	);
	my $value = $xml -> getOEMPartitionInstall();
	my $msg = $kiwi -> getMessage();
	$this -> assert_str_equals('No messages set', $msg);
	my $msgT = $kiwi -> getMessageType();
	$this -> assert_str_equals('none', $msgT);
	my $state = $kiwi -> getState();
	$this -> assert_str_equals('No state set', $state);
	# Test this condition last to get potential error messages
	$this -> assert_str_equals('false', $value);
}

#==========================================
# test_getOEMReboot
#------------------------------------------
sub test_getOEMReboot {
	# ...
	# Verify proper return of getOEMReboot method
	# ---
	my $this = shift;
	my $kiwi = $this -> {kiwi};
	my $confDir = $this->{dataDir} . 'oemSettings';
	my $xml = new KIWIXML(
		$this -> {kiwi}, $confDir, undef, undef,$this->{cmdL}
	);
	my $value = $xml -> getOEMReboot();
	my $msg = $kiwi -> getMessage();
	$this -> assert_str_equals('No messages set', $msg);
	my $msgT = $kiwi -> getMessageType();
	$this -> assert_str_equals('none', $msgT);
	my $state = $kiwi -> getState();
	$this -> assert_str_equals('No state set', $state);
	# Test this condition last to get potential error messages
	$this -> assert_str_equals('false', $value);
}

#==========================================
# test_getOEMRebootInter
#------------------------------------------
sub test_getOEMRebootInter {
	# ...
	# Verify proper return of getOEMRebootInter method
	# ---
	my $this = shift;
	my $kiwi = $this -> {kiwi};
	my $confDir = $this->{dataDir} . 'oemSettings';
	my $xml = new KIWIXML(
		$this -> {kiwi}, $confDir, undef, undef,$this->{cmdL}
	);
	my $value = $xml -> getOEMRebootInter();
	my $msg = $kiwi -> getMessage();
	$this -> assert_str_equals('No messages set', $msg);
	my $msgT = $kiwi -> getMessageType();
	$this -> assert_str_equals('none', $msgT);
	my $state = $kiwi -> getState();
	$this -> assert_str_equals('No state set', $state);
	# Test this condition last to get potential error messages
	$this -> assert_str_equals('false', $value);
}

#==========================================
# test_getOEMRecovery
#------------------------------------------
sub test_getOEMRecovery {
	# ...
	# Verify proper return of getOEMRecovery method
	# ---
	my $this = shift;
	my $kiwi = $this -> {kiwi};
	my $confDir = $this->{dataDir} . 'oemSettings';
	my $xml = new KIWIXML(
		$this -> {kiwi}, $confDir, undef, undef,$this->{cmdL}
	);
	my $value = $xml -> getOEMRecovery();
	my $msg = $kiwi -> getMessage();
	$this -> assert_str_equals('No messages set', $msg);
	my $msgT = $kiwi -> getMessageType();
	$this -> assert_str_equals('none', $msgT);
	my $state = $kiwi -> getState();
	$this -> assert_str_equals('No state set', $state);
	# Test this condition last to get potential error messages
	$this -> assert_str_equals('true', $value);
}

#==========================================
# test_getOEMRecoveryID
#------------------------------------------
sub test_getOEMRecoveryID {
	# ...
	# Verify proper return of getOEMRecoveryID method
	# ---
	my $this = shift;
	my $kiwi = $this -> {kiwi};
	my $confDir = $this->{dataDir} . 'oemSettings';
	my $xml = new KIWIXML(
		$this -> {kiwi}, $confDir, undef, undef,$this->{cmdL}
	);
	my $value = $xml -> getOEMRecoveryID();
	my $msg = $kiwi -> getMessage();
	$this -> assert_str_equals('No messages set', $msg);
	my $msgT = $kiwi -> getMessageType();
	$this -> assert_str_equals('none', $msgT);
	my $state = $kiwi -> getState();
	$this -> assert_str_equals('No state set', $state);
	# Test this condition last to get potential error messages
	$this -> assert_str_equals('20', $value);
}

#==========================================
# test_getOEMRecoveryInPlace
#------------------------------------------
sub test_getOEMRecoveryInPlace {
	# ...
	# Verify proper return of getOEMRecoveryInPlace method
	# ---
	my $this = shift;
	my $kiwi = $this -> {kiwi};
	my $confDir = $this->{dataDir} . 'oemSettings';
	my $xml = new KIWIXML(
		$this -> {kiwi}, $confDir, undef, undef,$this->{cmdL}
	);
	my $value = $xml -> getOEMRecoveryInPlace();
	my $msg = $kiwi -> getMessage();
	$this -> assert_str_equals('No messages set', $msg);
	my $msgT = $kiwi -> getMessageType();
	$this -> assert_str_equals('none', $msgT);
	my $state = $kiwi -> getState();
	$this -> assert_str_equals('No state set', $state);
	# Test this condition last to get potential error messages
	$this -> assert_str_equals('true', $value);
}

#==========================================
# test_getOEMShutdown
#------------------------------------------
sub test_getOEMShutdown {
	# ...
	# Verify proper return of getOEMShutdown method
	# ---
	my $this = shift;
	my $kiwi = $this -> {kiwi};
	my $confDir = $this->{dataDir} . 'oemSettings';
	my $xml = new KIWIXML(
		$this -> {kiwi}, $confDir, undef, undef,$this->{cmdL}
	);
	my $value = $xml -> getOEMShutdown();
	my $msg = $kiwi -> getMessage();
	$this -> assert_str_equals('No messages set', $msg);
	my $msgT = $kiwi -> getMessageType();
	$this -> assert_str_equals('none', $msgT);
	my $state = $kiwi -> getState();
	$this -> assert_str_equals('No state set', $state);
	# Test this condition last to get potential error messages
	$this -> assert_str_equals('false', $value);
}

#==========================================
# test_getOEMShutdownInter
#------------------------------------------
sub test_getOEMShutdownInter {
	# ...
	# Verify proper return of getOEMShutdownInter method
	# ---
	my $this = shift;
	my $kiwi = $this -> {kiwi};
	my $confDir = $this->{dataDir} . 'oemSettings';
	my $xml = new KIWIXML(
		$this -> {kiwi}, $confDir, undef, undef,$this->{cmdL}
	);
	my $value = $xml -> getOEMShutdownInter();
	my $msg = $kiwi -> getMessage();
	$this -> assert_str_equals('No messages set', $msg);
	my $msgT = $kiwi -> getMessageType();
	$this -> assert_str_equals('none', $msgT);
	my $state = $kiwi -> getState();
	$this -> assert_str_equals('No state set', $state);
	# Test this condition last to get potential error messages
	$this -> assert_str_equals('true', $value);
}

#==========================================
# test_getOEMSilentBoot
#------------------------------------------
sub test_getOEMSilentBoot {
	# ...
	# Verify proper return of getOEMSilentBoot method
	# ---
	my $this = shift;
	my $kiwi = $this -> {kiwi};
	my $confDir = $this->{dataDir} . 'oemSettings';
	my $xml = new KIWIXML(
		$this -> {kiwi}, $confDir, undef, undef,$this->{cmdL}
	);
	my $value = $xml -> getOEMSilentBoot();
	my $msg = $kiwi -> getMessage();
	$this -> assert_str_equals('No messages set', $msg);
	my $msgT = $kiwi -> getMessageType();
	$this -> assert_str_equals('none', $msgT);
	my $state = $kiwi -> getState();
	$this -> assert_str_equals('No state set', $state);
	# Test this condition last to get potential error messages
	$this -> assert_str_equals('true', $value);
}

#==========================================
# test_getOEMSwap
#------------------------------------------
sub test_getOEMSwap {
	# ...
	# Verify proper return of getOEMSwap method
	# ---
	my $this = shift;
	my $kiwi = $this -> {kiwi};
	my $confDir = $this->{dataDir} . 'oemSettings';
	my $xml = new KIWIXML(
		$this -> {kiwi}, $confDir, undef, undef,$this->{cmdL}
	);
	my $value = $xml -> getOEMSwap();
	my $msg = $kiwi -> getMessage();
	$this -> assert_str_equals('No messages set', $msg);
	my $msgT = $kiwi -> getMessageType();
	$this -> assert_str_equals('none', $msgT);
	my $state = $kiwi -> getState();
	$this -> assert_str_equals('No state set', $state);
	# Test this condition last to get potential error messages
	$this -> assert_str_equals('true', $value);
}

#==========================================
# test_getOEMSwapSize
#------------------------------------------
sub test_getOEMSwapSize {
	# ...
	# Verify proper return of getOEMSwapSize method
	# ---
	my $this = shift;
	my $kiwi = $this -> {kiwi};
	my $confDir = $this->{dataDir} . 'oemSettings';
	my $xml = new KIWIXML(
		$this -> {kiwi}, $confDir, undef, undef,$this->{cmdL}
	);
	my $value = $xml -> getOEMSwapSize();
	my $msg = $kiwi -> getMessage();
	$this -> assert_str_equals('No messages set', $msg);
	my $msgT = $kiwi -> getMessageType();
	$this -> assert_str_equals('none', $msgT);
	my $state = $kiwi -> getState();
	$this -> assert_str_equals('No state set', $state);
	# Test this condition last to get potential error messages
	$this -> assert_str_equals('2048', $value);
}

#==========================================
# test_getOEMSystemSize
#------------------------------------------
sub test_getOEMSystemSize {
	# ...
	# Verify proper return of getOEMSystemSize method
	# ---
	my $this = shift;
	my $kiwi = $this -> {kiwi};
	my $confDir = $this->{dataDir} . 'oemSettings';
	my $xml = new KIWIXML(
		$this -> {kiwi}, $confDir, undef, undef,$this->{cmdL}
	);
	my $value = $xml -> getOEMSystemSize();
	my $msg = $kiwi -> getMessage();
	$this -> assert_str_equals('No messages set', $msg);
	my $msgT = $kiwi -> getMessageType();
	$this -> assert_str_equals('none', $msgT);
	my $state = $kiwi -> getState();
	$this -> assert_str_equals('No state set', $state);
	# Test this condition last to get potential error messages
	$this -> assert_str_equals('20G', $value);
}

#==========================================
# test_getOEMUnattended
#------------------------------------------
sub test_getOEMUnattended {
	# ...
	# Verify proper return of getOEMUnattended method
	# ---
	my $this = shift;
	my $kiwi = $this -> {kiwi};
	my $confDir = $this->{dataDir} . 'oemSettings';
	my $xml = new KIWIXML(
		$this -> {kiwi}, $confDir, undef, undef,$this->{cmdL}
	);
	my $value = $xml -> getOEMUnattended();
	my $msg = $kiwi -> getMessage();
	$this -> assert_str_equals('No messages set', $msg);
	my $msgT = $kiwi -> getMessageType();
	$this -> assert_str_equals('none', $msgT);
	my $state = $kiwi -> getState();
	$this -> assert_str_equals('No state set', $state);
	# Test this condition last to get potential error messages
	$this -> assert_str_equals('true', $value);
}

#==========================================
# test_getOEMUnattendedID
#------------------------------------------
sub test_getOEMUnattendedID {
	# ...
	# Verify proper return of getOEMUnattendedID method
	# ---
	my $this = shift;
	my $kiwi = $this -> {kiwi};
	my $confDir = $this->{dataDir} . 'oemSettings';
	my $xml = new KIWIXML(
		$this -> {kiwi}, $confDir, undef, undef,$this->{cmdL}
	);
	my $value = $xml -> getOEMUnattendedID();
	my $msg = $kiwi -> getMessage();
	$this -> assert_str_equals('No messages set', $msg);
	my $msgT = $kiwi -> getMessageType();
	$this -> assert_str_equals('none', $msgT);
	my $state = $kiwi -> getState();
	$this -> assert_str_equals('No state set', $state);
	# Test this condition last to get potential error messages
	$this -> assert_str_equals('scsi-SATA_ST9500420AS_5VJ5JL6T-part1', $value);
}

#==========================================
# test_getPXEDeployBlockSize
#------------------------------------------
sub test_getPXEDeployBlockSize {
	# ...
	# Verify proper return of getPXEDeployBlockSize method
	# ---
	my $this = shift;
	my $kiwi = $this -> {kiwi};
	my $confDir = $this->{dataDir} . 'pxeSettings';
	my $xml = new KIWIXML(
		$this -> {kiwi}, $confDir, undef, undef,$this->{cmdL}
	);
	my $value = $xml -> getPXEDeployBlockSize();
	my $msg = $kiwi -> getMessage();
	$this -> assert_str_equals('No messages set', $msg);
	my $msgT = $kiwi -> getMessageType();
	$this -> assert_str_equals('none', $msgT);
	my $state = $kiwi -> getState();
	$this -> assert_str_equals('No state set', $state);
	# Test this condition last to get potential error messages
	$this -> assert_str_equals('4096', $value);
}

#==========================================
# test_getPXEDeployConfiguration
#------------------------------------------
sub test_getPXEDeployConfiguration {
	# ...
	# Verify proper return of getPXEDeployConfiguration method
	# ---
	my $this = shift;
	my $kiwi = $this -> {kiwi};
	my $confDir = $this->{dataDir} . 'pxeSettings';
	my $xml = new KIWIXML(
		$this -> {kiwi}, $confDir, undef, undef,$this->{cmdL}
	);
	my %config = $xml -> getPXEDeployConfiguration();
	my $msg = $kiwi -> getMessage();
	$this -> assert_str_equals('No messages set', $msg);
	my $msgT = $kiwi -> getMessageType();
	$this -> assert_str_equals('none', $msgT);
	my $state = $kiwi -> getState();
	$this -> assert_str_equals('No state set', $state);
	# Test this condition last to get potential error messages
	$this -> assert_not_null(%config);
	$this -> assert_str_equals('target', $config{installSource});
}

#==========================================
# test_getPXEDeployImageDevice
#------------------------------------------
sub test_getPXEDeployImageDevice {
	# ...
	# Verify proper return of getPXEDeployImageDevice method
	# ---
	my $this = shift;
	my $kiwi = $this -> {kiwi};
	my $confDir = $this->{dataDir} . 'pxeSettings';
	my $xml = new KIWIXML(
		$this -> {kiwi}, $confDir, undef, undef,$this->{cmdL}
	);
	my $value = $xml -> getPXEDeployImageDevice();
	my $msg = $kiwi -> getMessage();
	$this -> assert_str_equals('No messages set', $msg);
	my $msgT = $kiwi -> getMessageType();
	$this -> assert_str_equals('none', $msgT);
	my $state = $kiwi -> getState();
	$this -> assert_str_equals('No state set', $state);
	# Test this condition last to get potential error messages
	$this -> assert_str_equals('/dev/sda', $value);
}

#==========================================
# test_getPXEDeployInitrd
#------------------------------------------
sub test_getPXEDeployInitrd {
	# ...
	# Verify proper return of getPXEDeployInitrd method
	# ---
	my $this = shift;
	my $kiwi = $this -> {kiwi};
	my $confDir = $this->{dataDir} . 'pxeSettings';
	my $xml = new KIWIXML(
		$this -> {kiwi}, $confDir, undef, undef,$this->{cmdL}
	);
	my $value = $xml -> getPXEDeployInitrd();
	my $msg = $kiwi -> getMessage();
	$this -> assert_str_equals('No messages set', $msg);
	my $msgT = $kiwi -> getMessageType();
	$this -> assert_str_equals('none', $msgT);
	my $state = $kiwi -> getState();
	$this -> assert_str_equals('No state set', $state);
	# Test this condition last to get potential error messages
	$this -> assert_str_equals('/pxeSetup/specialInitrd', $value);
}

#==========================================
# test_getPXEDeployKernel
#------------------------------------------
sub test_getPXEDeployKernel {
	# ...
	# Verify proper return of getPXEDeployKernel method
	# ---
	my $this = shift;
	my $kiwi = $this -> {kiwi};
	my $confDir = $this->{dataDir} . 'pxeSettings';
	my $xml = new KIWIXML(
		$this -> {kiwi}, $confDir, undef, undef,$this->{cmdL}
	);
	my $value = $xml -> getPXEDeployKernel();
	my $msg = $kiwi -> getMessage();
	$this -> assert_str_equals('No messages set', $msg);
	my $msgT = $kiwi -> getMessageType();
	$this -> assert_str_equals('none', $msgT);
	my $state = $kiwi -> getState();
	$this -> assert_str_equals('No state set', $state);
	# Test this condition last to get potential error messages
	$this -> assert_str_equals('/pxeSetup/specialKernel', $value);
}

#==========================================
# test_getPXEDeployPartitions
#------------------------------------------
sub test_getPXEDeployPartitions {
	# ...
	# Verify proper return of getPXEDeployPartitions method
	# ---
	my $this = shift;
	my $kiwi = $this -> {kiwi};
	my $confDir = $this->{dataDir} . 'pxeSettings';
	my $xml = new KIWIXML(
		$this -> {kiwi}, $confDir, undef, undef,$this->{cmdL}
	);
	my @partitions = $xml -> getPXEDeployPartitions();
	my $msg = $kiwi -> getMessage();
	$this -> assert_str_equals('No messages set', $msg);
	my $msgT = $kiwi -> getMessageType();
	$this -> assert_str_equals('none', $msgT);
	my $state = $kiwi -> getState();
	$this -> assert_str_equals('No state set', $state);
	# Test these conditions last to get potential error messages
	$this -> assert_not_null(@partitions);
	my $partInfo = $partitions[0];
	$this -> assert_str_equals('swap', $partInfo -> {type});
	$this -> assert_str_equals('1', $partInfo -> {number});
	$this -> assert_str_equals('5', $partInfo -> {size});
	$partInfo = $partitions[1];
	$this -> assert_str_equals('/', $partInfo -> {mountpoint});
	$this -> assert_equals(1, $partInfo -> {target});
}

#==========================================
# test_getPXEDeployServer
#------------------------------------------
sub test_getPXEDeployServer {
	# ...
	# Verify proper return of getPXEDeployServer method
	# ---
	my $this = shift;
	my $kiwi = $this -> {kiwi};
	my $confDir = $this->{dataDir} . 'pxeSettings';
	my $xml = new KIWIXML(
		$this -> {kiwi}, $confDir, undef, undef,$this->{cmdL}
	);
	my $value = $xml -> getPXEDeployServer();
	my $msg = $kiwi -> getMessage();
	$this -> assert_str_equals('No messages set', $msg);
	my $msgT = $kiwi -> getMessageType();
	$this -> assert_str_equals('none', $msgT);
	my $state = $kiwi -> getState();
	$this -> assert_str_equals('No state set', $state);
	# Test this condition last to get potential error messages
	$this -> assert_str_equals('192.168.100.2', $value);
}

#==========================================
# test_getPXEDeployTimeout
#------------------------------------------
sub test_getPXEDeployTimeout {
	# ...
	# Verify proper return of getPXEDeployTimeout method
	# ---
	my $this = shift;
	my $kiwi = $this -> {kiwi};
	my $confDir = $this->{dataDir} . 'pxeSettings';
	my $xml = new KIWIXML(
		$this -> {kiwi}, $confDir, undef, undef,$this->{cmdL}
	);
	my $value = $xml -> getPXEDeployTimeout();
	my $msg = $kiwi -> getMessage();
	$this -> assert_str_equals('No messages set', $msg);
	my $msgT = $kiwi -> getMessageType();
	$this -> assert_str_equals('none', $msgT);
	my $state = $kiwi -> getState();
	$this -> assert_str_equals('No state set', $state);
	# Test this condition last to get potential error messages
	$this -> assert_str_equals('20', $value);
}

#==========================================
# test_getPXEDeployUnionConfig
#------------------------------------------
sub test_getPXEDeployUnionConfig {
	# ...
	# Verify proper return of getPXEDeployUnionConfig method
	# ---
	my $this = shift;
	my $kiwi = $this -> {kiwi};
	my $confDir = $this->{dataDir} . 'pxeSettings';
	my $xml = new KIWIXML(
		$this -> {kiwi}, $confDir, undef, undef,$this->{cmdL}
	);
	my %unionConfig = $xml -> getPXEDeployUnionConfig();
	my $msg = $kiwi -> getMessage();
	$this -> assert_str_equals('No messages set', $msg);
	my $msgT = $kiwi -> getMessageType();
	$this -> assert_str_equals('none', $msgT);
	my $state = $kiwi -> getState();
	$this -> assert_str_equals('No state set', $state);
	# Test these conditions last to get potential error messages
	$this -> assert_not_null(%unionConfig);
	$this -> assert_str_equals('/dev/sda2', $unionConfig{ro});
	$this -> assert_str_equals('/dev/sda3', $unionConfig{rw});
	$this -> assert_str_equals('clicfs', $unionConfig{type});
}

#==========================================
# test_getRPMCheckSignatures
#------------------------------------------
sub test_getRPMCheckSignaturesFalse {
	# ...
	# Verify proper return of getRPMCheckSignatures method
	# ---
	my $this = shift;
	my $kiwi = $this -> {kiwi};
	my $confDir = $this->{dataDir} . 'oemSettings';
	my $xml = new KIWIXML(
		$this -> {kiwi}, $confDir, undef, undef,$this->{cmdL}
	);
	my $value = $xml -> getRPMCheckSignatures();
	my $msg = $kiwi -> getMessage();
	$this -> assert_str_equals('No messages set', $msg);
	my $msgT = $kiwi -> getMessageType();
	$this -> assert_str_equals('none', $msgT);
	my $state = $kiwi -> getState();
	$this -> assert_str_equals('No state set', $state);
	# Test this condition last to get potential error messages
	$this -> assert_null($value);
}

#==========================================
# test_getRPMExcludeDocs
#------------------------------------------
sub test_getRPMExcludeDocsFalse {
	# ...
	# Verify proper return of getRPMExcludeDocs method
	# ---
	my $this = shift;
	my $kiwi = $this -> {kiwi};
	my $confDir = $this->{dataDir} . 'oemSettings';
	my $xml = new KIWIXML(
		$this -> {kiwi}, $confDir, undef, undef,$this->{cmdL}
	);
	my $value = $xml -> getRPMExcludeDocs();
	my $msg = $kiwi -> getMessage();
	$this -> assert_str_equals('No messages set', $msg);
	my $msgT = $kiwi -> getMessageType();
	$this -> assert_str_equals('none', $msgT);
	my $state = $kiwi -> getState();
	$this -> assert_str_equals('No state set', $state);
	# Test this condition last to get potential error messages
	$this -> assert_null($value);
}

#==========================================
# test_getRPMForce
#------------------------------------------
sub test_getRPMForceFalse {
	# ...
	# Verify proper return of getRPMForce method
	# ---
	my $this = shift;
	my $kiwi = $this -> {kiwi};
	my $confDir = $this->{dataDir} . 'oemSettings';
	my $xml = new KIWIXML(
		$this -> {kiwi}, $confDir, undef, undef,$this->{cmdL}
	);
	my $value = $xml -> getRPMForce();
	my $msg = $kiwi -> getMessage();
	$this -> assert_str_equals('No messages set', $msg);
	my $msgT = $kiwi -> getMessageType();
	$this -> assert_str_equals('none', $msgT);
	my $state = $kiwi -> getState();
	$this -> assert_str_equals('No state set', $state);
	# Test this condition last to get potential error messages
	$this -> assert_null($value);
}

#==========================================
# test_getRPMCheckSignatures
#------------------------------------------
sub test_getRPMCheckSignaturesTrue {
	# ...
	# Verify proper return of getRPMCheckSignatures method
	# ---
	my $this = shift;
	my $kiwi = $this -> {kiwi};
	my $confDir = $this->{dataDir} . 'preferenceSettings';
	my $xml = new KIWIXML(
		$this -> {kiwi}, $confDir, undef, undef,$this->{cmdL}
	);
	my $value = $xml -> getRPMCheckSignatures();
	my $msg = $kiwi -> getMessage();
	$this -> assert_str_equals('No messages set', $msg);
	my $msgT = $kiwi -> getMessageType();
	$this -> assert_str_equals('none', $msgT);
	my $state = $kiwi -> getState();
	$this -> assert_str_equals('No state set', $state);
	# Test this condition last to get potential error messages
	$this -> assert_str_equals('true', $value);
}

#==========================================
# test_getRPMExcludeDocs
#------------------------------------------
sub test_getRPMExcludeDocsTrue {
	# ...
	# Verify proper return of getRPMExcludeDocs method
	# ---
	my $this = shift;
	my $kiwi = $this -> {kiwi};
	my $confDir = $this->{dataDir} . 'preferenceSettings';
	my $xml = new KIWIXML(
		$this -> {kiwi}, $confDir, undef, undef,$this->{cmdL}
	);
	my $value = $xml -> getRPMExcludeDocs();
	my $msg = $kiwi -> getMessage();
	$this -> assert_str_equals('No messages set', $msg);
	my $msgT = $kiwi -> getMessageType();
	$this -> assert_str_equals('none', $msgT);
	my $state = $kiwi -> getState();
	$this -> assert_str_equals('No state set', $state);
	# Test this condition last to get potential error messages
	$this -> assert_str_equals('true', $value);
}

#==========================================
# test_getRPMForce
#------------------------------------------
sub test_getRPMForceTrue {
	# ...
	# Verify proper return of getRPMForce method
	# ---
	my $this = shift;
	my $kiwi = $this -> {kiwi};
	my $confDir = $this->{dataDir} . 'preferenceSettings';
	my $xml = new KIWIXML(
		$this -> {kiwi}, $confDir, undef, undef,$this->{cmdL}
	);
	my $value = $xml -> getRPMForce();
	my $msg = $kiwi -> getMessage();
	$this -> assert_str_equals('No messages set', $msg);
	my $msgT = $kiwi -> getMessageType();
	$this -> assert_str_equals('none', $msgT);
	my $state = $kiwi -> getState();
	$this -> assert_str_equals('No state set', $state);
	# Test this condition last to get potential error messages
	$this -> assert_str_equals('true', $value);
}


#==========================================
# test_getSplitPersistentExceptions
#------------------------------------------
sub test_getSplitPersistentExceptions {
	# ...
	# Verify proper return of getSplitPersistentExceptions method
	# ---
	my $this = shift;
	my $kiwi = $this -> {kiwi};
	my $confDir = $this->{dataDir} . 'splitSettings';
	my $xml = new KIWIXML(
		$this -> {kiwi}, $confDir, undef, undef,$this->{cmdL}
	);
	my @persExcept = $xml -> getSplitPersistentExceptions();
	my $msg = $kiwi -> getMessage();
	$this -> assert_str_equals('No messages set', $msg);
	my $msgT = $kiwi -> getMessageType();
	$this -> assert_str_equals('none', $msgT);
	my $state = $kiwi -> getState();
	$this -> assert_str_equals('No state set', $state);
	# Test this condition last to get potential error messages
	my @expectedExcept = qw / bar /;
	$this -> assert_array_equal(\@expectedExcept, \@persExcept);
}

#==========================================
# test_getSplitPersistentFiles
#------------------------------------------
sub test_getSplitPersistentFiles {
	# ...
	# Verify proper return of getSplitPersistentFiles method
	# ---
	my $this = shift;
	my $kiwi = $this -> {kiwi};
	my $confDir = $this->{dataDir} . 'splitSettings';
	my $xml = new KIWIXML(
		$this -> {kiwi}, $confDir, undef, undef,$this->{cmdL}
	);
	my @persFiles = $xml -> getSplitPersistentFiles();
	my $msg = $kiwi -> getMessage();
	$this -> assert_str_equals('No messages set', $msg);
	my $msgT = $kiwi -> getMessageType();
	$this -> assert_str_equals('none', $msgT);
	my $state = $kiwi -> getState();
	$this -> assert_str_equals('No state set', $state);
	# Test this condition last to get potential error messages
	my @expectedNames = qw /bar64 genericBar/;
	$this -> assert_array_equal(\@expectedNames, \@persFiles);
}

#==========================================
# test_getSplitTempExceptions
#------------------------------------------
sub test_getSplitTempExceptions {
	# ...
	# Verify proper return of getSplitTempExceptions method
	# ---
	my $this = shift;
	my $kiwi = $this -> {kiwi};
	my $confDir = $this->{dataDir} . 'splitSettings';
	my $xml = new KIWIXML(
		$this -> {kiwi}, $confDir, undef, undef,$this->{cmdL}
	);
	my @tmpExcept = $xml -> getSplitTempExceptions();
	my $msg = $kiwi -> getMessage();
	$this -> assert_str_equals('No messages set', $msg);
	my $msgT = $kiwi -> getMessageType();
	$this -> assert_str_equals('none', $msgT);
	my $state = $kiwi -> getState();
	$this -> assert_str_equals('No state set', $state);
	# Test this condition last to get potential error messages
	my @expectedExcept = qw /foo anotherFoo/;
	$this -> assert_array_equal(\@expectedExcept, \@tmpExcept);
}

#==========================================
# test_getSplitTempFiles
#------------------------------------------
sub test_getSplitTempFiles {
	# ...
	# Verify proper return of getSplitTempFiles method
	# ---
	my $this = shift;
	my $kiwi = $this -> {kiwi};
	my $confDir = $this->{dataDir} . 'splitSettings';
	my $xml = new KIWIXML(
		$this -> {kiwi}, $confDir, undef, undef,$this->{cmdL}
	);
	my @tmpFiles = $xml -> getSplitTempFiles();
	my $msg = $kiwi -> getMessage();
	$this -> assert_str_equals('No messages set', $msg);
	my $msgT = $kiwi -> getMessageType();
	$this -> assert_str_equals('none', $msgT);
	my $state = $kiwi -> getState();
	$this -> assert_str_equals('No state set', $state);
	# Test this condition last to get potential error messages
	my @expectedNames = qw /foo64 genericFoo/;
	$this -> assert_array_equal(\@expectedNames, \@tmpFiles);
}


#==========================================
# test_packageManagerInfoHasConfigValue
#------------------------------------------
sub test_packageManagerInfoHasConfigValue {
	# ...
	# Verify that the default package manager is provided if no package manager
	# is set in the configuration
	# ---
	my $this = shift;
	my $kiwi = $this -> {kiwi};
	my $confDir = $this->{dataDir} . 'specPkgMgr';
	my $xml = new KIWIXML(
		$this -> {kiwi}, $confDir, undef, undef,$this->{cmdL}
	);
	my $pkgMgr = $xml -> getPackageManager();
	$this -> assert_str_equals('zypper', $pkgMgr);
	my $msg = $kiwi -> getMessage();
	$this -> assert_str_equals('No messages set', $msg);
	my $msgT = $kiwi -> getMessageType();
	$this -> assert_str_equals('none', $msgT);
	my $state = $kiwi -> getState();
	$this -> assert_str_equals('No state set', $state);
}

#==========================================
# test_packageManagerSet_noArg
#------------------------------------------
sub test_packageManagerSet_noArg {
	# ...
	# Verify of setPackageManager method error condition
	# ---
	my $this = shift;
	my $kiwi = $this -> {kiwi};
	my $confDir = $this->{dataDir} . 'specPkgMgr';
	my $xml = new KIWIXML(
		$this -> {kiwi}, $confDir, undef, undef,$this->{cmdL}
	);
	# Call set without argument, expect error
	my $res = $xml -> setPackageManager();
	my $msg = $kiwi -> getMessage();
	my $expectedMsg = 'setPackageManager method called without specifying '
		. 'package manager value.';
	$this -> assert_str_equals($expectedMsg, $msg);
	my $msgT = $kiwi -> getMessageType();
	$this -> assert_str_equals('error', $msgT);
	my $state = $kiwi -> getState();
	$this -> assert_str_equals('failed', $state);
	# Test this condition last to get potential error messages
	$this -> assert_null($res);
}

#==========================================
# test_packageManagerSet_noArg
#------------------------------------------
sub test_packageManagerSet_valid {
	# ...
	# Verify setPackageManager works as expected
	# ---
	my $this = shift;
	my $kiwi = $this -> {kiwi};
	my $confDir = $this->{dataDir} . 'specPkgMgr';
	my $xml = new KIWIXML(
		$this -> {kiwi}, $confDir, undef, undef,$this->{cmdL}
	);
	# Set the package manager to be smart
	my $res = $xml -> setPackageManager('smart');
	my $msg = $kiwi -> getMessage();
	$this -> assert_str_equals('No messages set', $msg);
	my $msgT = $kiwi -> getMessageType();
	$this -> assert_str_equals('none', $msgT);
	my $state = $kiwi -> getState();
	$this -> assert_str_equals('No state set', $state);
	# Test this condition last to get potential error messages
	$this -> assert_not_null($res);
	my $newPkgMgr = $xml -> getPackageManager();
	$this -> assert_str_equals('smart', $newPkgMgr);
}

#==========================================
# test_packageManagerInfoHasProfs
#------------------------------------------
sub test_packageManagerInfoHasProfs {
	# ...
	# Verify package manager override works as expected
	# ---
	my $this = shift;
	my $kiwi = $this -> {kiwi};
	my $confDir = $this->{dataDir} . 'multiPkgMgrWithProf';
	my @profiles = ('specPkgMgr');
	# Verify we get the specified manager
	my $xml = new KIWIXML(
		$this -> {kiwi}, $confDir, undef,\@profiles,$this->{cmdL}
	);
	my $pkgMgr = $xml -> getPackageManager();
	$this -> assert_str_equals('smart', $pkgMgr);
	my $msg = $kiwi -> getMessage();
	$this -> assert_str_equals('Using profile(s): specPkgMgr', $msg);
	my $msgT = $kiwi -> getMessageType();
	$this -> assert_str_equals('info', $msgT);
	my $state = $kiwi -> getState();
	$this -> assert_str_equals('completed', $state);
	# Override the specified package manager with yum
	my $res = $xml -> setPackageManager('yum');
	$msg = $kiwi -> getMessage();
	$this -> assert_str_equals('No messages set', $msg);
	$msgT = $kiwi -> getMessageType();
	$this -> assert_str_equals('none', $msgT);
	$state = $kiwi -> getState();
	$this -> assert_str_equals('No state set', $state);
	# Test this condition last to get potential error messages
	$this -> assert_not_null($res);
	my $newPkgMgr = $xml -> getPackageManager();
	$this -> assert_str_equals('yum', $newPkgMgr);
}

1;
