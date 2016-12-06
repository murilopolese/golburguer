function love.keypressed( k )
	if k == 'escape' then
		love.event.quit()
	end
end

function love.joystickpressed( joystick, button )
	if state == "menu" then
		menu.events( button )
	elseif state == "game" then
		game.events( joystick, button )
	elseif state == "gameover" then
		gameover.events( joystick, button )
	end
end

function love.joystickaxis( joystick, axis, value )
	if state == "game" then
		game.events( joystick, axis, value )
	end
end
