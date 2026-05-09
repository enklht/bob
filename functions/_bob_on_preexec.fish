function _bob_on_preexec --on-event fish_preexec -a command
    # If a command is in the history and not in the queue, ignore it, like if it wasn’t in the history
    if contains $command $_bob_history; and not contains $command $_bob_queue
        set --global _bob_found_in_history true
    else
        set --global _bob_found_in_history false
    end
end
