local Object = require("classic")
local Block = Object:extend()

local window_width, window_height = love.graphics.getDimensions()

function Block:new(x, y, color)
  self.x = x
  self.y = y
  self.width = window_width / 10
  self.height = 20
  self.color = color
end

function Block:draw()
  love.graphics.setColor(self.color[1]/255, self.color[2]/255, self.color[3]/255)
  love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)
end

return Block
