require("util.class")

---@class Vector2
---@field x number
---@field y number
Vector2 = Class:extend({
	x = 0,
	y = 0,
})

function Vector2:__add(self, other)
	local v = self:new()
	v.x = v.x + (other["x"] or 0)
	v.y = v.y + (other["y"] or 0)
	return v
end

function Vector2:__sub(self, other)
	local v = self:new()
	v.x = v.x - (other["x"] or 0)
	v.y = v.y - (other["y"] or 0)
	return v
end
