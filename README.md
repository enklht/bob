# Bob

![logo](images/logo.jpg?raw=true)

Bob is a Fish shell plugin that keeps your command history tidy by automatically removing mistyped or otherwise unwanted commands.

This project is based on [Sponge](https://github.com/meaningful-ooo/sponge) (originally by Andrei Borisov) and is released under the MIT License.

This version includes bug fixes and a substantial refactor to reduce global state, improve Fisher-based uninstallability, and fixes a history-search bug present in the original Sponge implementation.

## 🛠️ Installation

Install with [Fisher](https://github.com/jorgebucaran/fisher):

```fish
fisher install enklht/bob
```

## 🤔 What it does

Use your shell normally; Bob runs in the background and keeps your history clean.
It:

- Automatically removes failed commands after a short delay (unless the command already exists in history and is allowed).
- Keeps a small buffer of recent commands (default: 2) so you can quickly re-run or correct mistakes.
- Lets you add custom keep (whitelist) and drop (blacklist) rules.

📝 Note 📝 :  
Bob does not remove commands that failed before installation.
If you want to clear all previous history, you can reset it with `history clear` (this clears the entire history regardless of exit status. Be careful).

## ⚙️ Configuration

All configuration is done via Fish variables. You can place these in your `config.fish` or set them interactively.

### Delay before purging

Bob keeps recent commands for a short delay so you can still access them via history.
Adjust the delay with:

```fish
set bob_delay 5
```

To keep the session history intact until you exit the shell:

```fish
set bob_purge_only_on_exit true
```

### Built-in rules

Bob ships with keep (whitelist) and drop (blacklist) rules by default.

Rule order and defaults:

- Keep rules (whitelist) are evaluated first.
- If no keep rule matches, drop rules (blacklist) are evaluated next.
- If no rule matches, the command is kept.

Defualt keep rules (whitelist):

- `bob_keep_in_history`: keeps commands that already existed in history (configurable).
- `bob_keep_regex`: keeps commands that match one or more regex patterns.

Default drop rules (blacklist):

- `bob_drop_failed`: drops commands with exit codes considered unsuccessful.
- `bob_drop_regex`: drops commands that match one or more regex patterns.

#### Configuration examples

- Settings for `bob_drop_failed`:

```fish
# Which exit codes are treated as successful by bob_drop_failed
# default: 0
set bob_successful_exit_codes 0 127
```

- Settings for `bob_keep_in_history`

```fish
# If false, bob_keep_in_history will not keep commands that already exist in history.
# default: true
set bob_allow_previously_successful false
```

- Settings for `bob_keep_regex` and `bob_drop_regex`:

```fish
# Regex patterns used by bob_keep_regex; any matching command will be kept.
# default: empty
set bob_regex_whitelist '(?:\d{1,3}\.){3}\d{1,3}'

# Regex patterns used by bob_drop_regex; any matching command will be dropped.
# default: empty
set bob_regex_blacklist '(?:^|\s)rm\s+-rf\s+/tmp'
```

### Custom rules

You can add custom rules.
A rule is a Fish function that receives two positional arguments:

1. `command`: the exact command string entered
2. `exit_code`: the command's exit status

Return exit status 0 when the rule matches, or a non-zero value when it does not.
You can define your custom rule in `config.fish` or in the `functions` directory as a standalone function.

Register your keep rules by appending their names to `bob_keep_rules`:

```fish
set --append bob_keep_rules your_awesome_rule
```

Register your drop rules by appending their names to `bob_drop_rules`:

```fish
set --append bob_drop_rules your_awesome_rule
```

#### Example custom rule

This example demonstrates a custom drop rule that removes commands when the current working directory is under /tmp.
A rule should return 0 when it matches, or a non-zero status when it does not.

```fish
function drop_tmp -a command exit_code
  # If the current directory is /tmp or a subdirectory, drop the command.
  if string match -rq '^/tmp($|/)' (pwd)
    return
  end

  return 1
end
```

After defining the function (e.g., in your `config.fish` or a functions file), register it:

```fish
set --append bob_drop_rules drop_tmp
```

⚠️ Be careful ⚠️ :  
Rules run after every command, so avoid slow operations in rules.

## 🤝 Contributing and origin

This project is derived from [Sponge](https://github.com/meaningful-ooo/sponge).
Contributions, bug reports, and pull requests are welcome.

## ©️ License

Originally distributed under the MIT License by Andrei Borisov (2020).
Modifications by enklht (2025).

[MIT](LICENSE)
