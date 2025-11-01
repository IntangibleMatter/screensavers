require("util.class")

---@class HrtObject: Class
---@field img love.Image
---@field imgdata love.ImageData Create this first, then make the image from the data
---@field collider Rect
---@field position Vector2
---@field alpha_threshold number
HrtObject = Class:extend({
	img = nil,
	imgdata = nil,
	collider = nil,
	position = nil,
	alpha_threshold = 0.5,
})

function HrtObject:update() end

function HrtObject:draw() end

---@param other HrtObject
function HrtObject:intersects_object_collider(other)
	local ocol = other.collider:new()
	ocol.x = other.collider.x + other.position.x
	return self:intersects_rect(other.collider:new())
end

---@param other Rect
function HrtObject:intersects_rect(other)
	return self.collider:intersects(other)
end

---@return boolean
---@param other HrtObject
---@param o_collider? Rect For handling the backdrop
function HrtObject:pixel_collision(other, o_collider)
	local intersection = self.collider:get_intersecting_rect(o_collider or other.collider)
	for x = intersection.x, intersection.x + intersection.w do
		for y = intersection.y, intersection.y + intersection.h do
			-- convert to local coordinates to check the images
			local ox = x - other.position.x
			local oy = y - other.position.y
			local sx = x - self.position.x
			local sy = y - self.position.y

			if ox > 0 and ox < other.imgdata:getWidth() and oy > 0 and oy < other.imgdata:getHeight() then
				if sx > 0 and sx < other.imgdata:getWidth() and sy > 0 and sy < other.imgdata:getHeight() then
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
