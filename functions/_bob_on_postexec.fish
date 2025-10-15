function _bob_on_postexec --on-event fish_postexec -a command
    set exit_code $status

    # Remove command from the queue if it's been added previously
    if set index (contains --index "$command" $_bob_queue)
        set --erase _bob_queue[$index]
    end

    # Run filters
    for filter in $bob_filters
        if $filter "$command" $exit_code
            set --prepend --global _bob_queue "$command"
            return
        end
    end
    set --prepend --global _bob_queue ''
end
