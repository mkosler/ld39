local Class = require 'lib.hump.class'
local Vector = require 'lib.hump.vector'
local Signal = require 'lib.hump.signal'

local Button = Class{}

function Button:init(position, image, hoverImage, onClick)
    self.image = image
    self.hoverImage = hoverImage
    self.position = position
    self.onClick = onClick

    Signal.register('click', function (x, y, button)
        if button == 1 and self.hover then
            self.onClick()
        end
    end)

    self.z = 0
end

function Button:bbox()
    return {
        l = self.position.x,
        t = self.position.y,
        r = self.position.x + self.image:getWidth(),
        b = self.position.y + self.image:getHeight()
    }
end

function Button:update(dt)
    local x, y = love.mouse.getX(), love.mouse.getY()
    local b = self:bbox()

    self.hover = b.l <= x and x <= b.r and b.t <= y and y <= b.b
end

function Button:draw()
    love.graphics.push('all')
    love.graphics.origin()
    love.graphics.translate(self.position:unpack())

    if self.hover and self.hoverImage then
        love.graphics.draw(self.hoverImage)
    else
        love.graphics.draw(self.image)
    end

    love.graphics.pop()
end

return Button