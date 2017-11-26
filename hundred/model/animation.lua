animation = {
	default = {
		img = skinCircle,
		w = 0,
		h = 0,
		duration = 1,
		time = 0,
		X = 0,
		Y = 0
	},
	a = {}
}
function animation:new(name, params)
	self.a[name] = {}
	if not params then params = {} end
	for k,v in pairs(animation.default) do
		self.a[name][k] = params[k] or v
	end
	self.a[name].quads = {}
	--table.insert(self.a[name].quads, love.graphics.newQuad(0, 0, 300, 600, self.a[name].img:getDimensions()))
	for i = 0, self.a[name].img:getHeight() - self.a[name].h, self.a[name].h do
        for j = 0, self.a[name].img:getWidth() - self.a[name].w, self.a[name].w do
            table.insert(self.a[name].quads, love.graphics.newQuad(j, i, self.a[name].w, self.a[name].h, self.a[name].img:getDimensions()))
        end
    end
end
function animation:draw(name, X, Y, w, h)
	w = w or animation:get(name).w
	h = h or animation:get(name).h
    animation:get(name).time = animation:get(name).time + 1/60
    if animation:get(name).time >= animation:get(name).duration then
        animation:get(name).time = animation:get(name).time - animation:get(name).duration
    end
    love.graphics.draw(
    	animation:get(name).img,
    	animation:get(name).quads[math.floor(animation:get(name).time / animation:get(name).duration * #animation:get(name).quads) + 1], 
    	X, 
    	Y,
    	0,
    	w/animation:get(name).w,
    	h/animation:get(name).h
    )
end

function animation:get(name)
	if not animation:exists(name) then
		error("animation " .. name .. " doesn't exist")
	end
	return self.a[name]
end

function animation:exists(name)
	return self.a[name] ~= nil
end