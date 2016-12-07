local cron = require 'lib/cron'

game = {}
game.loaded = false

function game.load()
	print("loaded game")
	game.loaded = true
	game.score = 0
	game.lifes = 3
	game.speed = 2
	game.souzaStep = 1
	game.souzaPos = (GAME_WIDTH/2) - (souza:getWidth()/2)
	game.souzaVel = 0
	game.food = {}
	game.foodAmount = 7
	game.letterCounter = 0
	game.lastFood = ''

	wavetimer = cron.after( 1, game.addFood )
end

function game.update()
	if game.loaded == true then
		-- GAME OVER
		if game.lifes < 1 then
			game.loaded = false
			state = "gameover"
		end

		-- update start timer
		wavetimer:update( _dt )

		-- update souza position
		game.souzaPos = game.souzaPos + game.souzaVel
		if game.souzaPos > GAME_WIDTH then
			game.souzaPos = -38
		end
		if game.souzaPos < -38 then
			game.souzaPos = GAME_WIDTH
		end

		-- Falling food
		local to_remove = {}
		for i=1,#game.food do
			game.food[i][3] = game.food[i][3] + game.speed
			-- Check if souza got it
			if game.food[i][3] > GAME_HEIGHT-souza:getHeight() - 45
				and game.food[i][2] > game.souzaPos - 20
				and game.food[i][2] < game.souzaPos + 20
			then
				table.insert( to_remove, i )
				game.score = game.score + 10;
				game.got_food( game.food[i][1] )
			end
			-- Check if fell on the floor
			if game.food[i][3] > GAME_HEIGHT - 25 then
				table.insert( to_remove, i )
				game.lifes = game.lifes - 1;
				game.got_food( 'FAIL' )
			end
		end

		-- Remove food
		for i=1,#to_remove do
			table.remove( game.food, to_remove[ i ] )
		end

		-- Add more food
		if #game.food == 0 and game.score ~= 0 then
			if game.speed < 6 then
				game.speed = game.speed + 0.25
			end
			game.addFood()
		end

		-- draw everything
		game.draw()
	else
		game.load()
	end
end

function game.draw()
	love.graphics.clear( 29, 140, 5 )

	-- Souza
	if ( game.souzaVel ~= 0 ) then
		game.souzaStep = ( math.floor( love.timer.getTime() * 10 ) % 4 ) + 1
	else
		game.souzaStep = 1
	end
	love.graphics.draw( souzas[game.souzaStep], game.souzaPos, GAME_HEIGHT-souza:getHeight() - 5 );

	-- Falling food
	for i=1,#game.food do
		love.graphics.draw( game.food[i][1], game.food[i][2], game.food[i][3] )
	end

	-- Score
	love.graphics.print( game.score, ( GAME_WIDTH / 12 ), ( GAME_HEIGHT / 24 ) )

	-- lifes
	if game.lifes > 0 then
		love.graphics.draw( burguer, 10 * ( GAME_WIDTH / 12 ), ( GAME_HEIGHT / 24 ) - ( burguer:getHeight()/8 ), 0, 0.6 )
	end
	if game.lifes > 1 then
		love.graphics.draw( burguer, 9  * ( GAME_WIDTH / 12 ), ( GAME_HEIGHT / 24 ) - ( burguer:getHeight()/8 ), 0, 0.6 )
	end
	if game.lifes > 2 then
		love.graphics.draw( burguer, 8  * ( GAME_WIDTH / 12 ), ( GAME_HEIGHT / 24 ) - ( burguer:getHeight()/8 ), 0, 0.6 )
	end

	-- GOT FOOOOOOOOD
	if game.letterCounter > 1 then
		if game.lastFood == 'BACON' then
			love.graphics.draw( heart, (GAME_WIDTH/2)-(heart:getWidth()*1.5), GAME_HEIGHT/3, 0, 3, 3 )
		else
			love.graphics.printf( game.lastFood, 0, GAME_HEIGHT/3, 125, "center", 0, 2, 2 )
		end
		game.letterCounter = game.letterCounter - 1
	end
end

function game.events( axis, value )
	if axis == 1 and value ~= 0 then
		game.souzaVel = value * game.speed;
	end
end

function game.addFood()
	local foods = { burguer, coxinha, bacon2, bacon3 }
	local lastPos = GAME_WIDTH / 2
	local next = 0
	for i=1,game.foodAmount do
		if math.random( 0, 10 ) > 5 then
			next = math.random(3)
		else
			next = -math.random(3)
		end
		table.insert( game.food, {
			foods[ math.floor( math.random( #foods ) ) ],
			( ( GAME_WIDTH / 2 ) + ( next * GAME_WIDTH / 12 ) ) % GAME_WIDTH,
			- ( GAME_HEIGHT / 3 + ( GAME_HEIGHT / game.speed ) ) * i
		})
	end
end

function game.got_food( type )
	game.letterCounter = 50
	if type == burguer then
		game.lastFood = 'NHAMM!!'
	elseif type == coxinha then
		game.lastFood = 'NHAC!!'
	elseif type == bacon1 or type == bacon2 or type == bacon3 then
		game.lastFood = 'BACON'
	elseif type == 'FAIL' then
		game.lastFood = 'UUUH!!'
	end
end
