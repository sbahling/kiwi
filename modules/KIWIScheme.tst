<!-- TEST XML SCHEME FOR KIWI -->

<image name="bob">

	<preferences>
		<type>ext3</type>
		<size unit="M">460</size>
		<rpm-check-signatures>False</rpm-check-signatures>
		<packagemanager>smart</packagemanager>
	</preferences>

	<users group="users">
		<user name="linux" pwd="$2a$10$90AjhfXU2YIwTRrIftBauecvWXVuaNZ6JLM2IpWi0svu2kO16le9e" home="/home/linux"/>
	</users>

	<drivers type="drivers">
        <file name="drivers/ide/*"/>
	</drivers>

	<repository type="yast2">
		<source path="/image/dist/full-10.2-i386"/>
	</repository>

	<deploy>
		<partitions device="/dev/sda">
			<partition type="bla" number="2" size="200"/>
		</partitions>
	</deploy>

	<packages type="image">
		<package name="libgnomesu"/>
		<package name="ICAClient"/>
	</packages>

	<packages type="xen">
		<package name="kernel-xen"/>
		<package name="xen"/>
	</packages>

	<packages type="boot">
		<package name="filesystem"/>
		<package name="glibc-locale"/>
		<package name="devs"/>
		<package name="rpm"/>
	</packages>

</image>
