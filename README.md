# Jellyfin Scripts

## Port Scripts

Ports taken from [Jellyfin: Networking Documentation](https://jellyfin.org/docs/general/networking/index.html)

### Open/Close Ports via UFW for private networks

To open ports for private subnets execute: `sudo ./ufw-open-ports.bash`
To close ports for private subnets execute: `sudo ./ufw-close-ports.bash`

### Conditional Service Start

Start jellyfin service when the data/media directory is present.
This is to prevent scheduled library scans from deleting the library, when we
forgot to mount it.
* `systemctl edit jellyfin.service`
*
```
[Unit]
# Check read permission
ExecStartPre=/bin/sh -c 'sudo -u jellyfin ls /path/to/media >/dev/null 2>&1'
# Check that directory or mount point exists
ConditionPathExists=/path/to/media
# Check that certain directories are not empty
ConditionDirectoryNotEmpty=/path/to/media/subpath
```
* Save & Exit
