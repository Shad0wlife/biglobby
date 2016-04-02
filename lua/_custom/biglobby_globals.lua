if not _G.BigLobbyGlobals then
    _G.BigLobbyGlobals = {}

    -- The new player limit is defined here, it should not be greater than
    -- the max values set in the pdmod file.
    -- Prefer `Global.num_players` set by BigLobby host
    BigLobbyGlobals.num_players = Global.num_players or 8 -- TODO: replace this with BLT menu setting

    function BigLobbyGlobals:num_player_slots()
        return self.num_players
    end

    -- Semantic versioning
    function BigLobbyGlobals:version()
        return "1.1.0"
    end
    
    -- GameVersion for matchmaking
    function BigLobbyGlobals:gameversion()
        return 110
    end


    local connection_network_handler_funcs = {
    	'kick_peer',
    	'remove_peer_confirmation',
    	'join_request_reply',
    	'peer_handshake',
    	'peer_exchange_info',
    	'connection_established',
    	'mutual_connection',
    	'set_member_ready',
    	'request_drop_in_pause',
    	'drop_in_pause_confirmation',
    	'set_peer_synched',
    	'dropin_progress',
    	'report_dead_connection',
    	'preplanning_reserved',
    	'draw_preplanning_event',
    	'sync_explode_bullet',
    	'sync_flame_bullet'
    }

    local unit_network_handler_funcs = {
    	'set_unit',
    	'remove_corpse_by_id',
    	'sync_trip_mine_setup',
    	'from_server_sentry_gun_place_result',
    	'sync_equipment_setup',
    	'sync_carry_data',
    	'sync_throw_projectile',
    	'sync_attach_projectile',
    	'sync_unlock_asset',
    	'sync_equipment_possession',
    	'sync_remove_equipment_possession',
    	'mark_minion',
    	'sync_statistics_result',
    	'suspicion',
    	'sync_enter_vehicle_host',
    	'sync_vehicle_player',
    	'sync_exit_vehicle',
    	'server_give_vehicle_loot_to_player',
    	'sync_give_vehicle_loot_to_player',
    	'sync_vehicle_interact_trunk'
    }

    BigLobbyGlobals.network_handler_funcs = {}
    function add_handler_funcs(handler_funcs)
        for i = 1, #handler_funcs do
            BigLobbyGlobals.network_handler_funcs[handler_funcs[i]] = true
    	end
    end

    add_handler_funcs(connection_network_handler_funcs)
    add_handler_funcs(unit_network_handler_funcs)

    function BigLobbyGlobals:rename_handler_funcs(NetworkHandler)
        for key, value in pairs(NetworkHandler) do
            if BigLobbyGlobals.network_handler_funcs[key] then
                NetworkHandler['biglobby__' .. key] = value
            end
        end
    end


    -- Nothing calls this anymore for the time being.
    local log_data = true -- Can use to turn the logging on/off
    function BigLobbyGlobals:logger(content, use_chat)
        if log_data then
            if not content then return end

            if use_chat then
                managers.chat:_receive_message(ChatManager.GAME, "BigLobby", content, tweak_data.system_chat_color)
            end

            log(content)
        end
    end

end
