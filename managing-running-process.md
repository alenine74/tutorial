### What is a Process?

A process is a running instance of a command.

##### `ps` Command

- `ps -a`: Show all processes.
- `ps -au`: Show all processes with detailed information.
- `ps -aux`: Show all processes for all users.

You can filter the output using `-o` and edit it using `-e`.

**Example:**
```bash
ps -eo pid,user,command
```

#### `top` Command

The `top` command shows processes sorted by CPU usage and refreshes every 5 seconds by default.

#### Renicing a Process

In `top`, you can renice a process by pressing `r`, entering the PID, and then entering the renice value (range: -20 to 19).

#### Killing a Process

In `top`, you can kill a process by pressing `k`, entering the PID, and then using `15` to terminate or `9` to kill.

#### Background Process

- Append `&` to run a command in the background:
  ```bash
  find /usr > /tmp/allusrfiles &
  ```
- Use `jobs` to see your background commands.
- Use `fg` to bring a process to the foreground:
  ```bash
  fg %PID
  ```
- Use `bg %PID` to move a process to the background.

##### Killing Processes with `kill` and `killall`

**Important Signals:**
- `SIGHUP (1)`: Hang-up detected on controlling terminal or death of controlling process.
- `SIGINT (2)`: Interrupt from keyboard.
- `SIGQUIT (3)`: Quit from keyboard.
- `SIGABRT (6)`: Abort signal.
- `SIGKILL (9)`: Kill signal.
- `SIGTERM (15)`: Termination signal.
- `SIGCONT (18)`: Continue if stopped.
- `SIGSTOP (19)`: Stop process.

The default signal for `kill PID` is `SIGTERM`. Common signal `SIGHUP` causes a program to reread its config and restart.

**List signals:**
```bash
kill -l
```

##### `killall`

Use the name instead of PID to kill processes:
```bash
killall -9 process_name
```

##### Nice Value

Set the nice value for a process, where a lower number means higher priority:
```bash
nice -n -19 process_name
```