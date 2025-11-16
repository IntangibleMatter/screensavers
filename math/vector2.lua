require("util.class")

---@class Vector2: Class
---@field x number
---@field y number
Vector2 = Class:extend({
	x = 0,
	y = 0,
	magnitude = function(self)
		return math.sqrt(self.x * self.x + self.y * self.y)
	end,
	-- classname = "Vector2",
})

function Vector2:init(x, y)
	self.x = x
	self.y = y
end

---@return number
function Vector2:magnitude()
	return math.sqrt(self.x * self.x + self.y * self.y)
end

function Vector2:__add(other)
	local v = self:new()
	v.x = v.x + (other["x"] or 0)
	v.y = v.y + (other["y"] or 0)
	return v
end

function Vector2:__sub(other)
	local v = self:new()
	v.x = v.x - (other["x"] or 0)
	v.y = v.y - (other["y"] or 0)
	return v
end

function Vector2:__mul(other)
	local v = self:new()
	v.x = v.x * (type(other) == "number" and other or other["x"])
	v.y = v.y * (type(other) == "number" and other or other["y"])
	return v
end

function Vector2:__div(other)
	local v = self:new()
	v.x = v.x / (type(other) == "number" and other or other["x"])
	v.y = v.y / (type(other) == "number" and other or other["y"])
	return v
end
