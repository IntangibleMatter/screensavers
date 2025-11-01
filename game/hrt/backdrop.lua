require("game.hrt.object")

---@class Backdrop: HrtObject
---@field colliders Rect[]
---@field collider_size number
Backdrop = HrtObject:extend({
	colliders = {},
	collider_size = 32,
})

function Backdrop:generate_colliders()
	---@return boolean
	local check_for_pixels = function(sx, sy)
		for x = sx, sx + self.collider_size do
			for y = sy, sy + self.collider_size do
				local _, _, _, a = self.imgdata:getPixel(x, y)
				if a > 0.5 then
					return true
				end
			end
		end
		return false
	end

	for x = 1, self.imgdata:getWidth(), self.collider_size do
		for y = 1, self.imgdata:getHeight(), self.collider_size do
			if check_for_pixels(x, y) then
				local r = Rect:new({ x = x, y = y, w = self.collider_size, h = self.collider_size })
				table.insert(self.colliders, r)
			end
		end
	end
end
