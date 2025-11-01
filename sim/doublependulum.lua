local M = {
	g = 9.8,
	s1 = { -- system 1
		m1 = 1, -- mass
		m2 = 1,
		l1 = 1, -- length
		l2 = 1,
	},
}

function M:update(dt) end
--[[
function M:calcEk()
	self.ek = (0.5 * self.p1.m * self.p1.v * self.p1.v) + (0.5 * self.p2.m * self.p2.v * self.p2.v)
end

function M:calcEv()
	self.ep = -(self.p1.m * self.g * self.p1.l * math.cos(self.p1.va))
		- (self.p2.m * self.g * (self.p1.l * math.cos(self.p1.va) + self.p2.l * math.cos(self.p2.va)))
end


function M:calcVel()
	self.p1.v = self.p1.l * self.p1.va
	self.p2.v = math.sqrt(
		(self.p1.l * self.p1.l * self.p1.va * self.p1.va)
			+ (self.p2.l * self.p2.l * self.p2.va * self.p2.va)
			+ (2 * self.p1.l * self.p2.l * self.p1.va * self.p2.va * math.cos(self.p1.va - self.p2.va))
	)
end
]]
--

return M
