local M = {}

function M:load()
	self.font = love.graphics.newFont("/assets/fonts/foresight.ttf", 32)
	self.font:setFilter("nearest", "nearest")
	love.graphics.setFont(self.font)
end
--function M:update()
--end

function M:draw()
	local time = os.time()

	local hours = os.date("%H", time)
	local mins = os.date("%M", time)
	local secs = os.date("%S", time)

	love.graphics.setColor(1, 1, 0, 1)

	love.graphics.print(hours .. "H", 128, 128)
	love.graphics.print(mins .. "M", 128, 192)
	love.graphics.print(secs .. "S", 128, 256)
end

function M:drawBinaryNumber(num, bits) end

function M:numToBinary(num) end

return M
