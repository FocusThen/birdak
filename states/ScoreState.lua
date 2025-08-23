ScoreState = Class({ __includes = BaseState })

function ScoreState:enter(params)
	self.score = params.score
end

function ScoreState:update(_)
	if love.keyboard.wasPressed("enter") or love.keyboard.wasPressed("return") or love.mouse.wasPressed(1) then
		gStateMachine:change("play")
	end
end

function ScoreState:render()
	love.graphics.setFont(dakFont)
	love.graphics.printf("Oof! You lost!", 0, 64, VIRTUAL_WIDTH, "center")

	love.graphics.setFont(mediumFont)
	love.graphics.printf("Score: " .. tostring(self.score), 0, 100, VIRTUAL_WIDTH, "center")

	love.graphics.printf("Press Enter or Click to Play Again!", 0, 160, VIRTUAL_WIDTH, "center")
end
