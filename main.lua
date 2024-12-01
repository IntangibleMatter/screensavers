function love.load()
	love.window.setMode(1920, 1080, { resizable = true })
	binary = require("clocks.binary1")
	unix = require("clocks.unixtime")
	saver = unix

	saver:load()
end

function love.draw()
	saver:draw()
end
