### Changing Permissions with `chmod` (Numbers)

- **chmod**: Command to change file permissions
- **r** (read) = 4
- **w** (write) = 2
- **x** (execute) = 1

To easily understand and summarize:
- `100 = 4`
- `10 = 2`
- `1 = 1`

**Example:**
- `chmod 777 file`: This command gives full permission to user, group, and others.

- You can use the **-R** flag to apply permissions to all files in a directory.

**Example:**
- `chmod -R 777 /home`: Gives full permissions to all files in /home.

### Using Characters to Set Permissions

**Example:**
- `chmod a-w file`: Removes write permission for all (user, group, others).
- `chmod u+rw file`: Adds read and write permissions for the user.
- `chmod -R o-w $HOME/myapps`: Recursively removes write permission for others in $HOME/myapps.

This method of using characters is often more understandable than numbers.

### Default Permissions with `umask`

- Default permissions are defined by the `umask` variable.
- Change the default permissions with `umask xxx`.

### Changing File Ownership with `chown`

**Example:**
- `chown -R user:group file`: Changes the owner and group of the file.

### Moving Files with `mv`

**Example:**
- `mv -i source destination`: Use the **-i** flag to prompt before overwriting.

### Copying Files with `cp`

**Example:**
- `cp -rai source destination`: Use the **-r** flag for recursive copy, **-a** to maintain date/time stamps and permissions, and **-i** to prevent overwriting.

### Removing Directories and Files

**Example:**
- `rmdir /home/joe/nothing/`: Removes an empty directory.
- `rm -r /home/joe/bigdir/`: Deletes all contents of a directory, prompts if not empty.
- `rm -rf /home/joe/hugedir/`: Deletes all contents of a directory without prompts.