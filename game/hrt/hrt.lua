---@class HrtGame
---@field objects HrtObject[]
local M = {
	objects = {},
}

function M:load() end

---@param dt number
function M:update(dt) end

function M:draw() end

return M
