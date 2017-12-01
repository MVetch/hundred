slider = {
	s = {},
	default = {
		slideCount = 5,
		backgroundColor = {0,0,0},
		multiple = false
	}
}

function slider:add(name, params)
	self.s[name] = {}
	if not params then params = {} end
	for k,v in pairs(self.default) do
		self:get(name)[k] = params[k] or v
	end
	self.s[name].slides = {}
end

function slider:exists(name)
	return slider:get(name) ~= nil
end

function slider:get(name)
	return self.s[name]
end

function slider:draw(name, X, Y, w, h)
	love.graphics.setColor(self:get(name).backgroundColor)
	love.graphics.rectangle("fill", X, Y, w, h)
	for i = 1, table.getn(self:get(name).slides), 1 do
		slide:draw(
			self:get(name).slides[i],
			X + (i-1)*w/table.getn(self:get(name).slides),
			Y,
			w/table.getn(self:get(name).slides),
			h
		)
	end
end