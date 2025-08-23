_G.push = require("libs.push")

_G.Class = require("libs.class")

require("components.Dak")
require("components.Pipe")
require("components.PipePair")
require("components.StateMachine")
require("states.BaseState")
require("states.PlayState")
require("states.TitleScreenState")

WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

VIRTUAL_WIDTH = 512
VIRTUAL_HEIGHT = 288

local background = love.graphics.newImage("assets/background.png")
local backgroundScroll = 0
local ground = love.graphics.newImage("assets/ground.png")
local groundScroll = 0

local BACKGROUND_SCROLL_SPEED = 30
local GROUND_SCROLL_SPEED = 60

local BACKGROUND_LOOPING_POINT = 413
-- local GROUND_LOOPING_POINT = 514

function love.load()
	love.graphics.setDefaultFilter("nearest", "nearest")
	love.window.setTitle("Birdak")

	_G.smallFont = love.graphics.newFont("assets/font.ttf", 8)
	_G.mediumFont = love.graphics.newFont("assets/font.ttf", 14)
	_G.dakFont = love.graphics.newFont("assets/dak.ttf", 28)
	_G.hugeFont = love.graphics.newFont("assets/font.ttf", 56)
	love.graphics.setFont(dakFont)

	push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
		vsync = true,
		fullscreen = false,
		resizable = true,
	})

	_G.gStateMachine = StateMachine({
		["title"] = function()
			return TitleScreenState()
		end,
		["play"] = function()
			return PlayState()
		end,
	})
	_G.gStateMachine:change("title")

	love.keyboard.keysPressed = {}
end

function love.update(dt)
	backgroundScroll = (backgroundScroll + BACKGROUND_SCROLL_SPEED * dt) % BACKGROUND_LOOPING_POINT
	groundScroll = (groundScroll + GROUND_SCROLL_SPEED * dt) % VIRTUAL_WIDTH

	gStateMachine:update(dt)

	-- reset
	love.keyboard.keysPressed = {}
end

function love.draw()
	push:start()
	love.graphics.draw(background, -backgroundScroll, 0)

	gStateMachine:render()

	love.graphics.draw(ground, -groundScroll, VIRTUAL_HEIGHT - 16)

	push:finish()
end

function love.keypressed(key)
	love.keyboard.keysPressed[key] = true
	if key == "escape" then
		love.event.quit()
	end
end

function love.keyboard.wasPressed(key)
	return love.keyboard.keysPressed[key]
end

function love.resize(w, h)
	push:resize(w, h)
end
