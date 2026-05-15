function bob_filter_succeeded -a command exit_code
    return (contains $exit_code $bob_successful_exit_codes)
end
