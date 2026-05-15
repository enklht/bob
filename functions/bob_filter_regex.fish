function bob_filter_regex -a command exit_code
    for pattern in $bob_regex_whitelist
        if string match --regex --quiet $pattern -- $command
            return
        end
    end

    return 1
end
