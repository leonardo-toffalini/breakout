local width, height = love.graphics.getDimensions()
local Ball = require("ball")
local Block = require("block")

function love.load()
  local Paddle = require("paddle")
  player = Paddle(width / 2, height - 20, 50, 10, "left", "right")
  ball = Ball()

  blocks = {}
  local block_width = width / 10
  local block_height = 20
  local colors = {{193, 63, 60}, {190, 97, 46}, {173, 111, 44},
                  {152, 153, 36}, {62, 151, 63}, {58, 63, 192}}
  for i = 1, #colors do
    for x = 1, width, block_width do
      table.insert(blocks, Block(x, 40 + i * block_height, colors[i]))
    end
  end
end

function love.update(dt)
  player:update(dt)
  ball:update(dt)
  ball:paddle_hit(player)
  for i, block in ipairs(blocks) do
    if ball:block_hit(block) then
      table.remove(blocks, i)
      break
    end
  end
end

function love.draw()
  player:draw()
  ball:draw()
  for _, block in ipairs(blocks) do
    block:draw()
  end
end
