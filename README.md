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

- Automatically filters out failed commands (unless the same command was previously successful and allowed).
- Keeps a small buffer of recent commands (default: 2) so you can quickly re-run or correct mistakes.
- Lets you add custom filters to exclude commands by pattern or custom logic.

📝 Note 📝 :  
Bob does not remove commands that failed before installation.
If you want to clear all previous history, you can reset it with (this clears the entire history regardless of exit status. Be careful):

```fish
history clear
```

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

💡 Tip 💡:  
use the `--global` flag when setting a variable to change the setting only for the current session.

### Built-in filters

Bob ships with two filters by default:

- `bob_filter_failed`: filters out commands with non-zero exit codes (configurable).
- `bob_filter_matched`: filters commands that match one or more regex patterns.

Configuration examples (which filter they apply to):

- Settings for `bob_filter_failed`:

```fish
# Which exit codes are treated as successful by bob_filter_failed
# default: 0
set bob_successful_exit_codes 0 127

# If false, bob_filter_failed will filter out failed commands even if they
# were previously successful (i.e., present earlier in history).
# default: true
set bob_allow_previously_successful false
```

- Settings for `bob_filter_matched`:

```fish
# Regex patterns used by bob_filter_matched; any matching command will be filtered.
# default: empty
set bob_regex_patterns '(?:\d{1,3}\.){3}\d{1,3}'
```

### Custom filters

You can add custom filters.
A filter is a Fish function that receives two positional arguments:

1. `command`: the exact command string entered
2. `exit_code`: the command's exit status

Return exit status 0 to filter (remove) the command, or a non-zero value to keep it in history.
You can define your custom filter in `config.fish` or in the `functions` directory as a standalone function.

Register your filter by appending its name to `bob_filters`:

```fish
set --append bob_filters your_awesome_filter
```

⚠️ Be careful ⚠️ :  
Filters run after every command, so avoid slow operations in filters.

## 🤝 Contributing and origin

This project is derived from [Sponge](https://github.com/meaningful-ooo/sponge).
Contributions, bug reports, and pull requests are welcome.

## ©️ License

Originally distributed under the MIT License by Andrei Borisov (2020).
Modifications by enklht (2025).

[MIT](LICENSE)
