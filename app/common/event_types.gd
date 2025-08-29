#/**
 #* Dictionary of Duelyst specific events. Do not add generic events here (ex: io connect).
 #*/
class_name EVENTS


#region Common

# generic error
static var error = 'error'

# screen resize
# auto emitted, do not trigger manually
static var resize = 'resize'

# request screen resize
static var request_resize = 'request_resize'

# before screen resize
# auto emitted, do not trigger manually
static var before_resize = 'before_resize'

# after screen resize
# auto emitted, do not trigger manually
static var after_resize = 'after_resize'

# request game reload
# auto emitted, do not trigger manually
static var request_reload = 'request_reload'

# cancel reload game request
# auto emitted, do not trigger manually
static var cancel_reload_request = 'cancel_reload_request'

# status updates
# auto emitted, do not trigger manually
static var status = 'status'

# when an object is terminated and will never be used again
# auto emitted, do not trigger manually
static var terminate = 'terminate'

# pointer/mouse events
# auto emitted, do not trigger manually
static var pointer_up = 'pointer_up'
static var pointer_down = 'pointer_down'
static var pointer_move = 'pointer_move'
static var pointer_wheel = 'pointer_wheel'

# mouse state for changing cursor when hovering canvas
static var canvas_mouse_state = 'canvas_mouse_state'
#endregion

#region UI

# user requested navigation actions
# manually triggered
static var user_request_confirm = 'user_request_confirm'
static var user_request_cancel = 'user_request_cancel'
static var user_request_skip = 'user_request_skip'
static var user_request_exit = 'user_request_exit'

# user attempted navigation actions
# auto emitted, do not trigger manually
static var user_attempt_confirm = 'user_attempt_confirm'
static var user_attempt_cancel = 'user_attempt_cancel'
static var user_attempt_skip = 'user_attempt_skip'
static var user_attempt_exit = 'user_attempt_exit'

# user triggered navigation actions
# auto emitted, do not trigger manually
static var user_triggered_confirm = 'user_triggered_confirm'
static var user_triggered_cancel = 'user_triggered_cancel'
static var user_triggered_skip = 'user_triggered_skip'
static var user_triggered_exit = 'user_triggered_exit'

# session events from the application
static var session_logged_in = 'session_logged_in'
static var session_logged_out = 'session_logged_out'

# user inventory changes
static var booster_pack_collection_change = 'booster_pack_collection_change'
static var cards_collection_change = 'cards_collection_change'
static var card_lore_collection_change = 'card_lore_collection_change'
static var cosmetic_chest_collection_change = 'cosmetic_chest_collection_change'
static var cosmetic_chest_key_collection_change = 'cosmetic_chest_key_collection_change'
static var decks_collection_change = 'decks_collection_change'
static var cosmetics_collection_change = 'cosmetics_collection_change'
static var orb_count_collection_change = 'orb_count_collection_change'
static var gift_crate_collection_change = 'gift_crate_collection_change'
static var wallet_change = 'wallet_change'

# start game type
static var start_challenge = 'start_challenge'
static var start_single_player = 'start_single_player'
static var start_boss_battle = 'start_boss_battle'
static var start_replay = 'start_replay'

# show ui
static var show_login = 'show_login'
static var show_terms = 'show_terms'
static var show_play = 'show_play'
static var show_watch = 'show_watch'
static var show_shop = 'show_shop'
static var show_collection = 'show_collection'
static var show_codex = 'show_codex'
static var show_booster_pack_unlock = 'show_booster_pack_unlock'
static var show_crate_inventory = 'show_crate_inventory'
static var show_emote = 'show_emote'
static var show_free_card_of_the_day = 'show_free_card_of_the_day'

# showing ui
static var showing_quest_log = 'showing_quest_log'

# scene change
static var change_scene = 'change_scene'

# replays
static var replay_started = 'replay_started'
static var replay_stopped = 'replay_stopped'
static var replay_paused = 'replay_paused'
static var replay_resumed = 'replay_resumed'
#endregion

#region Network

# matchmaking events
static var matchmaking_velocity = 'matchmaking_velocity'
static var matchmaking_start = 'matchmaking_start'
static var matchmaking_cancel = 'matchmaking_cancel'
static var matchmaking_error = 'matchmaking_error'
static var finding_game = 'finding_game'
static var invite_accepted = 'invite_accepted'
static var invite_rejected = 'invite_rejected'
static var invite_cancelled = 'invite_cancelled'

static var game_server_shutdown = 'game_server_shutdown'

# joined a game as a player
static var join_game = 'join_game'

# joined a game as a spectator
static var start_spectate = 'start_spectate'
static var spectate_game = 'spectate_game'

# spectators coming/going
static var spectator_joined = 'spectator_joined'
static var spectator_left = 'spectator_left'

# leave game
static var leave_game = 'leave_game'

# reconnection states
static var reconnect_to_game = 'reconnect_to_game'
static var reconnect_failed = 'reconnect_failed'

# generic network error
static var ajax_error = 'ajax_error'

# a game event from the server, such as a game step or mouse movement
static var network_game_event = 'network_game_event'
static var network_game_hover = 'network_game_hover'
static var network_game_select = 'network_game_select'
static var network_game_mouse_clear = 'network_game_mouse_clear'

# a game error from the server, such as when a game fails to initialize
static var network_game_error = 'network_game_error'

# opponent has connected or disconnected
static var opponent_connection_status_changed = 'opponent_connection_status_changed'
#endregion

#region SDK

static var turn_time = 'turn_time'

# game session has finished executing a step and step is ready for external usage
static var step = 'step'

# game session has started a new step
static var start_step = 'start_step'

# game session has finished a step and sent it out
static var after_step = 'after_step'

# game session is going to validate action and it may now be modified
static var modify_action_for_validation = 'modify_action_for_validation'

# game session is going validating action
static var validate_action = 'validate_action'

# game session has invalidated an attempted action
static var invalid_action = 'invalid_action'

# game session is going to add an action to the queue
static var before_added_action_to_queue = 'before_added_action_to_queue'

# game session has added an action to the queue
static var added_action_to_queue = 'added_action_to_queue'

# game session is going to execute action, and action may now be modified
static var modify_action_for_execution = 'modify_action_for_execution'

# game session is just before executing an action
static var overwatch = 'overwatch'

# game session is just before executing an action
static var before_action = 'before_action'

# game session has just executed an action
static var action = 'action'

# game session has executed and signed an action
static var after_action = 'after_action'

# game session cards can terminate themselves safely in response to the action that removed them
static var cleanup_action = 'cleanup_action'

# game session modifiers can trigger if the card they're applied to is still active
static var after_cleanup_action = 'after_cleanup_action'

# game session modifiers can now update their active state
static var modifier_active_change = 'modifier_active_change'

# game session modifiers can now remove auras from any cards no longer affected
static var modifier_remove_aura = 'modifier_remove_aura'

# game session modifiers can now add auras to any cards now affected
static var modifier_add_aura = 'modifier_add_aura'

# game session modifiers should now update their end of turn duration
static var modifier_end_turn_duration_change = 'modifier_end_turn_duration_change'

# game session modifiers should now update their start of turn duration
static var modifier_start_turn_duration_change = 'modifier_start_turn_duration_change'

# game session has just rolled back
static var rollback_to_snapshot = 'rollback_to_snapshot'

# game session snapshot was just requested
static var rollback_to_snapshot_requested = 'rollback_to_snapshot_requested'

# game session snapshot was just recorded
static var rollback_to_snapshot_recorded = 'rollback_to_snapshot_recorded'

# game session is preparing to roll back
static var before_rollback_to_snapshot = 'before_rollback_to_snapshot'

# game session has just deserialized
static var deserialize = 'deserialize'

# game session is preparing to deserialize
static var before_deserialize = 'before_deserialize'

# game state
static var end_turn = 'end_turn'
static var start_turn = 'start_turn'
static var game_over = 'game_over'
static var validate_game_over = 'validate_game_over'

# caching
static var update_cache_action = 'update_cache_action'
static var update_cache_step = 'update_cache_step'

# challenges
static var instruction_triggered = 'instruction_triggered'
static var challenge_attempted = 'challenge_attempted'
static var challenge_completed = 'challenge_completed'
static var challenge_lost = 'challenge_lost'
static var challenge_reset = 'challenge_reset'
static var challenge_start = 'challenge_start'

# attack prediction
static var entities_involved_in_attack = 'entities_involved_in_attack'
static var modify_action_for_entities_involved_in_attack = 'modify_action_for_entities_involved_in_attack'
#endregion

#region Engine FX

# blur entire screen
static var blur_screen_start = 'blur_screen_start'
static var blur_screen_stop = 'blur_screen_stop'

# blur surface (excludes non post-processing items)
static var blur_surface_start = 'blur_surface_start'
static var blur_surface_stop = 'blur_surface_stop'

# caching screen
static var caching_screen_setup = 'caching_screen_setup'
static var caching_screen_start = 'caching_screen_start'
static var caching_screen_stop = 'caching_screen_stop'
static var caching_screen_dirty = 'caching_screen_dirty'

# caching surface (excludes non post-processing items)
static var caching_surface_setup = 'caching_surface_setup'
static var caching_surface_start = 'caching_surface_start'
static var caching_surface_stop = 'caching_surface_stop'
static var caching_surface_dirty = 'caching_surface_dirty'
#endregion

#region Engine Game

# selection/hover changes in engine
static var game_selection_changed = 'game_selection_changed'
static var game_hover_changed = 'game_hover_changed'
static var general_speech_pressed = 'general_speech_pressed'
static var general_speech_done_showing = 'general_speech_done_showing'
static var instruction_node_pressed = 'instruction_node_pressed'
static var instruction_node_done_showing = 'instruction_node_done_showing'
static var speech_node_pressed = 'speech_node_pressed'
static var speech_node_done_showing = 'speech_node_done_showing'

# cards
static var inspect_card_start = 'inspect_card_start'
static var inspect_card_stop = 'inspect_card_stop'

static var play_card_start = 'play_card_start'
static var play_card_stop = 'play_card_stop'

static var mulligan_card_selected = 'mulligan_card_selected'
static var mulligan_card_deselected = 'mulligan_card_deselected'

static var followup_card_start = 'followup_card_start'
static var followup_card_stop = 'followup_card_stop'

# game state
static var show_active_game = 'show_active_game'
static var show_rollback = 'show_rollback'
static var before_show_game_over = 'before_show_game_over'
static var show_game_over = 'show_game_over'

# turns
static var show_end_turn = 'show_end_turn'
static var after_show_end_turn = 'after_show_end_turn'
static var show_start_turn = 'show_start_turn'
static var after_show_start_turn = 'after_show_start_turn'

# steps
static var before_show_step = 'before_show_step'
static var after_show_step = 'after_show_step'

# actions
static var before_show_action = 'before_show_action'
static var after_show_action = 'after_show_action'
static var show_action_for_game = 'show_action_for_game'
static var show_action_for_source = 'show_action_for_source'
static var show_action_for_target = 'show_action_for_target'
static var before_show_move = 'before_show_move'
static var after_show_move = 'after_show_move'
#endregion



var discord_spectate = 'discord_spectate'
