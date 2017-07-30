local Class = require 'lib.hump.class'
local Vector = require 'lib.hump.vector'
local Signal = require 'lib.hump.signal'

local Button = Class{}

function Button:init(position, image, onClick, onHover, onLeaveHover)
    self.image = image
    self.hoverImage = hoverImage
    self.position = position
    self.originalPosition = position:clone()
    self.onClick = onClick
    self.onHover = onHover
    self.onLeaveHover = onLeaveHover

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
    local x, y = love.mouse.getX() / SCALE, love.mouse.getY() / SCALE
    local b = self:bbox()

    self.hover = b.l <= x and x <= b.r and b.t <= y and y <= b.b

    if self.hover and self.onHover and not self.hoverHandle then
        self:onHover()
    elseif not self.hover and self.onLeaveHover and self.hoverHandle then
        self:onLeaveHover()
    end
end

function Button:draw()
    love.graphics.push('all')
    love.graphics.translate(self.position:unpack())

    if self.hover and self.hoverImage then
        love.graphics.draw(self.hoverImage)
    else
        love.graphics.draw(self.image)
    end

    love.graphics.pop()
end

return Button