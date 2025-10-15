function _bob_on_exit --on-event fish_exit
    bob_delay=0 _bob_remove_from_history
end
