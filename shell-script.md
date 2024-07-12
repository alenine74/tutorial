#### Shell Script

A shell script is a file containing multiple commands that can be executed together.

You can run multiple commands in one file in two ways:
1. Just write your commands and run the file:
   ```bash
   bash file.sh
   ```
2. Set the shebang line (e.g., `#!/bin/bash`), make the file executable, and then run it:
   ```bash
   chmod +x file.sh
   ./file.sh
   ```

#### Debugging Your Shell Script

You can enable debugging by setting `+x` at the beginning of your file:
```bash
set -x
```
Or include it in the shebang line:
```bash
#!/bin/bash -x
```
Or run the script with debugging enabled:
```bash
bash -x file.sh
```

Additionally, you can use `echo` to output specific variables or checkpoints within your script.

#### Understanding Shell Variables

Assign a value to a variable without spaces between `=` and the value:
```bash
NAME=value
```

### Special Shell Positional Parameters

- `$1`, `$2`, ...: Positional parameters representing the arguments passed to the script.
- `$0`: The name of the script.
- `$#`: The number of positional parameters.
- `$@`: All the positional parameters as a single word.
- `$?`: The exit status of the last executed command.

**Example:**
```bash
echo "The first argument is $1, the second is $2"
echo "The command itself is called $0"
echo "There are $# parameters on your command line"
echo "Here are all the arguments: $@"
echo "This is the exit status of the last command: $?"
```

### Reading in Parameters

You can read arguments from the user within your script.

### Parameter Expansion in Bash

- `${var:-value}`: If `var` is unset or empty, expand to `value`.
- `${var#pattern}`: Remove the shortest match for `pattern` from the beginning of `var`’s value.
- `${var##pattern}`: Remove the longest match for `pattern` from the beginning of `var`’s value.
- `${var%pattern}`: Remove the shortest match for `pattern` from the end of `var`’s value.
- `${var%%pattern}`: Remove the longest match for `pattern` from the end of `var`’s value.


### importent operators

OperatorWhat Is Being Tested?
-a fileDoes the file exist? (same as -e)
-b fileIs the file a block special device?
-c fileIs the file character special (for example, a character device)? Used to
identify serial lines and terminal devices.
-d fileIs the file a directory?
-e fileDoes the file exist? (same as -a)
-f fileDoes the file exist, and is it a regular file (for example, not a directory,
socket, pipe, link, or device file)?
-g fileDoes the file have the set group id (SGID) bit set?
-h fileIs the file a symbolic link? (same as -L)
-k fileDoes the file have the sticky bit set?
-L fileIs the file a symbolic link?
-n stringIs the length of the string greater than 0 bytes?
-O fileDo you own the file?
-p fileIs the file a named pipe?
-r fileIs the file readable by you?
-s fileDoes the file exist, and is it larger than 0 bytes?
-S fileDoes the file exist, and is it a socket?
-t fdIs the file descriptor connected to a terminal?
-u fileDoes the file have the set user id (SUID) bit set?
-w fileIs the file writable by you?
-x fileIs the file executable by you?
-z stringIs the length of the string 0 (zero) bytes?
expr1 -a expr2Are both the first expression and the second expression true?
expr1 -o expr2Is either of the two expressions true?
file1 -nt file2Is the first file newer than the second file (using the modification
time stamp)?
file1 -ot file2Is the first file older than the second file (using the modification
time stamp)?
file1 -ef file2Are the two files associated by a link (a hard link or a symbolic link)?
var1 = var2Is the first variable equal to the second variable?
var1 -eq var2Is the first variable equal to the second variable?
var1 -ge var2Is the first variable greater than or equal to the second variable?



[] ===> is give us 0(true) or 1(false)


#### case command

case "VAR" in 
   R1)
   {body};;
   R2)
   {body};;
   *)
   {{body}};;
esac

### for loop

for FILE in `/bin/ls`
do
echo $FILE
done

while condition
do
{ body }
done

until condition
do
{ body }
done

#### tr command

tr ===> its to translate and delete chars

tr a A ===> for ex it is change all a to A

tr -d a ===> delete all a

tr -s a ===> delete all double a to single a

