require("util.class")
require("math.vector2")
require("math.rect")

---@class HrtObject: Class
---@field img love.Image
---@field imgdata love.ImageData Create this first, then make the image from the data
---@field collider Rect
---@field position Vector2
---@field alpha_threshold number
---@field context HrtGame
HrtObject = Class:extend({
	img = nil,
	imgdata = nil,
	collider = nil,
	position = nil,
	alpha_threshold = 0.5,
	colliding = false,
	context = nil,
})

function HrtObject:init(opts)
	self.collider = Rect:new()
	self.position = Vector2:new(256, 256)
	for k, v in pairs(opts) do
		-- print("set?", k, v, type(v))
		self[k] = v
	end
end

---@param dt number
function HrtObject:update(dt) end

function HrtObject:draw()
	love.graphics.draw(self.img, self.position.x, self.position.y)
	self:draw_bounds()
end

---@return boolean
function HrtObject:collision_checks()
	for _, o in pairs(self.context.objects) do
		if o ~= self then
			if self:collision_check(o) then
				return true
			end
		end
	end
	if
		self.position.x <= 0
		or self.position.y <= 0
		or self.position.x + self.imgdata:getWidth() >= 640
		or self.position.y + self.imgdata:getHeight() >= 480
	then
		return true
	end
	return false
end

---@return boolean
---@param other HrtObject
function HrtObject:collision_check(other)
	if self:intersects_object_collider(other) then
		return self:pixel_collision(other)
	end
	return false
end

---@param other HrtObject
function HrtObject:intersects_object_collider(other)
	local ocol = other.collider:new()
	ocol.x = ocol.x + other.position.x
	ocol.y = ocol.y + other.position.y
	return self:intersects_rect(ocol)
end

---@param other Rect
function HrtObject:intersects_rect(other)
	local scol = self.collider:new()
	scol.x = scol.x + self.position.x
	scol.y = scol.y + self.position.y
	return scol:intersects(other)
end

---@return boolean
---@param other HrtObject
---@param o_collider? Rect For handling the backdrop
function HrtObject:pixel_collision(other, o_collider)
	local scol = self.collider:new()
	local ocol = other.collider:new()

	scol.x = scol.x + self.position.x
	scol.y = scol.y + self.position.y

	ocol.x = ocol.x + other.position.x
	ocol.y = ocol.y + other.position.y

	local intersection = scol:get_intersecting_rect(o_collider or ocol)
	for x = intersection.x, intersection.x + intersection.w do
		for y = intersection.y, intersection.y + intersection.h do
			-- convert to local coordinates to check the images
			local ox = x - other.position.x
			local oy = y - other.position.y
			local sx = x - self.position.x
			local sy = y - self.position.y

			if ox > 1 and ox < other.imgdata:getWidth() - 1 and oy > 1 and oy < other.imgdata:getHeight() - 1 then
				if sx > 1 and sx < self.imgdata:getWidth() - 1 and sy > 1 and sy < self.imgdata:getHeight() - 1 then
					local _, _, _, oa = other.imgdata:getPixel(ox, oy)
					local _, _, _, sa = self.imgdata:getPixel(sx, sy)

					if oa > self.alpha_threshold and sa > self.alpha_threshold then
						return true
					end
				end
			end
		end
	end
	return false
end

---@param idat love.ImageData
function HrtObject:setImageData(idat)
	self.imgdata = idat
	self.img = love.graphics.newImage(idat)

	self.collider.w = self.imgdata:getWidth()
	self.collider.h = self.imgdata:getHeight()
end

function HrtObject:draw_bounds()
	love.graphics.setColor(1, 0, 1, 1)

	love.graphics.push()

	love.graphics.translate(self.position.x, self.position.y)
	if self.colliding then
		self.collider:draw_bounds(1, 0, 0, 1)
	else
		self.collider:draw_bounds()
	end

	love.graphics.pop()

	-- reset to default at end
	love.graphics.setColor(1, 1, 1, 1)
end
