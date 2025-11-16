saver = nil

function love.load()
	--love.window.setMode(1920, 1080, { fullscreen = true, fullscreentype = "desktop", resizable = true })
	love.window.setMode(640, 480, { fullscreen = false, fullscreentype = "desktop", resizable = false })
	binary = require("clocks.binary1")
	unix = require("clocks.unixtime")
	metacircles = require("sim.metacircles")
	hrt = require("game.hrt.hrt")
	savers = {
		binary,
		unix,
		metacircles,
		hrt,
	}

	-- saver = chooseRandom(savers)
	saver = hrt
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
	elseif saver["handleInput"] ~= nil then
		saver:handleInput(key, scancode, isrepeat)
	elseif key == "space" and not isrepeat and saver["action"] ~= nil then
		saver:action()
	end
end

function chooseRandom(from)
	return from[love.math.random(#from)]
end
