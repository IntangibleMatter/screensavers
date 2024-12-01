local M = {}

function M:load()
	self.font = love.graphics.newFont("/assets/fonts/foresight.ttf", 64)
	self.font:setFilter("nearest", "nearest")
	love.graphics.setFont(self.font)
end
--function M:update()
--end

function M:draw()
	local time = os.time()
	local strtime = tostring(time)

	local width = self.font:getWidth(strtime)
	local height = self.font:getHeight()

	local _, _, ww, wh = love.window.getSafeArea()

	love.graphics.setColor(1, 1, 0, 1)

	love.graphics.print(strtime, ww / 2, wh / 2, 0, 1, 1, width / 2, height / 2)
end

function M:drawBinaryNumber(num, bits) end

function M:numToBinary(num) end

return M
