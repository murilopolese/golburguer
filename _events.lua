function love.keypressed( k )
	if k == 'escape' then
		love.event.quit()
	end

	if state == "opening" then
		opening.events( k )
	elseif state == "menu" then
		menu.events( k )
	end
end
