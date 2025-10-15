function bob_filter_matched -a command exit_code
    for pattern in $bob_regex_patterns
        if string match --regex --quiet $pattern -- $command
            return
        end
    end

    return 1
end
