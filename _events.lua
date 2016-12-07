function love.keypressed( k )
	if k == 'escape' then
		love.event.quit()
	end

	-- Make spacebar to start
	local key = 0
	if k == 'space' then
		key = 10
	end
	-- Make arrows to D-Pad
	local axis = 1
	local value = 0
	if k == 'left' then
		axis = 1
		value = -1
	end
	if k == 'right' then
		axis = 1
		value = 1
	end

	if state == "menu" then
		menu.events( key )
	elseif state == "game" then
		game.events( axis, value )
	elseif state == "gameover" then
		gameover.events( key )
	end

end

function love.joystickpressed( joystick, button )
	if state == "menu" then
		menu.events( button )
	elseif state == "game" then
		game.events( joystick, button )
	elseif state == "gameover" then
		gameover.events( button )
	end
end

function love.joystickaxis( joystick, axis, value )
	if state == "game" then
		game.events( axis, value )
	end
end
