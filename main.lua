local Gamestate = require 'lib.hump.gamestate'
local Title = require 'src.title'
local Play = require 'src.play'
local Package = require 'src.package'
local Vector = require 'lib.hump.vector'

function love.load()
    love.graphics.setDefaultFilter('nearest', 'nearest')

    Gamestate.registerEvents()
    Gamestate.switch(Play, Package({
        { 0, 0, 1, 0 },
        { 1, 1, 1, 1 },
        { 1, 1, 1, 0 }
    }, { T = 1, J = 1, I = 1, L = 1, O = 1, S = 1, Z = 1 }, Vector(48, 48)))
end

function love.draw()
    love.graphics.scale(SCALE, SCALE)
end

function love.keypressed(key, scancode, isRepeat)
    if key == 'escape' then
        love.event.quit()
    end
end