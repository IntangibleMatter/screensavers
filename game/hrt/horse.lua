require("game.hrt.object")
require("math.vector2")
require("math.util")

---@class Horse: HrtObject
---@field velocity Vector2
---@field velrem Vector2
---@field speed number
---@field direction number
Horse = HrtObject:extend({
	velocity = Vector2:new(),
	velrem = Vector2:new(0, 0),
	speed = 128,
	direction = 0,
})

function Horse:update(dt)
	self:recalculate_velocity()
	self:move(dt)
	if self.position.x > 642 then
		self.position.x = 2
	elseif self.position.x < -2 then
		self.position.x = 638
	end
	if self.position.y > 482 then
		self.position.y = 2
	elseif self.position.y < -2 then
		self.position.y = 438
	end
end

function Horse:draw()
	HrtObject.draw(self)
	local cx = self.position.x + self.imgdata:getWidth() / 2
	local cy = self.position.y + self.imgdata:getHeight() / 2
	love.graphics.line(cx, cy, cx + math.cos(self.direction) * 32, cy + math.sin(self.direction) * 32)
end

---@param dt number
function Horse:move(dt)
	-- print("\n----------")
	self.velrem.x = self.velrem.x + self.velocity.x * dt
	self.velrem.y = self.velrem.y + self.velocity.y * dt
	local rx = math.floor(self.velrem.x)
	local ry = math.floor(self.velrem.y)
	self.velrem.x = self.velrem.x - rx
	self.velrem.y = self.velrem.y - ry

	-- print("rrr", rx, ry, self.velrem.x, self.velrem.y)
	local sx = sign(rx)
	local sy = sign(ry)

	local flipped = false

	local bx, by = self.position.x, self.position.y

	while rx ~= 0 or ry ~= 0 do
		if rx ~= 0 then
			local x1 = self.position.x
			self.position.x = self.position.x + sx
			rx = rx - sx

			if self:collision_checks() then
				print("COLLISIONX", x1, rx, self.position.x)

				self.position.x = x1 - sx
				rx = 0
				-- local alt = math.acos(math.cos(self.direction) * -1

				if not flipped then
					flipped = true
					local dirx = math.cos(self.direction)
					local diry = math.sin(self.direction)
					dirx = -dirx + math.random(-0.1, 0.1)
					self.direction = math.atan2(diry, dirx)
					self:recalculate_velocity()
				end
			end
		end
		if ry ~= 0 then
			local y1 = self.position.y
			self.position.y = self.position.y + sy
			ry = ry - sy

			if self:collision_checks() then
				print("COLLISIONY", y1, ry, self.position.y)

				self.position.y = y1 - sy
				ry = 0
				-- self.direction = self.direction + math.pi
				--
				if not flipped then
					flipped = true
					local dirx = math.cos(self.direction)
					local diry = math.sin(self.direction)
					diry = -diry + math.random(-0.1, 0.1)

					self.direction = math.atan2(diry, dirx)
					self:recalculate_velocity()
				end
			end
		end
	end

	-- print("moved", bx, by, self.position.x, self.position.y)
end

function Horse:recalculate_velocity()
	self.velocity.x = self.speed * math.cos(self.direction)
	self.velocity.y = self.speed * math.sin(self.direction)
	-- for k, v in pairs(self.velocity) do
	-- 	print("vec", k, v)
	-- end
	-- print(self.velocity.x, self.velocity.y, self.velocity:magnitude())
end
