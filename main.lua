local Gamestate = require 'lib.hump.gamestate'
local Title = require 'src.title'

function love.load()
    Gamestate.registerEvents()
    Gamestate.switch(Title)
end

function love.keypressed(key, scancode, isRepeat)
    if key == 'escape' then
        love.event.quit()
    end
end