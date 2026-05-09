function bob_filter_not_in_history -a command exit_code
    if test $_bob_found_in_history = true -a $bob_allow_previously_successful = true
        return 1
    end
end
