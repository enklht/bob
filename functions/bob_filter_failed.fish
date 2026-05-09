function bob_filter_failed -a command exit_code
    if contains $exit_code $bob_successful_exit_codes
        return 1
    end
end
