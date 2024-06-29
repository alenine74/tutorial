### VI and VIM Commands

- **a**: Insert to the right of the cursor
- **i**: Insert to the left of the cursor
- **A**: Insert at the end of the line
- **I**: Insert at the beginning of the command
- **o**: Insert below the current line
- **O**: Insert above the current line

##### Moving Around in the Text

- **h**: Move left
- **l**: Move right
- **j**: Move down
- **k**: Move up
- **w**: Move the cursor to the beginning of the next word
- **b**: Move the cursor to the beginning of the previous word
- **0**: Move the cursor to the beginning of the current line
- **$**: Move the cursor to the end of the line
- **H**: Move the cursor to the first line of the screen
- **L**: Move the cursor to the last line of the screen

##### Deleting, Copying, and Changing Text

- **yy**: Copy the current line
- **dd**: Cut the current line (can paste with **p**)
- **yG**: Copy all lines after the current one
- **gg**: Go to the first line of the page
- **dG**: Cut all lines after the current one
- **u**: Undo
- **Ctrl+R**: Redo

###### Finding Files

- **find** command and **locate** command:
  - **locate** uses a database
  - **find** does not use a database

- **find** command:
  - The common flag in the find command is **-ls**, which works like **ls -l**.
  - It's useful to add `2> /dev/null` at the end of commands to suppress errors.

##### Finding Files by Name

- `find /etc -name x`: Finds the file named "x"
- Use **-iname** to ignore case sensitivity

#### Finding Files by User

- `find /home -user ali -ls`: Finds files by user "ali"
- `find /home -not -user root`: Finds files by all users except root

- `find -perm /222 -type f`: Searches for files with permission 222 (use **-type d** for directories)
- `find /etc/ -mmin -10`: Finds files edited within the last 10 minutes

##### OK & EXEC Commands

- Use **-exec** to execute a command for each result:
  - `find /etc -iname passwd -exec echo "I found {}" \;`
- Use **-ok** to ask for confirmation before executing a command for each result:
  - `find /var/allusers/ -user joe -ok mv {} /tmp/joe/ \;`

#### Searching in Files with GREP

- `grep -i x /etc/dir`: Case-insensitive search for "x" in /etc/dir
- `grep -v x`: Finds results that do not contain "x"
- `grep -rl x`: Recursive search for "x" and list the files containing it
- `grep --color root x`: Highlights "x" in different color for visibility
