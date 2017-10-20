click = {X = 0, Y = 0}
function love.mousepressed(clickX, clickY, buttonClick, istouch)
	click.X = clickX
	click.Y = clickY
	if buttonClick == 1 then
		--------------------------------------------------------------------------------------
		if game.draw then
			if click.inside(equalButton) then
				getAnswer(resultString)
			elseif click.inside(answerField) and answer == "100! You won! Click here to try again." then
				setDefaultValues()
			elseif not runButtonBlocked then --run button click
				if 	click.inside(runButton) then
					rotateFlag = not rotateFlag
					if not rotateFlag and amountOfTries < 6 then
						while mainCircle.angle > 2*math.pi do
							mainCircle.angle = mainCircle.angle - 2*math.pi
						end
						result = 0
						tangle = mainCircle.angle
						while tangle > degToRad(36) do
							tangle = tangle - degToRad(36)
							result = result + 1
						end
						results[amountOfTries+1].value = result
						amountOfTries = amountOfTries + 1
						if onlinePlay then
							udp:send(string.format("%s %d %d %d", 'setValue', roomId, amountOfTries, result))
						end
					end
					time = os.clock()
				end
			end
			for i=1,10,1 do --operations click
				if 	click.inside(operationButtons[i]) then
					if operationButtons[i].value == "C" then
						if isNumber(string.sub(resultString,-1)) then
							for j=1,6,1 do
								if results[j].value == "" then
									results[j].value = string.sub(resultString,-1)
									results[j].clicked = false
									break
								end
							end
						end
						local byteoffset = utf8.offset(resultString, -1)
				        if byteoffset then
				            resultString = string.sub(resultString, 1, byteoffset - 1)
				        end
					else
						resultString = resultString .. operationButtons[i].value
					end
				end
			end
			for i=1,6,1 do --number click
				if click.inside(results[i]) then
					if not results[i].clicked and results[i].value ~= "" then
						resultString = resultString .. results[i].value
						results[i].clicked = true
						results[i].value = ""
					end
				end
			end
		end
		--------------------------------------------------------------------------------------
		if menu.draw then
			if click.inside(playOfflineButton) then
				menu.draw = false
				game.draw = true
			elseif click.inside(playOnlineButton) then
				menu.draw = false
				onlinePlay = true
				if myId then
					udp:send(string.format('%s %d', 'search', myId))
					wait.draw = true
				else
					noNetWork.draw = true
				end
			end
		end
		--------------------------------------------------------------------------------------
		if noNetWork.draw then
			if click.inside(returnButton) then
				noNetWork.draw = false
				menu.draw = true
			end
		end
		--------------------------------------------------------------------------------------
		if wait.draw then
			if click.inside(returnButton) then
				wait.draw = false
				onlinePlay = false
				menu.draw = true
			end
		end
		if click.inside(closeButton) then
			love.event.quit()
		end
	end
end

function click.inside(button)
	if click.X > button.X 
		and click.X < button.X + button.width
		and click.Y > button.Y
		and click.Y < button.Y + button.height 
		then
			return true
	end
	return false
end