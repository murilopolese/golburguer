gameover = {}
gameover.loaded = false
gameover.score = 0

function gameover.load()
	if game.score then
		gameover.score = game.score
	end
	gameover.souzaPos = -40
	gameover.souzaStep = 1
	gameover.loaded = true
end

function gameover.update()
	if gameover.loaded == true then
		gameover.souzaPos = gameover.souzaPos + 1
		if gameover.souzaPos > GAME_WIDTH then
			gameover.souzaPos = -40
		end
		gameover.draw()
	else
		gameover.load()
	end
end

function gameover.draw()
	love.graphics.clear( 29, 140, 5 )

	love.graphics.printf(
		"#golburgergame",
		0, 20,
		170, "center", 0, 1.5, 1.5
	)
	love.graphics.printf(
		gameover.score .. " pontos",
		0, 55,
		130, "center", 0, 2, 2
	)

	gameover.souzaStep = ( math.floor( love.timer.getTime() * 8 ) % 4 ) + 1
	love.graphics.draw( souzas[gameover.souzaStep], gameover.souzaPos, 5+(GAME_HEIGHT/2) );
	love.graphics.print( "Aperte Start ", 75, 5 * ( GAME_HEIGHT / 6 ) )
end

function gameover.events( k )
	if k == 10 then
		gameover.loaded = false
		state = 'opening'
	else
		print( 'this is not start' )
	end
end
