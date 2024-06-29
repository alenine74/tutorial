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





