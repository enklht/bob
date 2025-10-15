function _bob_on_preexec --on-event fish_preexec -a command
    set found_entries (builtin history search --case-sensitive --exact "$command")

    # If a command is in the history and in the queue, ignore it, like if it wasn’t in the history
    if test (count $found_entries) -gt 0; and not contains "$command" $_bob_queue
        set --global _bob_found_in_history true
    else
        set --global _bob_found_in_history false
    end
end
