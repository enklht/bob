# bob version
set --global bob_version 1.0.0

# Allow to repeat previous command by default
set -q bob_delay; or set --global bob_delay 2

# Purge entries both after `bob_delay` entries and on exit by default
set -q bob_purge_only_on_exit; or set --global bob_purge_only_on_exit false

# Add default filters
set -q bob_filters; or set --global bob_filters bob_filter_failed bob_filter_matched

# Consider `0` the only successful exit code by default
set -q bob_successful_exit_codes; or set --global bob_successful_exit_codes 0

# Don't filter out commands that already have been in the history by default
set -q bob_allow_previously_successful; or set --global bob_allow_previously_successful true

# No active regex patterns by default
set -q bob_regex_patterns; or set --global bob_regex_patterns
