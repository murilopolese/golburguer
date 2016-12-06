opening = {}
opening.loaded = false

function opening.load()
	opening.logo_pos = -logo:getHeight()
	opening.loaded = true
end

function opening.update()
	if opening.loaded == true then
		-- Logo slides down
		if opening.logo_pos < ( GAME_HEIGHT / 3 ) - ( logo:getHeight() / 2 ) then
			opening.logo_pos = opening.logo_pos + 1
		else
			state = "menu"
			opening.loaded = false
		end
		opening.draw()
	else
		opening.load()
	end

end

function opening.draw()
	-- Green background
	love.graphics.clear( 29, 140, 5 )

	love.graphics.draw(
		logo,
		( GAME_WIDTH / 2 ) - ( logo:getWidth() / 2 ),
		opening.logo_pos
	)
end
