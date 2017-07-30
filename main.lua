local Gamestate = require 'lib.hump.gamestate'
Title = require 'src.title'
LevelSelect = require 'src.level-select'
Play = require 'src.play'
Victory = require 'src.victory-screen'

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
    ASSETS[1] = love.graphics.newImage('assets/1.png')
    ASSETS[2] = love.graphics.newImage('assets/2.png')
    ASSETS[3] = love.graphics.newImage('assets/3.png')
    ASSETS['box'] = love.graphics.newImage('assets/box.png')

    love.graphics.setBackgroundColor(200, 200, 200)

    Gamestate.registerEvents()
    Gamestate.switch(Title)
end

function love.draw()
    love.graphics.scale(SCALE, SCALE)
end

function love.keypressed(key, scancode, isRepeat)
    if key == 'escape' then
        love.event.quit()
    end
end