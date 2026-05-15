function _bob_on_exit --on-event fish_exit
    while set -q _bob_queue[1]
        builtin history delete --case-sensitive --exact -- $_bob_queue[-1]
        set --erase _bob_queue[-1]
    end
end
