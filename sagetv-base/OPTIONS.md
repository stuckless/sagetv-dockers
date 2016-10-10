# Configuration Details for the Docker Container

## Environment Options

### OPT_GENTUNER
`Y/N` Install gentuner plugin for external STB tuning. See https://github.com/jwittkoski/GenericTunerPlugin

### OPT_LIRC `new`
`Y/N` Install/Start LIRC Daemon.  This will configure and set permissions for `/dev/lirc*`. If `SAGE_HOME/lirc.d/hardware.conf` exists, then it will be copied to `/etc/lirc.d/` and if `SAGEHOME/lirc.d/lircd.conf` exists, it will be copied to `/etc/lirc.d/`.  If `SAGE_HOME/lirc.d/gentuner.lirc` exists, it will be copied to `gentuner` in the `SAGE_HOME` dir and used of the `GENTUNER` script for LIRC.

### OPT_COMSKIP
`Y/N` Install linux comskip binaries.  Note this does not configure comskip or install the SageTV plugins.  It just adds the binaries for comskip.

### OPT_SETPERMS `new`
`Y/N` Set all permissions on all SageTV files and media on startup.  Can be slow, but use it if you have permission issues.

### OPT_COMMANDIR (deprecated)
`Y/N` Install commandIR tools to using commandIR to tune STB.  It appears the CommandIR is no longer in business.

### PUID
Numeric USERID of SageTV instance.  Default `99`.  This should be the real userid on the host system.

### PGID
Numeric GROUPID of SageTV instance. Default `100`.  This should be the real groupid on the host system.

### VIDEO_GUID
Numeric GROUPID of the `video` group that owns the /dev/video0 device on the host system.  Default `18`.  This should be the real group id on the host system.

### LICENCE_DATA
SageTV licence key

### JAVA_MEM_MB
The amount of memory to give to SageTV process.  ie, setting `1024` will set the JVM memory to `1024 mb`

### VERSION `new`
If set to `latest` it will use the most current version of sagetv (Default: `latest`).  You can also set it to a specific version, such as, `9.0.4.287`, `9.0.4.252`, etc.  If you set a version, it MUST be a valid sagetv version #.  Setting a version will mean that SageTV will never update until you change the `VERSION` manually.

## Upgrading Notes
When the script performs an update, it will backup the `Sage.jar`, `Sage.properties` and the `Wiz.bin` to the `backups` folder using the current date/time as the backup directory.  It is not a full backup, but rather just a backup of the important configuration files.

