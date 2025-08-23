TitleScreenState = Class({ __includes = BaseState })

function TitleScreenState:init() end

function TitleScreenState:update(_)
	if love.keyboard.wasPressed("enter") or love.keyboard.wasPressed("return") or love.mouse.wasPressed(1) then
		gStateMachine:change("countdown")
	end
end

function TitleScreenState:render()
	love.graphics.setFont(dakFont)
	love.graphics.printf("Fifty Bird", 0, 64, VIRTUAL_WIDTH, "center")

	love.graphics.setFont(mediumFont)
	love.graphics.printf("Press Enter or Left Click", 0, 100, VIRTUAL_WIDTH, "center")
end
