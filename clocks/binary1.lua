local M = {
	font = love.graphics.newFont("/assets/fonts/slapduck.ttf", 64, "none"),
	bitSize = 32,
	bitSpace = 48,
}

function M:load()
	self.font:setFilter("nearest", "nearest")
	love.graphics.setFont(self.font)
	self.canvas = love.graphics.newCanvas(6 * self.bitSpace, 4 * self.bitSpace)
	self.finalCanvas = love.graphics.newCanvas(self.canvas:getWidth() * 2 + 32, self.canvas:getHeight() * 2 + 32)
	self.text_y = self.bitSize

	self.canvas:setFilter("nearest", "nearest")
	self.finalCanvas:setFilter("nearest", "nearest")

	love.graphics.setLineStyle("rough")
end
--function M:update()
--end

function M:draw()
	love.graphics.setCanvas(self.canvas)
	love.graphics.clear()
	local time = os.time()

	local hours = os.date("%H", time)
	local mins = os.date("%M", time)
	local secs = os.date("%S", time)

	love.graphics.setColor(0, 0.8, 0, 1)

	self:drawBinaryNumber(self:numToBinary(tonumber(hours)), 4, self.bitSpace + self.bitSize / 2, self.bitSpace)
	self:drawBinaryNumber(self:numToBinary(tonumber(mins)), 5, self.bitSize / 2, self.bitSpace * 2)
	self:drawBinaryNumber(self:numToBinary(tonumber(secs)), 5, self.bitSize / 2, self.bitSpace * 3)
	love.graphics.setCanvas()

	love.graphics.setCanvas(self.finalCanvas)
	love.graphics.clear()
	love.graphics.draw(self.canvas, 16, 32, 0, 2, 2)
	self:drawCentredText("32", self.bitSize * 1.5 + (self.bitSpace * 0 * 2), self.text_y)
	self:drawCentredText("16", self.bitSize * 1.5 + (self.bitSpace * 1 * 2), self.text_y)
	self:drawCentredText("8", self.bitSize * 1.5 + (self.bitSpace * 2 * 2), self.text_y)
	self:drawCentredText("4", self.bitSize * 1.5 + (self.bitSpace * 3 * 2), self.text_y)
	self:drawCentredText("2", self.bitSize * 1.5 + (self.bitSpace * 4 * 2), self.text_y)
	self:drawCentredText("1", self.bitSize * 1.5 + (self.bitSpace * 5 * 2), self.text_y)

	love.graphics.setColor(1, 1, 1, 1)
	love.graphics.setCanvas()

	local _, _, ww, wh = love.window.getSafeArea()
	local cw = self.finalCanvas:getWidth()
	local ch = self.finalCanvas:getHeight()

	love.graphics.draw(self.finalCanvas, ww / 2, wh / 2, 0, 2, 2, cw / 2, ch / 2)
end

function M:drawBinaryNumber(num, bits, x, y)
	local empty = bits - #num
	for i = 0, empty do
		love.graphics.circle("line", x + i * self.bitSpace, y, self.bitSize / 2)
	end
	for i = 1, #num do
		if num:sub(i, i) == "1" then
			love.graphics.circle("fill", x + (i + empty) * self.bitSpace, y, self.bitSize / 2)
		else
			love.graphics.circle("line", x + (i + empty) * self.bitSpace, y, self.bitSize / 2)
		end
	end
end

function M:drawCentredText(text, x, y)
	local width = self.font:getWidth(text)
	local height = self.font:getHeight()

	love.graphics.print(text, x, y, 0, 1, 1, width / 2, height / 2)
end

function M:numToBinary(x)
	-- credit to https://gist.github.com/lexnewgate/28663fecae78324a87f38aa9c2e0a293
	ret = ""
	while x ~= 1 and x ~= 0 do
		ret = tostring(x % 2) .. ret
		x = math.modf(x / 2)
	end
	ret = tostring(x) .. ret
	return ret
end

return M
