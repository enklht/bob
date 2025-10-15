function bob_filter_failed -a command exit_code
    if contains $exit_code $bob_successful_exit_codes
        return 1
    end

    if test $_bob_found_in_history = true -a $bob_allow_previously_successful = true
        return 1
    end
end
