saver = nil

function love.load()
	love.window.setMode(1920, 1080, { fullscreen = true, fullscreentype = "desktop", resizable = true })
	binary = require("clocks.binary1")
	unix = require("clocks.unixtime")
	metacircles = require("sim.metacircles")
	savers = {
		binary,
		unix,
		metacircles,
	}

	saver = chooseRandom(savers)
	print("saver ", saver)

	saver:load()
end

function love.draw()
	saver:draw()
end

function love.update(dt)
	if saver.update ~= nil then
		saver:update(dt)
	end
end

function love.keypressed(key, scancode, isrepeat)
	if key == "escape" then
		love.event.quit()
	elseif key == "r" and not isrepeat then
		local csaver = saver
		while saver == csaver do
			saver = chooseRandom(savers)
		end
		saver:load()
	elseif key == "space" and not isrepeat and saver["action"] ~= nil then
		saver:action()
	end
end

function chooseRandom(from)
	return from[love.math.random(#from)]
end
