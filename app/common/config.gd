#/** **************************************************************************
#Shared global object for Properties/Defines/Aliases
 #- static properties should be defined in ALL_CAPS
 #- dynamic properties should be defined in camelCase
 #- do not include resources in this file
#*************************************************************************** */
class_name CONFIG

static var _instance = CONFIG.new()
func _init() -> void:
	reset()

#/**
 #* Start properties that are safe to edit.
 #*/

# whether to debug draw sprites to show their bounding boxes
static var DEBUG_DRAW = false;
# whether to debug draw depth map
static var DEBUG_DEPTH = false;
# whether to load all assets at startup
static var LOAD_ALL_AT_START = false;
# whether to unload image assets from cpu
static var UNLOAD_CPU_IMAGES = true;
# whether nodes default to orthographic projection and swap to perspective projection only as needed
# this ensures that unless a node is rotated in 3D space, it will be rendered pixel perfect
# when false, always uses perspective projection
static var DYNAMIC_PROJECTION = true;
# global scale must be a multiple of this value
static var GLOBAL_SCALE_MULTIPLE = 0.25;
# global scale spacing to ensure layout isn't too tight
# set to 0 for tight/exact fit
static var GLOBAL_SCALE_SPACING = CONFIG.GLOBAL_SCALE_MULTIPLE * 0.5;
# list resource scales enabled other than 1x (NOTE: if you change this, you must also change $resourceScales in app/ui/styles/common/variables.scss!)
# these will be suffixed to the end of all image paths as needed, ex: path/to/img.png -> path/to/img@2x.png
static var RESOURCE_SCALES = [2];
# list of supported resolutions
static var RESOLUTION_AUTO = 1;
static var RESOLUTION_EXACT = 2;
static var RESOLUTION_PIXEL_PERFECT = 9999;
static var RESOLUTION_DEFAULT = CONFIG.RESOLUTION_AUTO;

class ResolutionSetting:
	var value: int
	var description: String
	var selected: bool

	func _init(v: int, desc: String, select: bool = false) -> void:
		value = v
		description = desc
		selected = select

static var RESOLUTIONS = [ # TODO: localize
	ResolutionSetting.new(CONFIG.RESOLUTION_AUTO, 'settings.best_fit', true ),
	ResolutionSetting.new(CONFIG.RESOLUTION_EXACT, 'settings.tightest_fit' ),
	ResolutionSetting.new(CONFIG.RESOLUTION_PIXEL_PERFECT, 'settings.pixel_perfect' ),
  #/*
  #{value: 2, description: "1280 x 720 (pixel perfect)"},
  #{value: 3, description: "1280 x 768"},
  #{value: 4, description: "1280 x 800"},
  #{value: 5, description: "1280 x 960"},
  #{value: 6, description: "1280 x 1024"},
  #{value: 7, description: "1360 x 768"},
  #{value: 8, description: "1366 x 768"},
  #{value: 9, description: "1440 x 900"},
  #{value: 10, description: "1536 x 864"},
  #{value: 11, description: "1600 x 900"},
  #{value: 12, description: "1600 x 1200"},
  #{value: 13, description: "1680 x 1050"},
  #{value: 14, description: "1920 x 1080"},
  #{value: 15, description: "1920 x 1200"},
  #{value: 16, description: "2560 x 1080"},
  #{value: 17, description: "2560 x 1440"}
  #*/
];
# number of minutes a player is allowed to continue a game for
static var MINUTES_ALLOWED_TO_CONTINUE_GAME = 45;
# player id for AI
static var AI_PLAYER_ID = 'ai';
# background color
static var BACKGROUND_COLOR = Color.BLACK
# static size of reference window to base layout calculations on
static var REF_WINDOW_SIZE = Vector2(1280.0, 720.0)
# size of SDK board
static var BOARDROW = 5;
static var BOARDCOL = 9;
static var BOARDCENTER = Vector2(floor(CONFIG.BOARDCOL * 0.5), floor(CONFIG.BOARDROW * 0.5))
# battle maps
static var BATTLEMAP0 = 0;
static var BATTLEMAP1 = 1;
static var BATTLEMAP2 = 2;
static var BATTLEMAP3 = 3;
static var BATTLEMAP4 = 4;
static var BATTLEMAP5 = 5;
static var BATTLEMAP6 = 6;
static var BATTLEMAP7 = 7;
static var BATTLEMAP_SHIMZAR = 8;
static var BATTLEMAP_ABYSSIAN = 9;
static var BATTLEMAP_REDROCK = 10;
static var BATTLEMAP_VANAR = 11;
# indices in BATTLEMAP_TEMPLATES of battlemaps available to all users
# do not include purchasable battlemaps in this list
static var BATTLEMAP_DEFAULT_INDICES = [0, 1, 2, 3, 4, 5, 6];
#/**
 #* Templates for how battlemaps behave.
 #* @example
 #* {
 #*   map: {Number} identifier of map
 #*   weatherChance: {Number} percent between 0 and 1
 #*   rainChance: {Number} percent between 0 and 1
 #*   snowChance: {Number} percent between 0 and 1
 #*   blueDustChance: {Number} percent between 0 and 1
 #*   blueDustColor: {cc.Color} color object with rgb values between 0 and 255 (default white)
 #*   sunRaysChance: {Number} percent between 0 and 1
 #*   clouds: {Array} list of cloud systems data
 #*     cloudSystemData -> {
 #*       index: {Number} index of cloud particles to show between 1 and 7 (default random)
 #*       sourceColor: {cc.Color} starting color object with rgb values between 0 and 255 (default white)
 #*       targetColor: {cc.Color} ending color object with rgb values between 0 and 255 (default white)
 #*       background: {Boolean} whether clouds are in background or foreground (default foreground)
 #*       sourcePosition: {Vec2} starting position of clouds as a percent of screen size between 0 and 1
 #*       targetPosition: {Vec2} ending position of clouds as a percent of screen size between 0 and 1
 #*     }
 #* }
 #*/

class Cloud:
	var background: bool
	var sourcePosition: Vector2
	var targetPosition: Vector2
	var sourceColor
	var targetColor

	func _init(bg: bool, sp: Vector2, tp: Vector2, scol = Color.BLACK, tcol = Color.BLACK) -> void:
		background = bg
		sourcePosition = sp
		targetPosition = tp
		sourceColor = scol
		targetColor = tcol

class BattleMapTemplate:
	var map
	var weatherChance
	var rainChance
	var snowChance
	var blueDustChance
	var sunRaysChance
	var clouds
	var blueDustColor

	func _init(m, wc, rc, sc, bdc, src, c, bdcol = Color.BLACK) -> void:
		map = m
		weatherChance = wc
		rainChance = rc
		snowChance = sc
		blueDustChance = bdc
		sunRaysChance = src
		clouds = c
		blueDustColor = bdcol

static var BATTLEMAP_TEMPLATES = [
	BattleMapTemplate.new(
		CONFIG.BATTLEMAP0, # LYONAR
		0.25,
		0.85,
		0.0,
		1.0,
		1.0,
		[
			Cloud.new(true, Vector2(1.0, 1.0), Vector2(0.0, 0.75)),
			Cloud.new(true, Vector2(1.0, 1.0), Vector2(0.0, 0.75)),
			Cloud.new(false, Vector2(1.0, 0.1), Vector2(0.0, 0.1)),
			Cloud.new(false, Vector2(1.0, 0.1), Vector2(0.0, 0.1)),
		],
	),
	BattleMapTemplate.new(
		CONFIG.BATTLEMAP1, # SONGHAI BLUE MOTHBALLS
		0.0,
		0.0,
		0.0,
		1.0,
		1.0,
		[
			Cloud.new(true, Vector2(0.0, 1.0), Vector2(1.0, 0.75)),
			Cloud.new(true, Vector2(0.0, 1.0), Vector2(1.0, 0.75)),
			Cloud.new(false, Vector2(0.0, 0.1), Vector2(1.0, 0.1)),
			Cloud.new(false, Vector2(0.0, 0.1), Vector2(1.0, 0.1)),
		],
	),
	BattleMapTemplate.new(
		CONFIG.BATTLEMAP2, # DESERT
		0.0,
		0.0,
		0.0,
		0.0,
		1.0,
		[
			Cloud.new(true, Vector2(1.0, 0.85), Vector2(0.0, 1.0)),
			Cloud.new(true, Vector2(1.0, 0.85), Vector2(0.0, 1.0)),
			Cloud.new(false, Vector2(1.0, 0.125), Vector2(0.0, 0.05)),
			Cloud.new(false, Vector2(1.0, 0.125), Vector2(0.0, 0.05)),
		],
	),
	BattleMapTemplate.new(
		CONFIG.BATTLEMAP4, # ICE CAVERN
		0.0,
		0.0,
		0.0,
		1.0,
		1.0,
		[
			Cloud.new(false, Vector2(0.0, 0.125), Vector2(1.0, 0.05)),
			Cloud.new(false, Vector2(0.0, 0.125), Vector2(1.0, 0.05)),
		],
	),
	BattleMapTemplate.new(
		CONFIG.BATTLEMAP5, # SONGHAI SKY ARENA
		0.25,
		0.85,
		0.0,
		1.0,
		1.0,
		[
			Cloud.new(true, Vector2(0.0, 0.90), Vector2(1.0, 0.70)),
			Cloud.new(true, Vector2(0.0, 0.90), Vector2(1.0, 0.70)),
			Cloud.new(true, Vector2(0.0, 0.50), Vector2(1.0, 0.30)),
			Cloud.new(true, Vector2(0.0, 0.50), Vector2(1.0, 0.30)),
		],
	),
	BattleMapTemplate.new(
		CONFIG.BATTLEMAP6, # BLUE MONOLITH
		0.0,
		0.0,
		0.0,
		1.0,
		1.0,
		[
			Cloud.new(false, Vector2(1.0, 0.05), Vector2(0.0, 0.05)),
			Cloud.new(false, Vector2(1.0, 0.05), Vector2(0.0, 0.05)),
		],
	),
	BattleMapTemplate.new(
		CONFIG.BATTLEMAP7, # VETRUV PALACE
		0.0,
		0.0,
		0.0,
		1.0,
		0.0,
		[
			Cloud.new(true, Vector2(0.0, 0.95), Vector2(1.0, 0.85)),
			Cloud.new(true, Vector2(0.0, 0.95), Vector2(1.0, 0.85)),
		],
	),
	BattleMapTemplate.new(
		CONFIG.BATTLEMAP_SHIMZAR,
		0.25,
		0.50,
		0.0,
		1.0,
		1.0,
		[
			Cloud.new(true, Vector2(0.0, 0.75), Vector2(1.0, 0.85), Color8(255, 225, 190), Color8(84, 163, 174)),
			Cloud.new(true, Vector2(0.0, 0.75), Vector2(1.0, 0.85), Color8(255, 184, 150), Color8(72, 117, 130)),
			Cloud.new(true, Vector2(0.0, 0.75), Vector2(1.0, 0.85), Color8(255, 184, 150), Color8(93, 175, 190)),
			Cloud.new(false, Vector2(1.0, 0.075), Vector2(0.0, 0.05), Color8(93, 175, 190), Color8(255, 184, 150)),
			Cloud.new(false, Vector2(1.0, 0.075), Vector2(0.0, 0.05), Color8(60, 100, 80), Color8(100, 80, 60)),
		],
		Color(255, 184, 71)
	),
	BattleMapTemplate.new(
		CONFIG.BATTLEMAP_ABYSSIAN,
		0.0,
		0.0,
		0.0,
		1.0,
		0.0,

		[
			Cloud.new(true, Vector2(0.0, 0.8), Vector2(1.0, 1.0), Color8(47, 50, 90), Color8(32, 35, 62)),
			Cloud.new(true, Vector2(0.0, 0.8), Vector2(1.0, 1.0), Color8(95, 66, 127), Color8(65, 47, 84)),
			Cloud.new(true, Vector2(0.0, 0.8), Vector2(1.0, 1.0), Color8(66, 72, 127), Color8(44, 48, 84)),
		],
		Color8(255, 0, 0)
	),
	BattleMapTemplate.new(
		CONFIG.BATTLEMAP_REDROCK,
		0.0,
		0.0,
		0.0,
		1.0,
		1.0,
		[
			Cloud.new(true, Vector2(0.0, 0.95), Vector2(1.0, 0.85)),
			Cloud.new(true, Vector2(0.0, 0.95), Vector2(1.0, 0.85)),
			Cloud.new(false, Vector2(1.0, 0.1), Vector2(0.0, -0.025), Color8(225, 210, 210), Color8(127, 80, 80)),
			Cloud.new(false, Vector2(1.0, 0.075), Vector2(0.0, 0.0), Color8(225, 210, 210), Color8(127, 80, 80)),
		],
		Color8(255, 150, 30)
	),
	BattleMapTemplate.new(
		CONFIG.BATTLEMAP_VANAR,
		1.0,
		0.0,
		1.0,
		0.0,
		0.0,
		[
			Cloud.new(true, Vector2(1.0, 0.85), Vector2(0.0, 0.95)),
			Cloud.new(true, Vector2(1.0, 0.85), Vector2(0.0, 0.95)),
			Cloud.new(false, Vector2(1.0, 0.1), Vector2(0.0, -0.025)),
			Cloud.new(false, Vector2(1.0, 0.075), Vector2(0.0, 0.0))
		],
	)
]

# size of final tiles on screen
static var TILESIZE = 95;
# percent of tile above to allow targeting a unit
static var TILE_TARGET_PCT = 0.45;
# offset of view board from center screen
static var TILEOFFSET_X = 0.0;
static var TILEOFFSET_Y = 10.0;
static var FLOOR_TILE_COLOR = Color.BLACK
static var FLOOR_TILE_OPACITY = 20;
# max mana; not accounting for bonuses; a player may have
static var MAX_MANA = 9;
static var STARTING_MANA = 2;
# max number of cards a player may have in hand at a time
static var MAX_HAND_SIZE = 6;
# number of cards players start with in hand
static var STARTING_HAND_SIZE = 5;
# number of cards players may mulligan
static var STARTING_HAND_REPLACE_COUNT = 2;
# content size of cards in player hand
static var HAND_CARD_SIZE = 140.0;
# padding around cards in game to account for larger unit sprite sizes
static var CARD_PADDING = 75.0;
# margin around inspected card
static var CARD_MARGIN = 75.0;
# color of card sidebar and modifiers bar
static var CARD_METADATA_BARS_COLOR = Color8(20, 20, 20, 255)
# padding for card modifiers and keywords
static var CARD_MODIFIER_PADDING_HORIZONTAL = 8.0;
static var CARD_MODIFIER_PADDING_VERTICAL = 5.0;
static var CARD_MODIFIER_ACTIVE_OPACITY = 255.0;
static var CARD_MODIFIER_ACTIVE_COLOR = Color8(255, 255, 255)
static var CARD_MODIFIER_INACTIVE_OPACITY = 100.0;
static var CARD_MODIFIER_INACTIVE_COLOR = Color8(255, 255, 255)
static var CARD_KEYWORDS_WIDTH = 190.0;
static var CARD_KEYWORD_PADDING_HORIZONTAL = 10.0;
static var CARD_KEYWORD_PADDING_VERTICAL = 5.0;
# signature card cooldown colors
static var SIGNATURE_CARD_COOLDOWN_FONT_COLOR = Color(0, 0, 0)
static var SIGNATURE_CARD_COOLDOWN_TIMER_COLOR = Color(0, 0, 0)
static var SIGNATURE_CARD_COOLDOWN_TIMER_OPACITY = 170.0;
static var SIGNATURE_CARD_COOLDOWN_TIMER_BG_COLOR = Color(0, 0, 0)
static var SIGNATURE_CARD_COOLDOWN_TIMER_BG_OPACITY = 0.0;
# content size of crates
static var CRATE_SIZE = Vector2(230.0, 260.0)
static var CRATE_PADDING = 80.0;
static var CRATE_OVERFLOW_SLOP = 23.0;
# max number of battle log entries to show
static var MAX_BATTLELOG_ENTRIES = 6;
# offset of battlelog
static var BATTLELOG_OFFSET = Vector2(0.0, -30.0)
# offset of battle log entries
static var BATTLELOG_ENTRY_OFFSET = Vector2(10.0, 5.0)
# content size of battle log entries
static var BATTLELOG_ENTRY_SIZE = 70.0;
# max number of active artifacts allowed on general
static var MAX_ARTIFACTS = 3;
# max durability of artifacts on general (i.e. how many times they can be hit before breaking)
static var MAX_ARTIFACT_DURABILITY = 3;
# content size of artifacts ui for active artifacts on general
static var ARTIFACT_SIZE = 70.0;
# max delay in seconds between steps in a replay
static var REPLAY_MAX_STEP_DELAY = 5.0;
# max delay in seconds between steps in a replay during mulligan
static var REPLAY_MAX_STEP_DELAY_STARTING_HAND = 10.0;
# card formatting for HTML display
static var FORMATTING_HTML = {
	entryDelimiter = '<br>',
	boldStart = '<b>',
	boldEnd = '</b>',
};
# card formatting for in engine display
static var FORMATTING_ENGINE = {
	entryDelimiter = '\n',
	boldStart = '<b>',
	boldEnd = '</b>',
	emphasisStart = '[',
	emphasisEnd = ']',
};
# offset of hand from center screen
static var HAND_OFFSET_X = -CONFIG.HAND_CARD_SIZE * 0.3;
static var HAND_OFFSET_Y = 10.0;
# players draw up to CARD_DRAW_PER_TURN cards each turn (until hand is full)
static var CARD_DRAW_PER_TURN = 1;
# max number of cards a player may replace per turn
static var MAX_REPLACE_PER_TURN = 1;
# time in seconds to show a tip
static var GAME_TIP_DURATION = 30;
# max number of emotes to show per page of emotes panel
static var MAX_EMOTES_PER_PAGE = 12;
# time in seconds between when emotes can be sent
static var EMOTE_DELAY = 5;
# time in seconds to show an emote
static var EMOTE_DURATION = 3;
# max number of cards to show per page of collection
static var MIN_COLUMNS_CARDS = 4;
static var MIN_ROWS_CARDS = 2;
# max number of buddies to show per page of buddy list
static var MAX_BUDDIES_PER_PAGE = 6;
# max number of times to update the buddy list per second
static var MAX_BUDDY_LIST_UPDATES_PER_SECOND = 1;
# max number of booster packs to show at once
static var MAX_BOOSTER_PACKS_SHOWN = 3;
# default deck name
static var DEFAULT_DECK_NAME = 'collection.default_deck_name';
# max size of deck
static var MAX_DECK_SIZE = 40;
# min size of deck when using all basics
static var MIN_BASICS_DECK_SIZE = 27;
# max size of deck in gauntlet
static var MAX_DECK_SIZE_GAUNTLET = 31;
# days before a gauntlet deck expires for use in friendly matches after being ended
static var DAYS_BEFORE_GAUNTLET_DECK_EXPIRES = 14;
# max effective spirit value of any deck
# decks may have a higher spirit value than this
static var MAX_EFFECTIVE_SPIRIT_VALUE = 10000;
# max number of duplicates of any card in deck
static var MAX_DECK_DUPLICATES = 3;
# whether deck size should include general
static var DECK_SIZE_INCLUDES_GENERAL = true;
# whether deck building should confirm cancel
static var DECK_BUILDING_CONFIRM_CANCEL = false;
# how many games to remind user to use signature card
static var NUM_GAMES_TO_SHOW_SIGNATURE_CARD_REMINDER = 20;
static var NUM_TURNS_BEFORE_SHOW_SIGNATURE_CARD_REMINDER = 3;
static var NUM_GAMES_TO_SHOW_REPLACE_REMINDER = 20;
static var NUM_TURNS_BEFORE_SHOW_REPLACE_REMINDER = 2;
static var REMINDER_DELAY = 0.25;
# max number of buddy messages to preview when not in buddy list
static var MAX_BUDDY_MESSAGES_TO_PREVIEW = 3;
# duration in seconds to show a preview of a buddy message when not in buddy list
static var BUDDY_MESSAGES_PREVIEW_DURATION = 5;
# duration in seconds to fade a preview of a buddy message when not in buddy list
static var BUDDY_MESSAGES_PREVIEW_FADE_DURATION = 0.3;
# delay in seconds of general casting animations
static var GENERAL_CAST_START_DELAY = 0.25;
static var GENERAL_CAST_END_DELAY = 0.5;
# duration in seconds to show a quest progress notification
static var QUEST_NOTIFICATION_DURATION = 4;
# duration in seconds to fade a quest progress notification
static var QUEST_NOTIFICATION_FADE_DURATION = 0.3;
# duration in seconds to show a quest progress notification
static var ACHIEVEMENT_NOTIFICATION_DURATION = 6;
# Reward for a users first win of the day
static var FIRST_WIN_OF_DAY_GOLD_REWARD = 20;
# Number of wins per user receiving win based gold reward
static var WINS_REQUIRED_FOR_WIN_REWARD = 3;
# Reward for a users first win of the day
static var WIN_BASED_GOLD_REWARD = 15;
# Cost of a rift ticket
static var RIFT_TICKET_GOLD_PRICE = 150;
# duration in seconds to announce
static var ANNOUNCER_DURATION = 1.2;
# delay in seconds between showing each star gained or lost
static var STARS_SEQUENCE_DELAY = 0.5;
# threshold distance in pixels to consider mouse input to be dragging (set to lower for more sensitive)
static var DRAGGING_DISTANCE = 20.0;
# threshold duration in seconds to consider mouse input to be dragging (set to lower for more sensitive)
static var DRAGGING_DELAY = 0.1;
# delay before app transitions from loading screen to main menu
static var POST_LOAD_DELAY = 2;
# delay before app transitions from versus screen to starting hand screen
static var VS_DELAY = 4.0;
# delay before app transitions from starting hand screen into a playable game
static var ACTIVE_GAME_DELAY = 1.5;
# delay before app tries to reconnect to a game automatically in the case of a network error
static var RECONNECT_DELAY = 1.0;
# A default timeout for promises involving UI Transitions
static var PROMISE_TIMEOUT_UI_TRANSITION = 5.0;
# delay before game over screen is shown
static var GAME_OVER_DELAY = 0.5;
# Seconds to wait before playing another messsage notification sfx
static var INCOMING_MESSAGE_SFX_DELAY = 5.0;
static var VIEW_TRANSITION_DURATION = 0.3;
static var NOTIFICATION_TRANSITION_DURATION = 0.35;
static var NOTIFICATION_DURATION = 1.0;
static var GAME_MAIN_NOTIFICATION_DURATION = 3.0;
static var GAME_BATTLE_NOTIFICATION_DURATION = 5.0;
static var GAME_PLAYER_NOTIFICATION_DURATION = 4.0;
# fallback duration to show speech bubbles over units when no sound provided
static var SPEECH_DURATION = 2.0;
static var INSTRUCTION_TEXT_MAX_WIDTH = round(CONFIG.TILESIZE * 2.25);
static var TOOLTIP_TEXT_MAX_WIDTH = round(CONFIG.TILESIZE * 2.25);
static var GENERAL_SPEECH_WIDTH = 280;
# fallback for how long to show
static var GENERAL_SPEECH_DURATION = 4.0;
static var DIALOGUE_PROCEED_PULSE_DELAY = 2.5;
# duration in seconds to transition dialogue in
static var DIALOGUE_ENTER_DURATION = 0.3;
# duration in seconds to show a player's out of cards statement
static var DIALOGUE_OUT_OF_CARDS_DURATION = 1.0;
# duration in seconds to show a player's hand is too full statement
static var DIALOGUE_HAND_FULL_DURATION = 1.0;
# duration in seconds for burn card animation
static var BURN_CARD_SHOW_DURATION = 0.25;
static var BURN_CARD_DELAY = 0.25;
static var BURN_CARD_DISSOLVE_DURATION = 0.75;
# duration in seconds to show a player's resign statement
static var DIALOGUE_RESIGN_DURATION = 2.0;
static var INSTRUCTIONAL_CARROT_GLOW_FREQUENCY = 4;
static var INSTRUCTIONAL_LONG_DURATION = 5.0;
static var INSTRUCTIONAL_SHORT_DURATION = 4.0;
static var INSTRUCTIONAL_ULTRAFAST_DURATION = 2.5;
static var INSTRUCTIONAL_DELAY_BEFORE_RESHOW = 4.0;
static var INSTRUCTIONAL_DEFAULT_DELAY = 0.0;
static var INSTRUCTIONAL_DISMISSED_LOOP_DELAY = 5.0;
static var INSTRUCTIONAL_MANUAL_DEFAULT_DELAY = 0.25; # This has to be manually added to instructionals, isn't automatically added anywhere
# delay before changing to next turn after all turn actions have been shown
static var TURN_DELAY = 0.0;
# delay when showing any special action
static var ACTION_DELAY = 0.5;
# how long the instructional arrow should take to get to the target
static var ACTION_INSTRUCTIONAL_ARROW_DURATION = 0.75;
# what percentage of instructional arrow duration should be used for sequencing
static var ACTION_INSTRUCTIONAL_ARROW_SHOW_PERCENT = 1.0;
# how long the exclamation mark should show for
static var ACTION_EXCLAMATION_MARK_DURATION = 1.2;
# what percentage of exclamation mark duration should be used for sequencing
static var ACTION_EXCLAMATION_MARK_SHOW_PERCENT = 0.5;
# delay in action sequencing when using a particle systems with infinite emission
static var PARTICLE_SEQUENCE_DELAY = 0.5;
# max number of steps a particle system can simulate per frame to account for lag
static var PARTICLE_SYSTEM_MAX_STEPS = 10.0;
# delay in seconds between showing multiple callouts on an entity
static var ENTITY_STATS_CHANGE_DELAY = 0.75;
# size of fonts for entity stats changes
static var ENTITY_STATS_CHANGE_ATK_FONT_SIZE = 20;
static var ENTITY_STATS_CHANGE_HP_FONT_SIZE = 20;
static var ENTITY_STATS_CHANGE_HEAL_FONT_SIZE = 20;
static var ENTITY_STATS_CHANGE_DAMAGE_FONT_SIZE = 20;# 30;
# whether to show prismatic fx only when inspecting
static var SHOW_PRISMATIC_ONLY_ON_INSPECT = false;
# whether to show prismatic card shine
static var SHOW_PRISMATIC_CARD_SHINE = true;
# how many seconds between showing prismatic card shine
static var SHOW_PRISMATIC_CARD_SHINE_DELAY = 4.0;
# threshold at which turn time starts visually counting down
static var TURN_TIME_SHOW = 20.0;
static var TURN_DURATION = 90.0;
static var TURN_DURATION_INACTIVE = 15.0;
static var TURN_DURATION_LATENCY_BUFFER = 2.0;
static var TILE_SELECT_OPACITY = 200;
static var TILE_HOVER_OPACITY = 200;
static var TILE_DIM_OPACITY = 127;
static var TILE_FAINT_OPACITY = 75;
static var TILE_SELECT_FREEZE_ON_ATTACK_MOVE = false;
# distance for path to fade in/out
static var PATH_FADE_DISTANCE = 40.0;
# opacity of paths
static var PATH_DIRECT_ACTIVE_OPACITY = 200;
static var PATH_DIRECT_DIM_OPACITY = 150;
static var PATH_TILE_ACTIVE_OPACITY = 150;
static var PATH_TILE_DIM_OPACITY = 100;
# distance for path to arc up
static var PATH_ARC_DISTANCE = CONFIG.TILESIZE * 0.5;
# rotation modifier of path when in arc
static var PATH_ARC_ROTATION_MODIFIER = 2.0;
# time it takes for a path to move 1 tile in view board
static var PATH_MOVE_DURATION = 1.5;
# opacity of targets
static var TARGET_ACTIVE_OPACITY = 200;
static var TARGET_DIM_OPACITY = 127;
# general purpose durations
static var ANIMATE_FAST_DURATION = 0.2;
static var ANIMATE_MEDIUM_DURATION = 0.35;
static var ANIMATE_SLOW_DURATION = 1.0;
static var FADE_FAST_DURATION = CONFIG.ANIMATE_FAST_DURATION;
static var FADE_MEDIUM_DURATION = CONFIG.ANIMATE_MEDIUM_DURATION;
static var FADE_SLOW_DURATION = CONFIG.ANIMATE_SLOW_DURATION;
static var PULSE_SLOW_DURATION = 1.5;
static var PULSE_MEDIUM_DURATION = 0.7;
static var PULSE_FAST_DURATION = ANIMATE_MEDIUM_DURATION;
static var PULSE_SLOW_FREQUENCY = 1.0 / PULSE_SLOW_DURATION;
static var PULSE_MEDIUM_FREQUENCY = 1.0 / PULSE_MEDIUM_DURATION;
static var PULSE_FAST_FREQUENCY = 1.0 / PULSE_FAST_DURATION;
static var MOVE_FAST_DURATION = 0.15;
static var MOVE_MEDIUM_DURATION = ANIMATE_MEDIUM_DURATION;
static var MOVE_SLOW_DURATION = ANIMATE_SLOW_DURATION;
static var STAGGER_FAST_DELAY = 0.1;
static var STAGGER_MEDIUM_DELAY = 0.15;
static var STAGGER_SLOW_DELAY = ANIMATE_MEDIUM_DURATION;
static var MUSIC_CROSSFADE_DURATION = 0.5;
static var VOICE_CROSSFADE_DURATION = 0.0;
# scale of sprites in view
static var SCALE = 2.0;
# offset from bottom of sprites for depth calculations
static var DEPTH_OFFSET = 19.5;
# global 3D rotation for illusion of depth
static var XYZ_ROTATION = Vector3(16.0, 0.0, 0.0)
# entity 3D rotation for illusion of depth
static var ENTITY_XYZ_ROTATION = Vector3(26.0, 0.0, 0.0)
# entity 3D rotation speed
static var XYZ_ROTATION_PER_SECOND_SLOW = Vector3(0.0, 0.0, 15.0)
static var XYZ_ROTATION_PER_SECOND_MEDIUM = Vector3(0.0, 0.0, 45.0)
static var XYZ_ROTATION_PER_SECOND_FAST = Vector3(0.0, 0.0, 180.0)
# maximum number of FX to allow per FX event
static var MAX_FX_PER_EVENT = 5;
# light intensity presets
static var LIGHT_LOW_INTENSITY = 1.0;
static var LIGHT_MEDIUM_INTENSITY = 3.0;
static var LIGHT_HIGH_INTENSITY = 5.0;
# duration to show new card for
static var NEW_CARD_DURATION = 1.5;
# whether to show unused entities when a player hovers over end turn
static var SHOW_UNUSED_ENTITIES = true;
# whether to show both move and attack tiles together when an entity can move and attack
static var SHOW_MERGED_MOVE_ATTACK_TILES = false;
# duration in seconds to transition my played card in or out for
static var MY_PLAYED_CARD_TRANSITION_DURATION = 0.5;
# duration in seconds to show my played card for between transition in/out
static var MY_PLAYED_CARD_SHOW_DURATION = 1.0 + CONFIG.MY_PLAYED_CARD_TRANSITION_DURATION;
# duration in seconds to transition opponent's played card in or out for
static var OPPONENT_PLAYED_CARD_TRANSITION_DURATION = 1.0;
# duration in seconds to show opponent's played card for
static var OPPONENT_PLAYED_CARD_SHOW_DURATION = 1.0 + OPPONENT_PLAYED_CARD_TRANSITION_DURATION;
# duration in seconds to transition the reveal of a hidden card in or out for
static var REVEAL_HIDDEN_CARD_TRANSITION_DURATION = 1.0;
# duration in seconds to show any played card for when revealing a hidden card
static var REVEAL_HIDDEN_CARD_SHOW_DURATION = 2.0 + REVEAL_HIDDEN_CARD_TRANSITION_DURATION;
# duration in seconds to transition a replay played card in or out for
static var REPLAY_PLAYED_CARD_TRANSITION_DURATION = 1.5;
# duration in seconds to show any played card for during replays
static var REPLAY_PLAYED_CARD_SHOW_DURATION = 1.0 + REPLAY_PLAYED_CARD_TRANSITION_DURATION;
# duration to delay view for opponent played cards
static var OPPONENT_PLAYED_CARD_DELAY = OPPONENT_PLAYED_CARD_SHOW_DURATION + 1.0;
# duration to delay view for reveal of hidden cards
static var REVEAL_HIDDEN_CARD_DELAY = REVEAL_HIDDEN_CARD_SHOW_DURATION + 1.0;
# duration to delay view for my played cards in replay
static var REPLAY_PLAYED_CARD_DELAY = REPLAY_PLAYED_CARD_SHOW_DURATION + 1.0;
# duration to fade fx while showing fx for played spells
static var PLAYED_SPELL_FX_FADE_IN_DURATION = 0.5;
static var PLAYED_SPELL_FX_FADE_OUT_DURATION = 0.5;
# template of options for fx that follows mouse while doing a followup
static var FOLLOWUP_FX_TEMPLATE = [
	{
	type = 'Light',
	radius = CONFIG.TILESIZE * 2.0,
	fadeInDuration = 0.5,
	opacity = 200,
	intensity = CONFIG.LIGHT_HIGH_INTENSITY,
	castsShadows = true,
		},
		{
	type = 'LensFlare',
	blendSrc = 'SRC_ALPHA',
	blendDst = 'ONE',
	speed = 1.0,
	scale = 2.0,
		},
];

# template of options for fx during a tutorial instruction
static var TUTORIAL_INSTRUCTION_FX_ENABLED = false;
static var TUTORIAL_INSTRUCTION_FX_FADE_DURATION = FADE_MEDIUM_DURATION;
static var TUTORIAL_INSTRUCTION_FX_LIGHT_RADIUS = 6.0;
static var TUTORIAL_INSTRUCTION_FX_TEMPLATE = [
	{
	type = 'Light',
	fadeInDuration = CONFIG.FADE_MEDIUM_DURATION,
	opacity = 255,
	intensity = CONFIG.LIGHT_LOW_INTENSITY,
	castsShadows = true,
	offset = { x = 0.0, y = -CONFIG.TILESIZE * 0.5 },
	color = { r = 255, g = 255, b = 255 },
		},
];

# template of options for fx that follows mouse for when hovering to attack
static var ATTACK_FX_TEMPLATE = [
	{
#// type: "LensFlare",
	#/// /blendSrc: "SRC_ALPHA",
	#/// /blendDst: "ONE",
	#// color: { r: 255, g: 20, b: 40 },
	#// speed: 1.0,
	#// scale: 3.0
	},
];
# duration in seconds to show a general's taunt before finishing
# (may remove this and set dynamically later)
static var HIGHLIGHT_GENERAL_TAUNT_DURATION = 2.0;
# duration in seconds to delay before showing my general taunting
# if this value is less than opponent general's taunt, it will show before
static var HIGHLIGHT_MY_GENERAL_TAUNT_DELAY = 0.5;
# duration in seconds to delay before showing opponent general taunting
# if this value is less than my general's taunt, it will show before
static var HIGHLIGHT_OPPONENT_GENERAL_TAUNT_DELAY = HIGHLIGHT_MY_GENERAL_TAUNT_DELAY + HIGHLIGHT_GENERAL_TAUNT_DURATION + 0.5;
# duration in seconds to fade out fx used to show general
static var GENERAL_FX_FADE_DURATION = FADE_FAST_DURATION;
# template of options for fx that is used to show my general

class FXTemplate:
	var type
	var radius
	var fadeInDuration
	var opacity
	var intensity
	var castsShadows
	var offset
	var color

	func _init(t, r, fid, o, i, cs, of, col) -> void:
		type = t
		radius = r
		fadeInDuration = fid
		opacity = o
		intensity = i
		castsShadows = cs
		offset = of
		color = col


static var GENERAL_FX_TEMPLATE = [
	FXTemplate.new(
		'Light',
		CONFIG.TILESIZE * 4.0,
		CONFIG.FADE_SLOW_DURATION,
		255,
		CONFIG.LIGHT_LOW_INTENSITY,
		true,
		Vector2(0.0, -CONFIG.TILESIZE),
		Color.WHITE
	)
];
# whether stats should be shown during steps replay
static var OVERLAY_STATS_DURING_STEPS = true;
# whether stats should be shown on hover
static var OVERLAY_STATS_DURING_HOVER = true;
# whether stats should be shown on select
static var OVERLAY_STATS_DURING_SELECT = true;
# stats node text size
static var OVERLAY_STATS_TEXT_SIZE = 16;
# stats node offset from center of unit
static var OVERLAY_STATS_OFFSET = Vector2(0.0, -TILESIZE * 0.6)
# stats node background transparency
static var OVERLAY_STATS_BG_ALPHA = 225;
# space between overlay stats
static var OVERLAY_STATS_SPACING = TILESIZE * 0.6;
# speech node offset from center of unit
static var KILL_NODE_OFFSET = Vector2(0.0, -TILESIZE * 0.225)
# instruction node offset from center of unit based on direction of instruction
static var INSTRUCTION_NODE_OFFSET = TILESIZE * 0.5;
# colors for entity glows
static var PLAYER_CARD_GLOW_RAMP_FROM_COLOR = Color8(255, 255, 255)
static var PLAYER_CARD_GLOW_RAMP_TRANSITION_COLOR = Color8(40, 170, 255)
static var PLAYER_CARD_GLOW_RAMP_TO_COLOR = Color8(40, 170, 255)
static var PLAYER_CARD_GLOW_RAMP_NOISE_COLOR = Color8(40, 255, 255)
static var OPPONENT_CARD_GLOW_RAMP_FROM_COLOR = Color8(255, 175, 175, 255)
static var OPPONENT_CARD_GLOW_RAMP_TRANSITION_COLOR = Color8(255, 60, 60)
static var OPPONENT_CARD_GLOW_RAMP_TO_COLOR = Color8(255, 0, 0)
static var OPPONENT_CARD_GLOW_RAMP_NOISE_COLOR = Color8(255, 60, 60)
static var PLAYER_SIGNATURE_CARD_GLOW = Color8(40, 201, 255)
static var OPPONENT_SIGNATURE_CARD_GLOW = Color8(255, 50, 75)
static var NEUTRAL_SIGNATURE_CARD_GLOW = Color8(40, 133, 255)
static var INSTRUCTIONAL_CARD_GLOW_RAMP_FROM_COLOR = {
	r = 255, g = 255, b = 255, a = 255,
};
static var INSTRUCTIONAL_CARD_GLOW_RAMP_TRANSITION_COLOR = { r = 40, g = 170, b = 255 };
static var INSTRUCTIONAL_CARD_GLOW_RAMP_TO_COLOR = { r = 40, g = 170, b = 255 };
static var INSTRUCTIONAL_CARD_GLOW_RAMP_NOISE_COLOR = { r = 40, g = 255, b = 255 };
# colors for labels in post game rank screen
static var POST_GAME_RANK_PRIMARY_COLOR = { r = 255, g = 255, b = 255 };
static var POST_GAME_RANK_SECONDARY_COLOR = { r = 196, g = 211, b = 227 };
# time it takes an entity to move 1 tile
static var ENTITY_MOVE_DURATION_MODIFIER = 1.0;

# max modifier to entity movement animation time per 1 tile
static var ENTITY_MOVE_MODIFIER_MAX = 1.0;
# minimum modifier to entity movement animation time per 1 tile
static var ENTITY_MOVE_MODIFIER_MIN = 0.75;
# correction time to make it appear as if an entity stops correctly at end of movement
static var ENTITY_MOVE_CORRECTION = 0.2;
# fixed number of tiles that a flying unit will use to determine how fast to move
# i.e. the lower the tile count, the fewer animation cycles and faster the unit will move
# however, if the distance to travel is less than this, it will use the lower distance
static var ENTITY_MOVE_FLYING_FIXED_TILE_COUNT = 3.0;
# modifier to entity attack animation time
static var ENTITY_ATTACK_DURATION_MODIFIER = 1.0;
# properties of glow used to suggest that an entity is ready to be used
static var PLAYER_READY_COLOR = { r = 255, g = 255, b = 255 };
static var PLAYER_READY_PARTICLES_VISIBLE = true;
static var PLAYER_READY_HIGHLIGHT_VISIBLE = false;
static var PLAYER_READY_HIGHLIGHT_COLOR = { r = 70, g = 90, b = 255 };
static var PLAYER_READY_HIGHLIGHT_FREQUENCY = 0.75;
static var PLAYER_READY_HIGHLIGHT_OPACITY_MIN = 0;
static var PLAYER_READY_HIGHLIGHT_OPACITY_MAX = 200;
# properties of glow used to suggest that an entity is opponent's entity
static var OPPONENT_READY_COLOR = { r = 255, g = 40, b = 70 };
static var OPPONENT_READY_PARTICLES_VISIBLE = false;
static var OPPONENT_READY_HIGHLIGHT_VISIBLE = false;
static var OPPONENT_READY_HIGHLIGHT_COLOR = { r = 255, g = 0, b = 0 };
static var OPPONENT_READY_HIGHLIGHT_FREQUENCY = 0.75;
static var OPPONENT_READY_HIGHLIGHT_OPACITY_MIN = 0;
static var OPPONENT_READY_HIGHLIGHT_OPACITY_MAX = 200;
# default glow colors
static var DEFAULT_GLOW_COLOR = { r = 37, g = 176, b = 255 };
static var DEFAULT_GLOW_HIGHLIGHT_COLOR = { r = 50, g = 255, b = 100 };
# loot crate glow colors
static var LOOT_CRATE_GLOW_COLOR = { r = 37, g = 176, b = 255 };
# arena faction select glow colors
static var ARENA_FACTION_GLOW_COLOR = DEFAULT_GLOW_COLOR;
static var ARENA_FACTION_GLOW_HIGHLIGHT_COLOR = { r = 50, g = 255, b = 100 };
static var ARENA_FACTION_GLOW_SELECT_COLOR = { r = 50, g = 255, b = 150 };
static var ARENA_FACTION_GLOW_DISABLE_COLOR = { r = 70, g = 99, b = 127 };
# arena card select glow colors
static var ARENA_CARD_GLOW_COLOR = DEFAULT_GLOW_COLOR;
static var ARENA_CARD_GLOW_HIGHLIGHT_COLOR = { r = 143, g = 218, b = 62 };
static var ARENA_CARD_GLOW_SELECT_COLOR = { r = 143, g = 255, b = 62 };
static var ARENA_CARD_GLOW_DISABLE_COLOR = { r = 70, g = 99, b = 127 };
# the pattern step used to generate range patterns
# think of it like a stamp that fills out the final pattern until it reaches the max distance
static var RANGE_PATTERN_STEP = [
	Vector2(-1, -1),
	Vector2(-1, 0),
	Vector2(-1, 1),
	Vector2(0, -1),
	Vector2(0, 1),
	Vector2(1, -1),
	Vector2(1, 0),
	Vector2(1, 1),
];
# the pattern step used to generate movement paths
# think of it as how something is allowed to move across the board from tile to tile
static var MOVE_PATTERN_STEP = [
	Vector2(-1, 0),
	Vector2(1, 0),
	Vector2(0, -1),
	Vector2(0, 1),
];
# the pattern step used to generate spawn patterns
static var SPAWN_PATTERN_STEP = RANGE_PATTERN_STEP;
# the pattern step used to generate spell patterns
static var SPELL_PATTERN_STEP = [
	Vector2(-1, 0),
	Vector2(1, 0),
	Vector2(0, -1),
	Vector2(0, 1),
];
# properties for owners
static var PLAYER_OWNER_OPACITY = 0;
static var PLAYER_OWNER_COLOR = { r = 0, g = 200, b = 255 };
static var PLAYER_FX_COLOR = { r = 255, g = 255, b = 255 };
static var PLAYER_TILE_COLOR = { r = 255, g = 255, b = 255 };
static var OPPONENT_OWNER_OPACITY = 80;
static var OPPONENT_OWNER_COLOR = { r = 255, g = 0, b = 0 };
static var OPPONENT_FX_COLOR = { r = 255, g = 100, b = 100 };
static var OPPONENT_TILE_COLOR = { r = 255, g = 100, b = 100 };
# colors for various situations
static var HP_COLOR = Color8(252, 0, 2)
static var ATK_COLOR = Color8(251, 254, 0)
static var MANA_COLOR = Color8(12, 82, 161)
static var MANA_BUFF_COLOR = Color8(13, 148, 23)
static var MANA_NERF_COLOR = Color8(161, 27, 18)
static var BUFF_COLOR = Color8(39, 233, 86)
static var NERF_COLOR = Color8(255, 50, 0)
static var PATH_COLOR = Color8(255, 255, 255)
static var MOVE_COLOR = Color8(240, 240, 240)
static var MOVE_ALT_COLOR = Color8(255, 255, 255)
static var MOVE_OPPONENT_COLOR = Color8(240, 240, 240)
static var MOVE_OPPONENT_ALT_COLOR = Color8(255, 255, 255)
static var AGGRO_COLOR = Color8(255, 217, 0)
static var AGGRO_ALT_COLOR = Color8(255, 255, 255)
static var AGGRO_OPPONENT_COLOR = Color8(210, 40, 70)
static var AGGRO_OPPONENT_ALT_COLOR = Color8(130, 25, 45)
static var NEUTRAL_COLOR = Color8(255, 217, 0)
static var NEUTRAL_ALT_COLOR = Color8(245, 245, 245)
static var SELECT_COLOR = Color8(255, 255, 255)
static var SELECT_OPPONENT_COLOR = Color8(210, 40, 70)
static var MOUSE_OVER_COLOR = Color8(255, 255, 255)
static var MOUSE_OVER_OPPONENT_COLOR = Color8(210, 40, 70)
static var CARD_PLAYER_COLOR = Color8(255, 217, 0)
static var CARD_PLAYER_ALT_COLOR = Color8(255, 255, 255)
static var CARD_OPPONENT_COLOR = Color8(210, 40, 70)
static var CARD_OPPONENT_ALT_COLOR = Color8(130, 25, 45)
static var INSTRUCTIONAL_TARGET_COLOR = Color8(255, 255, 255)

# Colors for instruction nodes
static var INSTRUCTION_NODE_BACKGROUND_COLOR = {
	r = 0, g = 0, b = 0, a = 255,
};
static var INSTRUCTION_NODE_OUTLINE_COLOR = {
	r = 255, g = 255, b = 255, a = 255,
};
static var INSTRUCTION_NODE_CARROT_BACKGROUND_COLOR = {
	r = 255, g = 69, b = 0, a = 255,
};
static var INSTRUCTION_NODE_CARROT_OUTLINE_COLOR = {
	r = 0, g = 0, b = 0, a = 200,
};
static var INSTRUCTION_NODE_TEXT_COLOR = { r = 255, g = 255, b = 255 };
static var INSTRUCTION_NODE_HIGHLIGHT_TEXT_COLOR = { r = 0, g = 255, b = 0 };
static var INSTRUCTION_NODE_HEADER_TITLE_COLOR = { r = 20, g = 128, b = 255 };
static var DIALOGUE_TEXT_COLOR = { r = 0, g = 0, b = 0 };
static var DIALOGUE_HIGHLIGHT_TEXT_COLOR = { r = 0, g = 255, b = 0 };
static var DIALOGUE_HEADER_TITLE_COLOR = { r = 20, g = 128, b = 255 };
# Config for instructional ui in tutorial
static var INSTRUCTIONAL_UI_INITIAL_OPACITY = 100;
static var INSTRUCTIONAL_UI_OVERLAP_OPACITY = 127;
static var INSTRUCTIONAL_UI_HIGHLIGHTED_OPACITY = 200;
static var INSTRUCTIONAL_UI_CORRECT_TARGET_OPACITY = 200;
# colors for attackable targets
# CONFIG.ATTACKABLE_TARGET_GLOW_RAMP_FROM = {r: 255, g: 50, b: 40};
# CONFIG.ATTACKABLE_TARGET_GLOW_RAMP_TRANSITION = {r: 255, g: 50, b: 40};
# CONFIG.ATTACKABLE_TARGET_GLOW_COLOR_TO = {r: 255, g: 50, b: 40};
# CONFIG.ATTACKABLE_TARGET_GLOW_EXPAND_MODIFIER = 2.25;
static var CONTINUE_TEXT_COLOR = { r = 141, g = 253, b = 255 };
static var CONTINUE_BUTTON_TEXT_COLOR = { r = 255, g = 255, b = 255 };
static var CONTINUE_BG_COLOR = {
  r = 19, g = 19, b = 49, a = 128,
};
static var BUY_TEXT_COLOR = { r = 141, g = 253, b = 255 };
static var BUY_BUTTON_TEXT_COLOR = { r = 255, g = 255, b = 255 };
static var BUY_BG_COLOR = {
  r = 19, g = 19, b = 49, a = 128,
};
static var SEASON_BG_COLOR = {
  r = 19, g = 19, b = 49, a = 192,
};

static var ATTACKABLE_TARGET_GLOW_RAMP_FROM = { r = 255, g = 210, b = 180 };
static var ATTACKABLE_TARGET_GLOW_RAMP_TRANSITION = { r = 255, g = 210, b = 180 };
static var ATTACKABLE_TARGET_GLOW_COLOR_TO = { r = 255, g = 210, b = 180 };
static var ATTACKABLE_TARGET_GLOW_RAMP_NOISE_COLOR = { r = 255, g = 210, b = 180 };

# threshold for something to be considered high damage
static var HIGH_DAMAGE = 7;
# how long screen focus takes to "fade" in
static var HIGH_DAMAGE_SCREEN_FOCUS_IN_DURATION = 0.1;
# how long screen focus sits idle
static var HIGH_DAMAGE_SCREEN_FOCUS_DELAY = 0.0;
# how long screen focus takes to "fade" out
static var HIGH_DAMAGE_SCREEN_FOCUS_OUT_DURATION = 0.25;
# screen shake on high damage
static var HIGH_DAMAGE_SCREEN_SHAKE_DURATION = 0.35;
static var HIGH_DAMAGE_SCREEN_SHAKE_STRENGTH = 20.0;
# radial blur on high damage
static var HIGH_DAMAGE_RADIAL_BLUR_SPREAD = 0.25;
static var HIGH_DAMAGE_RADIAL_BLUR_DEAD_ZONE = 0.2;
static var HIGH_DAMAGE_RADIAL_BLUR_STRENGTH = 0.5;
# threshold for something to be considered high cost
static var HIGH_COST = 5;
# how long screen focus takes to "fade" in
static var HIGH_COST_SCREEN_FOCUS_IN_DURATION = 0.1;
# how long screen focus sits idle
static var HIGH_COST_SCREEN_FOCUS_DELAY = 0.0;
# how long screen focus takes to "fade" out
static var HIGH_COST_SCREEN_FOCUS_OUT_DURATION = 0.5;
# screen shake on high cost
static var HIGH_COST_SCREEN_SHAKE_DURATION = 1.0;
static var HIGH_COST_SCREEN_SHAKE_STRENGTH = 5.0;
# radial blur on high cost
static var HIGH_COST_RADIAL_BLUR_SPREAD = 0.25;
static var HIGH_COST_RADIAL_BLUR_DEAD_ZONE = 0.2;
static var HIGH_COST_RADIAL_BLUR_STRENGTH = 0.5;

# color codes
static var COLOR_CODES = [
  { code = 0, cssClass = 'color-code-none' },
  { code = 1, cssClass = 'color-code-blue' },
  { code = 2, cssClass = 'color-code-cyan' },
  { code = 3, cssClass = 'color-code-green' },
  { code = 4, cssClass = 'color-code-magenta' },
  { code = 5, cssClass = 'color-code-purple' },
  { code = 6, cssClass = 'color-code-red' },
  { code = 7, cssClass = 'color-code-orange' },
  { code = 8, cssClass = 'color-code-yellow' },
];

#/**
 #* Start properties that you probably don't want to edit unless you know what they do.
 #*/
static var APP_SELECTOR = '#app';
static var MAIN_SELECTOR = '#app-main';
static var HORIZONTAL_SELECTOR = '#app-horizontal';
static var VERTICAL_SELECTOR = '#app-vertical';
static var OVERLAY_SELECTOR = '#app-overlay-region';
static var GAME_SELECTOR = '#app-game';
static var GAMECANVAS_SELECTOR = '#app-gamecanvas';
static var CONTENT_SELECTOR = '#app-content-region';
static var MODAL_SELECTOR = '#app-modal-region';
static var NOTIFICATIONS_SELECTOR = '#app-notifications-region';
static var UTILITY_SELECTOR = '#app-utility-region';
static var COLLECTION_SELECTOR = '#app-collection';
static var MAINTENANCE_ANNOUNCEMENTS_SELECTOR = '#maintenance-announcements-region';

static var DESTROY_TAG = 1001;
static var FADE_TAG = 1002;
static var MOVE_TAG = 1003;
static var ROTATE_TAG = 1004;
static var SCALE_TAG = 1005;
static var PULSE_TAG = 1006;
static var FOCUS_TAG = 1007;
static var GLOW_TAG = 1008;
static var TINT_TAG = 1009;
static var ANIM_TAG = 1010;
static var CARD_TAG = 1011;
static var SPEECH_TAG = 1012;
static var INFINITY = 9999;

# commonly used speed (movement range)

static var SPEED_BASE = 2;
static var SPEED_FAST = 3;
static var SPEED_INFINITE = BOARDCOL + BOARDROW;

# commonly used reach (attack range)

static var REACH_MELEE = 1;
static var REACH_RANGED = BOARDCOL + BOARDROW;

# convenient board values

static var WHOLE_BOARD_RADIUS = BOARDCOL if BOARDCOL > BOARDROW else BOARDROW;

static var ALL_BOARD_POSITIONS: PackedVector2Array = (func():
	var pattern: PackedVector2Array = [];
	for x: int in range(BOARDCOL):
		for y: int in range(BOARDROW):
			pattern.append(Vector2(x, y));
	return pattern
).call()


# commonly used patterns

static var PATTERN_1x1 = [
  { x = 0, y = 0 },
];
static var PATTERN_3x1 = [
  { x = -1, y = 0 },
  { x = 1, y = 0 },
  { x = 0, y = -1 },
  { x = 0, y = 1 },
  { x = 2, y = 0 },
  { x = -2, y = 0 },
  { x = 3, y = 0 },
  { x = -3, y = 0 },
];
static var PATTERN_3x2 = [
  { x = -1, y = 0 },
  { x = 0, y = 0 },
  { x = 1, y = 0 },
  { x = -1, y = -1 },
  { x = 0, y = -1 },
  { x = 1, y = -1 },
];
static var PATTERN_3x3 = [
  { x = -1, y = 0 },
  { x = 1, y = 0 },
  { x = 0, y = -1 },
  { x = 0, y = 1 },
  { x = -1, y = -1 },
  { x = 1, y = 1 },
  { x = 1, y = -1 },
  { x = -1, y = 1 },
];
static var PATTERN_3x3_INCLUDING_CENTER = [
  { x = -1, y = 0 },
  { x = 1, y = 0 },
  { x = 0, y = -1 },
  { x = 0, y = 0 },
  { x = 0, y = 1 },
  { x = -1, y = -1 },
  { x = 1, y = 1 },
  { x = 1, y = -1 },
  { x = -1, y = 1 },
];
static var PATTERN_2X2 = [
  { x = 0, y = 0 },
  { x = 0, y = 1 },
  { x = 1, y = 0 },
  { x = 1, y = 1 },
];
static var PATTERN_1X3 = [
  { x = 0, y = -1 },
  { x = 0, y = 0 },
  { x = 0, y = 1 },
];
static var PATTERN_3X1 = [
  { x = -1, y = 0 },
  { x = 0, y = 0 },
  { x = 1, y = 0 },
];
static var PATTERN_4SPACES = [
	Vector2(-4, 0),
	Vector2(-3, -1),
	Vector2(-3, 0),
	Vector2(-3, 1),
	Vector2(-2, -2),
	Vector2(-2, -1),
	Vector2(-2, 0),
	Vector2(-2, 1),
	Vector2(-2, 2),
	Vector2(-1, -3),
	Vector2(-1, -2),
	Vector2(-1, -1),
	Vector2(-1, 0),
	Vector2(-1, 1),
	Vector2(-1, 2),
	Vector2(-1, 3),
	Vector2(0, -4),
	Vector2(0, -3),
	Vector2(0, -2),
	Vector2(0, -1),
	Vector2(0, 0),
	Vector2(0, 1),
	Vector2(0, 2),
	Vector2(0, 3),
	Vector2(0, 4),
	Vector2(1, -3),
	Vector2(1, -2),
	Vector2(1, -1),
	Vector2(1, 0),
	Vector2(1, 1),
	Vector2(1, 2),
	Vector2(1, 3),
	Vector2(2, -2),
	Vector2(2, -1),
	Vector2(2, 0),
	Vector2(2, 1),
	Vector2(2, 2),
	Vector2(3, -1),
	Vector2(3, 0),
	Vector2(3, 1),
	Vector2(4, 0),
];

static var PATTERN_3SPACES_WITHOUT_CENTER = [
	Vector2(-3, 0),
	Vector2(-2, -1),
	Vector2(-2, 0),
	Vector2(-2, 1),
	Vector2(-1, -2),
	Vector2(-1, -1),
	Vector2(-1, 0),
	Vector2(-1, 1),
	Vector2(-1, 2),
	Vector2(0, -3),
	Vector2(0, -2),
	Vector2(0, -1),
	Vector2(0, 1),
	Vector2(0, 2),
	Vector2(0, 3),
	Vector2(1, -2),
	Vector2(1, -1),
	Vector2(1, 0),
	Vector2(1, 1),
	Vector2(1, 2),
	Vector2(2, -1),
	Vector2(2, 0),
	Vector2(2, 1),
	Vector2(3, 0),
]

static var PATTERN_3SPACES = [
  { x = -3, y = 0 },
  { x = -2, y = -1 },
{ x = -2, y = 0 },
{ x = -2, y = 1 },
  { x = -1, y = -2 },
{ x = -1, y = -1 },
{ x = -1, y = 0 },
{ x = -1, y = 1 },
{ x = -1, y = 2 },
  { x = 0, y = -3 },
{ x = 0, y = -2 },
{ x = 0, y = -1 },
{ x = 0, y = 0 },
{ x = 0, y = 1 },
{ x = 0, y = 2 },
{ x = 0, y = 3 },
  { x = 1, y = -2 },
{ x = 1, y = -1 },
{ x = 1, y = 0 },
{ x = 1, y = 1 },
{ x = 1, y = 2 },
  { x = 2, y = -1 },
{ x = 2, y = 0 },
{ x = 2, y = 1 },
  { x = 3, y = 0 },
];

static var PATTERN_2SPACES = [
  { x = -2, y = 0 },
  { x = -1, y = -1 }, { x = -1, y = 0 }, { x = -1, y = 1 },
  { x = 0, y = -2 }, { x = 0, y = -1 }, { x = 0, y = 0 }, { x = 0, y = 1 }, { x = 0, y = 2 },
  { x = 1, y = -1 }, { x = 1, y = 0 }, { x = 1, y = 1 },
  { x = 2, y = 0 },
];

static var PATTERN_1SPACE = [
  { x = -1, y = 0 },
  { x = 0, y = -1 }, { x = 0, y = 0 }, { x = 0, y = 1 },
  { x = 1, y = 0 },
];

static var PATTERN_CORNERS = [
  { x = 0, y = 0 },
  { x = 0, y = BOARDROW - 1 },
  { x = BOARDCOL - 1, y = 0 },
  { x = BOARDCOL - 1, y = BOARDROW - 1 },
];

static var PATTERN_WHOLE_BOARD = (func():
	const pattern = [];
	for x: int in range(-BOARDCOL, BOARDCOL):
		for y: int in range(-BOARDROW, BOARDROW):
			pattern.append(Vector2(x, y));
	return pattern;
).call()

static var PATTERN_HALF_BOARD = (func():
	const pattern = [];
	for x: int in range(floor(CONFIG.BOARDCOL / 2)):
		for y: int in range(CONFIG.BOARDROW):
			pattern.append(Vector2(x, y));
	return pattern;
).call()

static var PATTERN_WHOLE_ROW = (func():
	const pattern = [];
	for x: int in range(-floor(CONFIG.BOARDCOL / 2), ceil(CONFIG.BOARDCOL / 2)):
		pattern.append(Vector2(x, 0));
	return pattern;
).call()

static var PATTERN_WHOLE_COLUMN = (func():
	const pattern = [];
	for y: int in range(-floor(BOARDROW / 2), ceil(BOARDROW / 2)):
		pattern.append(Vector2(0, y))
	return pattern;
).call()

static var PATTERN_BLAST = (func():
	var pattern = [];
	for x: int in range(-CONFIG.BOARDCOL, CONFIG.BOARDCOL):
		if (x != 0):
			pattern.push(Vector2(x, 0))

	for y: int in range(-CONFIG.BOARDROW, CONFIG.BOARDROW):
		if (y != 0):
			pattern.push(Vector2(0, y))

	# we also want to include the normal pattern
	pattern = pattern.concat(CONFIG.PATTERN_3x3);

	# remove any duplicates
	const finalPattern = [];
	var il = pattern.length
	for i: int in range(il):
		var currentPosition = pattern[i];
		var x = currentPosition.x
		var y = currentPosition.y
		var unique = true;
		var jl = finalPattern.size()
		for j: int in range(jl):
			var position = finalPattern[j];
			if (x == position.x && y == position.y):
				unique = false;
				break;

		if (unique):
			finalPattern.append(currentPosition);

	return finalPattern;
).call()

static var TEST_LIGHT_TEMPLATE = {
  type = 'Light',
  radius = CONFIG.TILESIZE * 10,
  opacity = 255.0,
  intensity = 1.0,
  duration = 1.0,
  color = {
	r = 255,
	g = 255,
	b = 255,
  },
};

# bloom constant values
static var BLOOM_MIN = 0.5;
static var BLOOM_DEFAULT = 0.7;
static var BLOOM_MAX = 0.8;

# lighting quality constant values
static var LIGHTING_QUALITY_LOW = 0.0;
static var LIGHTING_QUALITY_MEDIUM = 0.5;
static var LIGHTING_QUALITY_HIGH = 1.0;

# shadow quality constant values
static var SHADOW_QUALITY_LOW = 0.0;
static var SHADOW_QUALITY_MEDIUM = 0.5;
static var SHADOW_QUALITY_HIGH = 1.0;

# board quality constant values
static var BOARD_QUALITY_LOW = 0.0;
static var BOARD_QUALITY_HIGH = 1.0;

# default volumes for a new user, between 0 and 1
static var DEFAULT_MASTER_VOLUME = 1.0;
static var DEFAULT_MUSIC_VOLUME = 0.04;
static var DEFAULT_VOICE_VOLUME = 0.3;
static var DEFAULT_SFX_VOLUME = 0.3;

# duration in seconds that interaction sfx will wait before playing
static var SFX_INTERACTION_DELAY = 0.06;

# duration in seconds that sfx will be considered playing for the purposes of volume modification
static var SFX_MULTIPLIER_DURATION_THRESHOLD = 0.35;

# power to which sfx volume will be lowered based on number of playing sfx
# where higher power will lower volume more aggressively and 0 will not lower volume at all
# equation: pow(1 / num sfx, multiplier power)
static var SFX_MULTIPLIER_POWER = 0.3;

# duration in seconds that interaction sfx will block other interaction sfx
static var INTERACTION_SFX_BLOCKING_DURATION_THRESHOLD = 0.5;

static var DEFAULT_SFX_PRIORITY = 0;
static var CLICK_SFX_PRIORITY = 1;
static var SELECT_SFX_PRIORITY = 2;
static var CANCEL_SFX_PRIORITY = 3;
static var CONFIRM_SFX_PRIORITY = 4;
static var SHOW_SFX_PRIORITY = 5;
static var HIDE_SFX_PRIORITY = 6;
static var ERROR_SFX_PRIORITY = 7;
static var MAX_SFX_PRIORITY = 9999;

# global scale - scale of game relative to resolution
# set dynamically on resize
static var globalScale = 1.0;

# pixel scale in engine - combined global scale and engine device pixel ratio
# set dynamically on resize
static var pixelScaleEngine = 1.0;

# pixel scale in CSS - combined global scale and css device pixel ratio
# set dynamically on resize
static var pixelScaleCSS = 1.0;

# resource scale in engine - scale at which resources should be loaded for use in engine
# set dynamically on resize
static var resourceScaleEngine = 1.0;

# resource scale in CSS - scale at which resources should be loaded for use in CSS
# set dynamically on resize
static var resourceScaleCSS = 1.0;

# resolution
# set dynamically by local storage
static var resolution = CONFIG.RESOLUTION_DEFAULT;

# whether HiDPI mode is enabled
# set dynamically by local storage
static var hiDPIEnabled = false;

# currently chosen main menu scene
# set dynamically by user profile and/or local storage
static var selectedScene = null;

# idle razer chroma color set by deck select
static var razerChromaIdleColor = null;

static func getGlobalScaleForResolution(resolution, width, height):
	var globalScale = 1.0;

	if (resolution != CONFIG.RESOLUTION_PIXEL_PERFECT):
		globalScale = min(width / CONFIG.REF_WINDOW_SIZE.width, height / CONFIG.REF_WINDOW_SIZE.height);

		# ensure scale is in multiples of CONFIG.GLOBAL_SCALE_MULTIPLE
		globalScale = round((globalScale) * 100) / 100;
		var globalScaleMult = globalScale % CONFIG.GLOBAL_SCALE_MULTIPLE;
		globalScale -= globalScaleMult;

		if (resolution == CONFIG.RESOLUTION_AUTO):
			var globalScaleDiff = globalScaleMult - CONFIG.GLOBAL_SCALE_SPACING;
			if (globalScale > 1.0 && globalScaleDiff < 0):
				globalScale -= CONFIG.GLOBAL_SCALE_MULTIPLE;

	return globalScale;


static var bloom
static var alwaysShowStats
static var showBattleLog
static var stickyTargeting
static var showInGameTips
static var lightingQuality
static var shadowQuality
static var boardQuality
static var gameSpeed
static var razerChromaEnabled

# called to reset config values that may rely on user profiles/preferences
static func reset():
	# amount of bloom
	# set dynamically by user profile
	CONFIG.bloom = CONFIG.BLOOM_DEFAULT;

	# whether unit stats are always visible
	# set dynamically by user profile
	CONFIG.alwaysShowStats = true;

	# whether battlelog is enabled
	# set dynamically by user profile
	CONFIG.showBattleLog = true;

	# whether sticky targeting of units is enabled
	# set dynamically by user profile
	CONFIG.stickyTargeting = false;

	# whether tips are shown in game
	# set dynamically by user profile
	CONFIG.showInGameTips = true;

	# quality of lighting in game
	# set dynamically by user profile
	CONFIG.lightingQuality = CONFIG.LIGHTING_QUALITY_HIGH;

	# quality of shadows in game
	# set dynamically by user profile
	CONFIG.shadowQuality = CONFIG.SHADOW_QUALITY_HIGH;

	# quality of board in game
	# set dynamically by user profile
	CONFIG.boardQuality = CONFIG.BOARD_QUALITY_HIGH;

	# speed of game for things such as action delays, unit movement, etc, where higher is faster
	# set dynamically by user profile
	CONFIG.gameSpeed = 0.0;

	# last game data
	CONFIG.resetLastGameData();

	# last selected deck data
	CONFIG.resetLastSelectedDeckData();

	# razer chroma integration
	CONFIG.razerChromaEnabled = false;


static var replayActionSpeedModifier
static var replaysCullDeadtime
static var lastGameType
static var lastGameWasSpectate
static var lastGameWasTutorial
static var lastGameWasDeveloper
static var lastGameWasDailyChallenge

static func resetLastGameData():
	# global animation speed modifier used by replay playback
	CONFIG.replayActionSpeedModifier = 1.0;

	# whether to cull deadtime in replays
	CONFIG.replaysCullDeadtime = true;

	# record of important last game properties
	CONFIG.lastGameType = null;
	CONFIG.lastGameWasSpectate = false;
	CONFIG.lastGameWasTutorial = false;
	CONFIG.lastGameWasDeveloper = false;
	CONFIG.lastGameWasDailyChallenge = false;


static var lastSelectedDeckId
static var lastSelectedSandboxPlayer1DeckId
static var lastSelectedSandboxPlayer2DeckId

static func resetLastSelectedDeckData():
	CONFIG.lastSelectedDeckId = null;
	CONFIG.lastSelectedSandboxPlayer1DeckId = null;
	CONFIG.lastSelectedSandboxPlayer2DeckId = null;
