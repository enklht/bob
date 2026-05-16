function _bob_on_postexec --on-event fish_postexec -a command
    set exit_code $status

    # Remove command from the queue if it's been added previously
    if set index (contains --index "$command" $_bob_queue)
        set --erase _bob_queue[$index]
    end

    # Keep rules (whitelist)
    for rule in $bob_keep_rules
        if $rule "$command" $exit_code
            if test "$bob_debug" = true
                echo [bob] keep rule matched: "$rule"
                echo [bob] keeping
            end
            set --prepend --global _bob_queue ''
            return
        end
    end

    # Drop rules (blacklist)
    for rule in $bob_drop_rules
        if $rule "$command" $exit_code
            if test "$bob_debug" = true
                echo [bob] drop rule matched: "$rule"
                echo [bob] dropping
            end
            set --prepend --global _bob_queue "$command"
            return
        end
    end

    if test "$bob_debug" = true
        echo [bob] no rule matched
        echo [bob] keeping
    end
    set --prepend --global _bob_queue ''
end
