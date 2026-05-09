function _bob_on_prompt --on-event fish_prompt
    if $bob_allow_previously_successful = true
        set --global _bob_history $history
    end
    if test $bob_purge_only_on_exit = false
        _bob_remove_from_history
    end
end
