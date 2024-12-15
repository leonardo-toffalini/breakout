local Object = require("classic")
local Paddle = Object:extend()

local window_width = love.graphics.getWidth()

function Paddle:new(x, y, width, height)
  self.x = x
  self.y = y
  self.width = width
  self.height = height
  self.speed = 240
end

function Paddle:update(dt)
  -- left-right movement
  if love.keyboard.isDown("left") then
    self.x = self.x - self.speed * dt
  elseif love.keyboard.isDown("right") then
    self.x = self.x + self.speed * dt
  end

  self:check_boundaries()
end

function Paddle:check_boundaries()
  if self.x < 0 then
    self.x = 0
  end
  if self.x + self.width > window_width then
    self.x = window_width - self.width
  end
end

function Paddle:draw()
  love.graphics.setColor(192/255, 63/255, 60/255)
  love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)
end

return Paddle
