local Object = require("classic")
local Ball = Object:extend()

local window_width, window_height = love.graphics.getDimensions()

function Ball:new()
  self.x = window_width / 2
  self.y = window_height / 2
  self.width = 5
  self.height = 5
  -- 2 * math.random(0, 1) - 1 generates -1 or 1 with 0.5 - 0.5 probability
  self.x_speed = math.random(200, 220) * (2 * math.random(0, 1) - 1)
  self.y_speed = math.random(200, 220)

  self.respawn_counter = 0
end

function Ball:update(dt)
  self.x = self.x + self.x_speed * dt
  self.y = self.y + self.y_speed * dt
  self:check_boundaries()
end

function Ball:paddle_hit(player)
  if self:check_collision(player) then
    self.y_speed = -self.y_speed
  end
end

function Ball:check_boundaries()
  if self.x < 0 then
    self.x_speed = -self.x_speed
    self.x = 0
  end
  if self.x + self.width > love.graphics.getWidth() then
    self.x_speed = -self.x_speed
    self.x = love.graphics.getWidth() - self.width
  end
  if self.y < 0 then
    self.y_speed = -self.y_speed
    self.y = 0
  end
  if self.y + self.height > love.graphics.getHeight() then
    -- ball went out of screen on the bottom
    self.x = window_width / 2
    self.y = window_height / 2
    -- 2 * math.random(0, 1) - 1 generates -1 or 1 with 0.5 - 0.5 probability
    self.x_speed = math.random(100, 250) * (2 * math.random(0, 1) - 1)
    self.y_speed = math.random(100, 250) * (2 * math.random(0, 1) - 1)

    self.respawn_counter = self.respawn_counter + 1
  end
end

function Ball:check_collision(other)
  return self.x + self.width > other.x
    and self.x < other.x + other.width
    and self.y + self.height > other.y
    and self.y < other.y + other.height
end

function Ball:block_hit(block)
  if self:check_collision(block) then
    self.y_speed = -self.y_speed
    return true
  end
  return false
end

function Ball:draw()
  love.graphics.setColor(193/255, 63/255, 60/255)
  love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)
end

return Ball
