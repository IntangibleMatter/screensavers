require("util.class")
require("math.vector2")

---@class Rect: Class
---@field x number
---@field y number
---@field w number
---@field h number
Rect = Class:extend({
	x = 0,
	y = 0,
	w = 0,
	h = 0,
})

---@return Vector2
function Rect:get_pos()
	return Vector2:new(self.x, self.y)
end

---@return Vector2
function Rect:get_size()
	return Vector2:new(self.w, self.h)
end

---@return boolean
---@param other Vector2|Rect
function Rect:intersects(other)
	if type(other) ~= "table" then
		return false
	end

	if other["w"] ~= nil then
		if other.x > self.x + self.w or self.x > other.w + other.x then
			return false
		elseif other.y > self.y + self.h or self.y > other.h + other.y then
			return false
		end
		return true
	else
		if other.x < self.x or other.x > self.x + self.w then
			return false
		elseif other.y < self.y or other.y > self.y + self.h then
			return false
		end
		return true
	end
end

---@return Rect
---@param other Rect
function Rect:get_intersecting_rect(other)
	local r = Rect:new()

	r.x = self.x > other.x and self.x or other.x
	r.y = self.y > other.y and self.y or other.y

	r.w = (self.x + self.w < other.x + other.w and self.x + self.w or other.x + other.w) - r.x
	r.h = (self.y + self.h < other.y + other.h and self.y + self.h or other.y + other.h) - r.y

	return r
end

---@param r? number
---@param g? number
---@param b? number
---@param a? number
function Rect:draw_bounds(r, g, b, a)
	love.graphics.setColor(r or 1, g or 0, b or 1, a or 0.8)

	love.graphics.rectangle("line", self.x, self.y, self.w, self.h)

	-- reset to default at end
	love.graphics.setColor(1, 1, 1, 1)
end
