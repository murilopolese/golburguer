local cron = require 'lib/cron'
local blink = nil

menu = {}
menu.loaded = false

function menu.load()
	menu.loaded = true
	menu.souzaStep = 1 -- sprite animation step for souza (max4)
	menu.souzaPos = -40 -- x coordinate of souzaPos
	menu.burguerPos = -40 -- Y coordinate of falling burguer
	menu.coxinhaPos = -120 -- Y coordinate of falling coxinha
	menu.baconPos = -130 -- Y coordinate of falling coxinha
	menu.bacon2Pos = -60 -- Y coordinate of falling coxinha
	menu.isTextVisible = true

	blink = cron.every( 1, menu.toggleText )
end

function menu.update()
	if menu.loaded == true then
		-- blink cron
		blink:update( _dt )

		-- souza position
		menu.souzaPos = menu.souzaPos + .8
		if menu.souzaPos > GAME_WIDTH then
			menu.souzaPos = -40
		end

		-- burguer position
		menu.burguerPos = menu.burguerPos + 1
		if menu.burguerPos > GAME_HEIGHT then
			menu.burguerPos = -40
		end
		if menu.burguerPos + 40 > 7*( GAME_HEIGHT / 12 )
			and menu.burguerPos < 8*( GAME_HEIGHT / 12 )
			and menu.souzaPos > ( GAME_WIDTH / 2 ) - 20
			and menu.souzaPos < ( GAME_WIDTH / 2 ) + 20
		then
			menu.burguerPos = -40
		end
		-- coxinha position
		menu.coxinhaPos = menu.coxinhaPos + 1
		if menu.coxinhaPos > GAME_HEIGHT then
			menu.coxinhaPos = -40
		end
		if menu.coxinhaPos + 30 > 7*( GAME_HEIGHT / 12 )
			and menu.coxinhaPos < 8*( GAME_HEIGHT / 12 )
			and menu.souzaPos > ( GAME_WIDTH / 3 ) - 20
			and menu.souzaPos < ( GAME_WIDTH / 3 ) + 20
		then
			menu.coxinhaPos = -40
		end
		-- bacon position
		menu.baconPos = menu.baconPos + 1
		if menu.baconPos > GAME_HEIGHT then
			menu.baconPos = -40
		end
		if menu.baconPos + 30 > 7*( GAME_HEIGHT / 12 )
			and menu.baconPos < 8*( GAME_HEIGHT / 12 )
			and menu.souzaPos > ( GAME_WIDTH / 6 ) - 20
			and menu.souzaPos < ( GAME_WIDTH / 6 ) + 20
		then
			menu.baconPos = -30
		end
		-- bacon2 position
		menu.bacon2Pos = menu.bacon2Pos + 1
		if menu.bacon2Pos > GAME_HEIGHT then
			menu.bacon2Pos = -40
		end
		if menu.bacon2Pos + 30 > 7*( GAME_HEIGHT / 12 )
			and menu.bacon2Pos < 8*( GAME_HEIGHT / 12 )
			and menu.souzaPos > 3*( GAME_WIDTH / 4 ) - 20
			and menu.souzaPos < 3*( GAME_WIDTH / 4 ) + 20
		then
			menu.bacon2Pos = -30
		end

		-- draw everything
		menu.draw()
	else
		menu.load()
	end
end

function menu.events( k )
	if k == 10 then
		menu.loaded = false
		state = 'game'
	else
		print( 'this is not start' )
	end
end

function menu.draw()
	love.graphics.clear( 29, 140, 5 )

	-- draw logo
	love.graphics.draw(
		logo,
		( GAME_WIDTH / 2 ) - ( logo:getWidth() / 2 ),
		opening.logo_pos
	)
	-- subtitle
	love.graphics.printf( "ABRIU A BOCA E GOL", 0, 10+(GAME_HEIGHT/24), 255, "center" )
	love.graphics.printf( "         '    ", 0, 10+(GAME_HEIGHT/24)-4, 255, "center" )
	
	-- draw souza
	menu.souzaStep = ( math.floor( love.timer.getTime() * 10 ) % 4 ) + 1
	love.graphics.draw( souzas[menu.souzaStep], math.floor(menu.souzaPos), 7 * ( GAME_HEIGHT / 12 ) )
	-- draw burguer
	love.graphics.draw( burguer, GAME_WIDTH/2, menu.burguerPos )
	-- draw coxinha
	love.graphics.draw( coxinha, GAME_WIDTH/3, menu.coxinhaPos )
	-- draw bacon
	love.graphics.draw( bacon3, (GAME_WIDTH/6), menu.baconPos )
	-- draw bacon
	love.graphics.draw( bacon2, 3*( GAME_WIDTH / 4 ), menu.bacon2Pos )

	-- blink text
	if menu.isTextVisible == true then
		love.graphics.printf( "Aperte Start", 0, 5 * ( GAME_HEIGHT / 6 ), 255, "center" )
	end

end

function menu.toggleText()
	if menu.isTextVisible == true then
		menu.isTextVisible = false
	else
		menu.isTextVisible = true
	end
end
