local util = require "util"
local JOKES = require "jokes"
local JOKES_NSFW = require "jokes_nsfw"

local COLORS = {
  util.color("70b6ff"), -- blue
  util.color("9c7c60"), -- brown
  util.color("70f1ff"), -- cyan
  util.color("cb302a"), -- deep-red
  util.color("b7b7b7"), -- gray
  util.color("95e26c"), -- green
  util.color("ffa345"), -- orange
  util.color("7a9e96"), -- pine
  util.color("f96bcd"), -- pink
  util.color("9c70ff"), -- purple
  util.color("f27c52"), -- red
  util.color("f27c52"), -- vanilla-red
  util.color("ffdd45"), -- yellow
}

local SIZE = table_size(JOKES)
local SIZE_NSFW = table_size(JOKES_NSFW)
local COLOR_SIZE = table_size(COLORS)
local JOKES_SIZE = 0
local BUILDUP = 5 * 60 * 60 -- 5 min
local COOLDOWN = 10 * 60 * 60 -- 10 min

local function get_color()
  local c = math.random(COLOR_SIZE)
  return COLORS[c]
end

local function get_joke(n)
  if n > JOKES_SIZE or JOKES_SIZE == 0 then return "This isn't funny" end
  if n > SIZE then return JOKES_NSFW[n - SIZE] end
  return JOKES[n]
end

local function tell_a_joke()
  local rng = math.random(JOKES_SIZE)
  local msg = get_joke(rng)
  local color = get_color()
  game.print(msg[1], color)
end

local function update_buildup()
  BUILDUP = (settings.global["dj-buildup"].value or 5) * 60 * 60 
end

local function update_cooldown()
  COOLDOWN = (settings.global["dj-cooldown"].value or 10) * 60 * 60 
end

local function update_size()
  if settings.global["dj-nsfw"].value == true then 
    JOKES_SIZE = SIZE + SIZE_NSFW
  else
    JOKES_SIZE = SIZE
  end
end

local function init()
  update_buildup()
  update_cooldown()
  update_size()
end

local function tell_a_joke_wrapper(event)
  if event.tick < BUILDUP then return end
  if COOLDOWN == 0 then return end
  if event.tick % COOLDOWN ~= 0 then return end
  tell_a_joke()
end

---------------------------------------------------------------------------

script.on_init(init)
script.on_load(init)
script.on_configuration_changed(init)

script.on_event(defines.events.on_tick, wrapper)

commands.add_command("joke", "/joke", tell_a_joke)
