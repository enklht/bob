function _bob_remove_from_history
    while test (count $_bob_queue) -gt $bob_delay
        builtin history delete --case-sensitive --exact -- $_bob_queue[-1]
        set --erase _bob_queue[-1]
    end
end
