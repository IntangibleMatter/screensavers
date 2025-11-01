require("game.hrt.object")

---@class Horse: HrtObject
---@field velocity Vector2
---@field speed number
---@field direction number
Horse = Class:extend({
	velocity = Vector2:new(),
	speed = 10,
	direction = 0,
})

function Horse:recalculate_velocity()
	self.velocity.x = self.speed * math.cos(self.direction)
	self.velocity.y = self.speed * math.sin(self.direction)
end
