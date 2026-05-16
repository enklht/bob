function bob_keep_in_history -a command exit_code
    return (test $bob_allow_previously_successful = true -a $_bob_found_in_history = true)
end
