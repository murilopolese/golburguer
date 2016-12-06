WINDOW_WIDTH = 0
WINDOW_HEIGHT = 0
GAME_WIDTH  = 0
GAME_HEIGHT = 0
canvas = null
_dt = 0;
crons = {}

math.randomseed(love.timer.getTime())
require '_gfx'
require '_events'

state = "opening"
require 'game_states/opening'
require 'game_states/menu'
require 'game_states/game'
require 'game_states/gameover'

function love.load()
	love.window.setFullscreen( true )
	WINDOW_WIDTH = love.graphics.getWidth()
	WINDOW_HEIGHT = love.graphics.getHeight()
	GAME_WIDTH = 256
	GAME_HEIGHT = 244

	souza:setFilter( 'nearest', 'nearest' )
	burguer:setFilter( 'nearest', 'nearest' )
	font:setFilter( 'nearest', 'nearest' )
	love.graphics.setFont(font)
	canvas = love.graphics.newCanvas( GAME_WIDTH, GAME_HEIGHT )
	canvas:setFilter( 'nearest', 'nearest' )
end

function love.update( dt )
	_dt = dt
	if state == 'opening' then
		canvas:renderTo( opening.update )
	elseif state == 'menu' then
		canvas:renderTo( menu.update )
	elseif state == 'game' then
		canvas:renderTo( game.update )
	elseif state == 'gameover' then
		canvas:renderTo( gameover.update )
	end
end

function love.draw()
	love.graphics.push()
	love.graphics.setColor(255, 255, 255);
	love.graphics.scale( WINDOW_HEIGHT / GAME_HEIGHT )
	local middle = ( WINDOW_WIDTH / ( WINDOW_HEIGHT / GAME_HEIGHT ) ) / 2
	love.graphics.draw( canvas, middle - ( GAME_WIDTH / 2 ) )
	love.graphics.pop()
end
