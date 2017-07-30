local Class = require 'lib.hump.class'
local Vector = require 'lib.hump.vector'
local Timer = require 'lib.hump.timer'
local Signal = require 'lib.hump.signal'

local InvoiceDisplay = Class{}

local INVOICE_STRINGS = {
    I = 'Shield',
    J = 'Super Jump',
    L = 'Health Up',
    O = '1-Up',
    S = 'Dual Lasers',
    T = 'Rocket Launcher',
    Z = 'Speed Boost'
}

function InvoiceDisplay:init(invoice, x)
    self.invoice = invoice
    self.position = Vector(-40, 60)
    self.paperPosition = Vector(0, 0)
    self.originalPosition = self.paperPosition:clone()
    self.opened = false
    self.font = ASSETS['font8']
    self.openedPosition = self.paperPosition - Vector(0, 80 + (8 * #self.invoice))

    Signal.register('showInvoice', function ()
        if self.handle then Timer.cancel(self.handle) end
        self.handle = Timer.tween(0.25, self.paperPosition, { y = self.openedPosition.y }, 'linear', function ()
            self.opened = true
        end)
    end)

    Signal.register('hideInvoice', function ()
        Timer.cancel(self.handle)
        self.opened = false
        self.handle = Timer.tween(0.25, self.paperPosition, { y = self.originalPosition.y })
    end)
end

function InvoiceDisplay:invoiceString()
    local s = ''

    for name,n in pairs(self.invoice) do
        s = s..string.format('%s: %d\n', INVOICE_STRINGS[name], n)
    end

    return s
end

function InvoiceDisplay:draw()
    love.graphics.push()
    love.graphics.translate(self.position:unpack())
    love.graphics.setColor(255, 255, 255)
    love.graphics.draw(ASSETS['folder-back'])
    love.graphics.push()
    love.graphics.translate(self.paperPosition:unpack())
    love.graphics.draw(ASSETS['large-invoice'])
    if self.opened then
        love.graphics.push()
        love.graphics.translate(20, 55)
        love.graphics.scale(1 / SCALE, 1 / SCALE)
        love.graphics.setColor(0, 0, 0)
        love.graphics.setFont(self.font)
        love.graphics.print(self:invoiceString())
        love.graphics.pop()
    end
    love.graphics.pop()
    love.graphics.setColor(255, 255, 255)
    love.graphics.draw(ASSETS['folder-front'])
    love.graphics.pop()
end

return InvoiceDisplay