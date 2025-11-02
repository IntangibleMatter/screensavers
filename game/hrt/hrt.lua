---@class HrtGame
---@field objects HrtObject[]
local M = {
	objects = {},
	canvas = nil,
}

function M:load()
	require("game.hrt.horse")
	require("game.hrt.object")

	love.graphics.setDefaultFilter("nearest", "nearest")
	self.canvas = love.graphics.newCanvas(640, 480)

	---@type Horse
	local jov = Horse:new()
	jov:setImageData(love.image.newImageData("assets/graphics/hrt/jovial.png"))
	jov.direction = math.pi / 3
	local yel = Horse:new()
	yel:setImageData(love.image.newImageData("assets/graphics/hrt/yellow.png"))

	table.insert(self.objects, jov)
	table.insert(self.objects, yel)

	for _, o in pairs(self.objects) do
		o.context = self
	end
end

---@param dt number
function M:update(dt)
	--[[for _, obj in pairs(self.objects) do
		for _, o2 in pairs(self.objects) do
			if obj ~= o2 then
				if obj:intersects_object_collider(o2) then
					obj.colliding = obj:pixel_collision(o2)
				end
				-- print(obj.colliding)
			end
		end
	end]]

	for _, obj in pairs(self.objects) do
		obj:update(dt)
	end

	---@type Horse
	local jov = self.objects[1]
	if love.keyboard.isDown("up") then
		jov.position.y = jov.position.y - jov.speed * dt
	elseif love.keyboard.isDown("down") then
		jov.position.y = jov.position.y + jov.speed * dt
	end
	if love.keyboard.isDown("left") then
		jov.position.x = jov.position.x - jov.speed * dt
	elseif love.keyboard.isDown("right") then
		jov.position.x = jov.position.x + jov.speed * dt
	end
end

function M:draw()
	love.graphics.setCanvas(self.canvas)
	love.graphics.clear(0.5, 0.5, 0.5, 1)

	for _, object in pairs(self.objects) do
		object:draw()
	end
	love.graphics.setCanvas()
	love.graphics.draw(self.canvas, 0, 0, 0, 2, 2)
end

function M:action() end

---@param key love.KeyConstant
---@param scancode love.Scancode
---@param isrepeat boolean
function M:handleInput(key, scancode, isrepeat) end

return M
