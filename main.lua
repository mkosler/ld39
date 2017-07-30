local Gamestate = require 'lib.hump.gamestate'
local Timer = require 'lib.hump.timer'
Title = require 'src.title'
LevelSelect = require 'src.level-select'
Play = require 'src.play'
Victory = require 'src.victory-screen'
GameOver = require 'src.game-over'

ASSETS = {}

function love.load()
    love.graphics.setDefaultFilter('nearest', 'nearest')

    ASSETS['I-button'] = love.graphics.newImage('assets/i-button.png')
    ASSETS['J-button'] = love.graphics.newImage('assets/j-button.png')
    ASSETS['L-button'] = love.graphics.newImage('assets/l-button.png')
    ASSETS['O-button'] = love.graphics.newImage('assets/o-button.png')
    ASSETS['S-button'] = love.graphics.newImage('assets/s-button.png')
    ASSETS['T-button'] = love.graphics.newImage('assets/t-button.png')
    ASSETS['Z-button'] = love.graphics.newImage('assets/z-button.png')
    ASSETS['I-button-hover'] = love.graphics.newImage('assets/i-button-hover.png')
    ASSETS['J-button-hover'] = love.graphics.newImage('assets/j-button-hover.png')
    ASSETS['L-button-hover'] = love.graphics.newImage('assets/l-button-hover.png')
    ASSETS['O-button-hover'] = love.graphics.newImage('assets/o-button-hover.png')
    ASSETS['S-button-hover'] = love.graphics.newImage('assets/s-button-hover.png')
    ASSETS['T-button-hover'] = love.graphics.newImage('assets/t-button-hover.png')
    ASSETS['Z-button-hover'] = love.graphics.newImage('assets/z-button-hover.png')
    ASSETS['1'] = love.graphics.newImage('assets/1.png')
    ASSETS['1-hover'] = love.graphics.newImage('assets/1-hover.png')
    ASSETS['2'] = love.graphics.newImage('assets/2.png')
    ASSETS['2-hover'] = love.graphics.newImage('assets/2-hover.png')
    ASSETS['3'] = love.graphics.newImage('assets/3.png')
    ASSETS['3-hover'] = love.graphics.newImage('assets/3-hover.png')
    ASSETS['4'] = love.graphics.newImage('assets/4.png')
    ASSETS['4-hover'] = love.graphics.newImage('assets/4-hover.png')
    ASSETS['box'] = love.graphics.newImage('assets/box.png')
    ASSETS['next'] = love.graphics.newImage('assets/next.png')
    ASSETS['prev'] = love.graphics.newImage('assets/prev.png')
    ASSETS['title'] = love.graphics.newImage('assets/title.png')
    ASSETS['large-invoice'] = love.graphics.newImage('assets/large-invoice.png')
    ASSETS['folder-front'] = love.graphics.newImage('assets/folder-front.png')
    ASSETS['folder-back'] = love.graphics.newImage('assets/folder-back.png')

    ASSETS['font6'] = love.graphics.newFont(6 * SCALE)
    ASSETS['font8'] = love.graphics.newFont(8 * SCALE)
    ASSETS['font12'] = love.graphics.newFont(12 * SCALE)
    ASSETS['font12-bold'] = love.graphics.newFont('assets/Vera-Bold.ttf', 12 * SCALE)
    ASSETS['font14'] = love.graphics.newFont(12 * SCALE)

    ASSETS['open-audio'] = love.audio.newSource('assets/open.wav', 'static')
    ASSETS['reveal-audio'] = love.audio.newSource('assets/reveal.wav', 'static')
    ASSETS['finish-audio'] = love.audio.newSource('assets/finish.wav', 'static')
    ASSETS['game-over-audio'] = love.audio.newSource('assets/gameover.wav', 'static')

    love.graphics.setBackgroundColor(0, 148, 255)

    Gamestate.registerEvents()
    Gamestate.switch(Title)
end

function love.update(dt)
    Timer.update(dt)
end

function love.draw()
    love.graphics.scale(SCALE, SCALE)
end

function love.keypressed(key, scancode, isRepeat)
    if key == 'escape' then
        love.event.quit()
    end
end