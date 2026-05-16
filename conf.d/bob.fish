status is-interactive; or return

# bob version
set --global bob_version 1.0.0

# Allow to repeat previous command by default
set -q bob_delay; or set --global bob_delay 2

# Purge entries both after `bob_delay` entries and on exit by default
set -q bob_purge_only_on_exit; or set --global bob_purge_only_on_exit false

# Disable debug output by default
set -q bob_debug; or set --global bob_debug false

# Default keep rules
set -q bob_keep_rules; or set --global bob_keep_rules bob_keep_in_history bob_keep_regex

# Default drop rules
set -q bob_drop_rules; or set --global bob_drop_rules bob_drop_failed bob_drop_regex

# Consider `0` the only successful exit code by default
set -q bob_successful_exit_codes; or set --global bob_successful_exit_codes 0

# Don't filter out commands that already have been in the history by default
set -q bob_allow_previously_successful; or set --global bob_allow_previously_successful true

# No active regex patterns by default
set -q bob_regex_whitelist; or set --global bob_regex_whitelist

# No active blacklist regex patterns by default
set -q bob_regex_blacklist; or set --global bob_regex_blacklist

functions -q _bob_on_exit _bob_on_postexec _bob_on_preexec _bob_on_prompt
