opening = {}
opening.logo_pos = -logo:getHeight()
opening.logo_final_pos = ( GAME_HEIGHT / 2 ) - ( logo:getHeight() / 2 )

function opening.events( k )

end

function opening.update()
	-- print("opening")
	-- Logo slides down
	if opening.logo_pos < ( GAME_HEIGHT / 3 ) - ( logo:getHeight() / 2 ) then
		opening.logo_pos = opening.logo_pos + 1
	else
		state = "menu"
	end

	opening.draw()
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
