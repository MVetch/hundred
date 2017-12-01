screen:new("coincount",{
	draw = true,
	X = x-175,
	Y = 70,
	w = 150,
	h = 100
})
screen:get("coincount").show = function ()
	love.graphics.setColor(0,0,0)
	love.graphics.setFont(buttonFont)
	love.graphics.print(settings.coins, 60, 0)
	love.graphics.setColor(255,255,255)
	animation:draw("spincoin", 0, 0, 50, 50)
end
animation:new("spincoin", {img = spincoinAnimate, w = 100, h = 100, duration = 1})