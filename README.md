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
- Lets you add custom filters that keep commands in history by matching patterns or custom logic.

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

### Built-in filters

Bob ships with three filters by default:

- `bob_filter_succeeded`: keeps commands with exit codes considered successful.
- `bob_filter_in_history`: keeps commands that already existed in history (configurable).
- `bob_filter_regex`: keeps commands that match one or more regex patterns.

Configuration examples (which filter they apply to):

- Settings for `bob_filter_succeeded`:

```fish
# Which exit codes are treated as successful by bob_filter_succeeded
# default: 0
set bob_successful_exit_codes 0 127

# If false, bob_filter_in_history will not keep commands that already exist in history.
# default: true
set bob_allow_previously_successful false
```

- Settings for `bob_filter_regex`:

```fish
# Regex patterns used by bob_filter_regex; any matching command will be kept.
# default: empty
set bob_regex_whitelist '(?:\d{1,3}\.){3}\d{1,3}'
```

### Custom filters

You can add custom filters.
A filter is a Fish function that receives two positional arguments:

1. `command`: the exact command string entered
2. `exit_code`: the command's exit status

Return exit status 0 to keep the command in history, or a non-zero value to allow Bob to remove it.
You can define your custom filter in `config.fish` or in the `functions` directory as a standalone function.

Register your filter by appending its name to `bob_filters`:

```fish
set --append bob_filters your_awesome_filter
```

#### Example custom filter

This example demonstrates a custom filter that keeps commands in history when the current working directory is under /tmp.
A filter should return 0 to keep the command, or a non-zero status to allow Bob to remove it.

```fish
function filter_tmp -a command exit_code
  # If the current directory is /tmp or a subdirectory, keep the command.
  if string match -rq '^/tmp($|/)' (pwd)
    return
  end

  # Otherwise, allow Bob to remove it.
  return 1
end
```

After defining the function (e.g., in your `config.fish` or a functions file), register it:

```fish
set --append bob_filters filter_tmp
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
