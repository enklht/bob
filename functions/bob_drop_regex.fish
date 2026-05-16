function bob_drop_regex -a command exit_code
    for pattern in $bob_regex_blacklist
        if string match --regex --quiet $pattern -- $command
            return
        end
    end

    return 1
end
