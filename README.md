# Algov utils
The bash scripts I wrote for my servers

## backup.sh
It backs up mysql databases, /etc and compresses it with the GZIP format into an archive file.

### Configuration
`ARCHIVE_FILE`: the name of the archive that will be created

`TEMP_DIR`: the temporary directory used by the backup script. **CAUTION**: do not put a directory that is already used by a few apps; It must be a unique one for the script.

`ARCHIVE_DIR`: the directory where the archive files will be put. If a file has the same name as the `ARCHIVE_FILE` parameter, it will be overwritten.

### Installation
You may want to add this script to the crontab of your server with

```sh
crontab -e
```

by adding the line ` 30  1  *   *   *    /path/to/backup.sh`
