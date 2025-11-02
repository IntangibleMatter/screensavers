require("game.hrt.object")
require("math.vector2")
require("math.util")

---@class Horse: HrtObject
---@field velocity Vector2
---@field speed number
---@field direction number
Horse = HrtObject:extend({
	velocity = Vector2:new(),
	speed = 128,
	direction = 0,
})

function Horse:update(dt)
	self:recalculate_velocity()
	self:move()
	if self.position.x > 640 then
		self.position.x = 2
	elseif self.position.x < 0 then
		self.position.x = 638
	end
	if self.position.y > 480 then
		self.position.y = 2
	elseif self.position.y < 0 then
		self.position.y = 438
	end
end

function Horse:move()
	local rx = math.floor(self.velocity.x)
	local ry = math.floor(self.velocity.y)

	while rx ~= 0 or ry ~= 0 do
		if rx ~= 0 then
			local x1 = self.position.x
			self.position.x = self.position.x + sign(rx)
			rx = rx - sign(rx)

			if self:collision_checks() then
				print("COLLISIONX", x1, rx)
				rx = 0
				self.position.x = x1
				self.direction = self.direction + math.pi
			end
		end
		if ry ~= 0 then
			local y1 = self.position.y
			self.position.y = self.position.y + sign(ry)
			ry = ry - sign(ry)

			if self:collision_checks() then
				print("COLLISIONY", y1, ry)
				ry = 0
				self.position.x = y1
				self.direction = self.direction + math.pi
			end
		end
	end
end

function Horse:recalculate_velocity()
	self.velocity.x = self.speed * math.cos(self.direction)
	self.velocity.y = self.speed * math.sin(self.direction)
end
