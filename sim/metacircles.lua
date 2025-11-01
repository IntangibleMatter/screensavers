local M = {
	palettes = {
		testpal = love.graphics.newImage("/assets/graphics/metacircles/palettes/testpal.png"),
	},
	circle = love.graphics.newImage("/assets/graphics/metacircles/circle.png"),
	shadercode = love.filesystem.read("string", "/sim/metacircles.glsl"),
	circles = {},
	circleCount = 32,
}

function M:load()
	self.shader = love.graphics.newShader(self.shadercode)
	self.ncanvas = love.graphics.newCanvas(love.graphics.getDimensions())
	love.graphics.setShader(self.shader)
	if self.shader:hasUniform("sampler") then
		self.shader:send("sampler", self.palettes.testpal)
	end
	self:createCircles()
end

function M:draw()
	--love.graphics.setColor(0, 0, 0, 1)
	--love.graphics.rectangle("fill", 0, 0, love.graphics.getDimensions())
	--love.graphics.setColor(1, 1, 1, 1)
	--love.graphics.setShader()
	local cw, ch = self.circle:getDimensions()
	local hcw, hch = cw / 2, ch / 2
	love.graphics.setCanvas(self.ncanvas)
	cw = cw / 2
	ch = ch / 2
	love.graphics.clear(0, 0, 0, 1)
	--love.graphics.setColor(0.1, 0.1, 0.1, 1)
	--love.graphics.rectangle("fill", 0, 0, love.graphics.getDimensions())
	love.graphics.setColor(1, 1, 1, 1)
	for _, circle in pairs(self.circles) do
		love.graphics.draw(
			self.circle,
			circle.position.x,
			circle.position.y,
			0,
			circle.scale,
			circle.scale,
			hcw * circle.scale,
			hch * circle.scale
		)
	end
	love.graphics:setCanvas()
	love.graphics.setShader(self.shader)
	love.graphics.setColor(1, 1, 1, 1)
	love.graphics.draw(self.ncanvas, 0, 0)
	love.graphics.setShader()
end
function M:update(dt)
	local sw, sh = love.graphics.getDimensions()
	local cw, ch = self.circle:getDimensions()
	for _, circle in pairs(self.circles) do
		circle.position.x = circle.position.x + circle.speed * math.cos(circle.angle) * dt
		circle.position.y = circle.position.y + circle.speed * math.sin(circle.angle) * dt
		circle.speed = circle.speed + circle.accel * dt
		if circle.speed > 40 then
			circle.speed = 40
		elseif circle.speed < 2 then
			circle.speed = 2
		end
		if circle.position.x < -cw * circle.scale then
			circle.position.x = sw + cw * circle.scale
		elseif circle.position.x > sw + cw * circle.scale + 5 then
			circle.position.x = -cw * circle.scale - 2
		end
		if circle.position.y < -cw * circle.scale - 10 then
			circle.position.y = sh + cw * circle.scale + 5
		elseif circle.position.y > sh + cw * circle.scale + 10 then
			circle.position.y = -ch * circle.scale - 2
		end
	end
end

function M:createCircles()
	local w, h = love.graphics.getDimensions()
	local cw, ch = self.circle:getDimensions()
	for _ = 1, self.circleCount do
		local ncirc = {
			speed = love.math.random(10, 32),
			angle = love.math.random(0, 6.28),
			accel = love.math.random(-10, 10),
			jolt = love.math.random(-10, 10),
			raccel = love.math.random(0, 1),
			rjolt = love.math.random(0, 0.5),
			position = {
				x = love.math.random(cw / 2, w + cw / 2),
				y = love.math.random(ch / 2, h + ch / 2),
			},
			scale = math.random(0.5, 1.5),
		}
		table.insert(self.circles, ncirc)
	end
end

return M
