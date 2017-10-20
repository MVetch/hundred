function string.width(text, fontSize)
	return utf8len(tostring(text))*(fontSize*0.835)
end

function tern ( cond , T , F )
    if cond then return T else return F end
end

function degToRad(deg)
	return deg*math.pi/180
end

function getPercent(value, percents)
	return value * percents / 100
end

function topLeft(value)
	love.graphics.print(value, 0, 0)
end