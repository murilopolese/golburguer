require "gfx"

logo = love.graphics.newImage( 'gfx/logo.png' ) -- 200x75
burguer = love.graphics.newImage( 'gfx/burguer.png' ) -- 42x42
bacon1 = love.graphics.newImage( 'gfx/bacon1.png' ) -- 42x42
bacon2 = love.graphics.newImage( 'gfx/bacon2.png' ) -- 42x42
bacon3 = love.graphics.newImage( 'gfx/bacon3.png' ) -- 42x42
coxinha = love.graphics.newImage( 'gfx/coxinha.png' ) -- 42x42
souza = love.graphics.newImage( 'gfx/souza.png' ) -- 42x42

time = 0

function love.load()
	love.window.setFullscreen( true )
	WINDOW_WIDTH = love.graphics.getWidth()
	WINDOW_HEIGHT = love.graphics.getHeight()
	GAME_WIDTH = 256
	GAME_HEIGHT = 244

	canvas = love.graphics.newCanvas( GAME_WIDTH, GAME_HEIGHT )
	canvas:setFilter( "nearest", "nearest" )
end

function love.update( dt )
	time = time + 1
	canvas:renderTo( intro );
end

logo_pos = - logo:getHeight()
souza_intro = { x = -souza:getWidth(), y = 256 - 48 }
food_intro = {
	bacon1 = { x = 20, y = -42 },
	burguer = { x = 80, y = -202 },
	bacon2 = { x = 120, y = -162 },
	coxinha = { x = 160, y = -82 },
	bacon3 = { x = 200, y = -132 }
}

function intro()
	love.graphics.clear( 29, 140, 5 )

	if logo_pos < ( GAME_HEIGHT / 2 ) - ( logo:getHeight() / 2 ) then
		-- Logo slides down
		logo_pos = logo_pos + 1
	else
		-- Souza starts moving
		souza_intro.x = (GAME_WIDTH/2) + math.floor( 100 * math.sin( time / 100 ) )
		-- Shit starts to fall from sky
		food_intro['burguer'].y = food_intro['burguer'].y + 1
		if food_intro['burguer'].y > GAME_HEIGHT then
			food_intro['burguer'].y = -math.random( GAME_HEIGHT )
		end
		food_intro['coxinha'].y = food_intro['coxinha'].y + 1
		if food_intro['coxinha'].y > GAME_HEIGHT then
			food_intro['coxinha'].y = -math.random( GAME_HEIGHT )
		end
		food_intro['bacon1'].y = food_intro['bacon1'].y + 1
		if food_intro['bacon1'].y > GAME_HEIGHT then
			food_intro['bacon1'].y = -math.random( GAME_HEIGHT )
		end
		food_intro['bacon2'].y = food_intro['bacon2'].y + 1
		if food_intro['bacon2'].y > GAME_HEIGHT then
			food_intro['bacon2'].y = -math.random( GAME_HEIGHT )
		end
		food_intro['bacon3'].y = food_intro['bacon3'].y + 1
		if food_intro['bacon3'].y > GAME_HEIGHT then
			food_intro['bacon3'].y = -math.random( GAME_HEIGHT )
		end
	end

	love.graphics.draw(
		logo,
		( GAME_WIDTH / 2 ) - ( logo:getWidth() / 2 ),
		logo_pos
	)

	love.graphics.draw(
		souza, souza_intro.x, GAME_HEIGHT-48
	)

	love.graphics.draw(
		burguer, food_intro['burguer'].x, food_intro['burguer'].y
	)
	love.graphics.draw(
		bacon1, food_intro['bacon1'].x, food_intro['bacon1'].y
	)
	love.graphics.draw(
		bacon2, food_intro['bacon2'].x, food_intro['bacon2'].y
	)
	love.graphics.draw(
		bacon3, food_intro['bacon3'].x, food_intro['bacon3'].y
	)
	love.graphics.draw(
		coxinha, food_intro['coxinha'].x, food_intro['coxinha'].y
	)
end

function love.keypressed( k )
	if k == 'escape' then
		love.event.quit()
	end
end

function love.draw()
	love.graphics.push()
	love.graphics.scale( WINDOW_HEIGHT / GAME_HEIGHT )
	local middle = ( WINDOW_WIDTH / ( WINDOW_HEIGHT / GAME_HEIGHT ) ) / 2
	love.graphics.draw( canvas, middle - ( GAME_WIDTH / 2 ) )
	love.graphics.pop()
end
