slide = {
	s = {},
	default = {
		value = "",
		img = spincoinPic,
		selected = false,
		padding = {left = 3, top = 3, right = 3, bottom = 3},
		border = {left = 3, top = 3, right = 3, bottom = 3, c = {255,255,255}},
		backgroundColor = {255,255,255},
		slider = "skin"
	}
}

function slide:add(name, params)
	self.s[name] = {}
	if not params then params = {} end
	for k,v in pairs(self.default) do
		self:get(name)[k] = params[k] or v
	end
	table.insert(slider:get(self:get(name).slider).slides, name)
end

function slide:exists(name)
	return slide:get(name) ~= nil
end

function slide:get(name)
	return self.s[name]
end

function slide:draw(name, X, Y, w, h)
	love.graphics.setColor(self:get(name).backgroundColor)
	love.graphics.rectangle("fill", X, Y, w, h)
	love.graphics.setColor(self:get(name).border.c)
	drawable.border(X, Y, w, h, self:get(name).border)
	love.graphics.setColor(255, 255, 255)
	love.graphics.draw(
		self:get(name).img, 
		X + self:get(name).padding.left + self:get(name).border.left, 
		Y + self:get(name).padding.top + self:get(name).border.top, 
		0, 
		(w - self:get(name).padding.left - self:get(name).padding.right - self:get(name).border.left - self:get(name).border.right)/(self:get(name).img:getWidth()), 
		(h - self:get(name).padding.top - self:get(name).padding.bottom - self:get(name).border.top - self:get(name).border.bottom)/(self:get(name).img:getHeight())
	)
end