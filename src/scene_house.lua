
local scene_house = {
  percentage = 0,
  rate = .248,
}

scene_house.init = function()
  scene_info.name = 'House'
  scene_info.bg = love.graphics.newImage('assets/backgrounds/cliff_house.png')
  scene_info.gondola.x = 687
  scene_info.gondola.y = 750
  scene_info.gondola.image = love.graphics.newImage('assets/animations/basic_idle.png') 

  scene_info.quad = love.graphics.newQuad(0, 0, 1920, 1080, scene_info.bg:getDimensions())
end

scene_info.gondola.g =  anim8.newGrid(78, 220, scene_info.gondola.image:getWidth(), scene_info.gondola.image:getHeight())
scene_info.gondola.animation = anim8.newAnimation(scene_info.gondola.g('1-4',1), 0.25)

scene_house.draw = function(canvas)
  canvas:renderTo(function()
    love.graphics.push()
    love.graphics.clear()

    love.graphics.draw(scene_info.bg, scene_info.quad,0,0)
    --love.graphics.draw(scene_house.gondola.image, scene_house.gondola.x,scene_house.gondola.y)
    scene_info.gondola.animation:draw(scene_info.gondola.image, scene_info.gondola.x, scene_info.gondola.y, 0.0, .5)
    love.graphics.pop()

  end)
end

scene_house.update=function(dt)
  scene_info.gondola.animation:update(dt)
  local vpx,vpy,vpw,vph = scene_info.quad:getViewport()
  --gond falls off cliff at x : 1480
  if love.keyboard.isDown('up', 'w') then
    --scene_house.gondola.y = scene_house.gondola.y - scene_house.speed * dt
  elseif love.keyboard.isDown('down', 's') then
    --scene_house.gondola.y = scene_house.gondola.y + scene_house.speed * dt
  end
  if love.keyboard.isDown('left', 'a') then
    --scene_house.gondola.x = scene_house.gondola.x - scene_house.speed * dt
    scene_house.percentage = scene_house.percentage - (scene_house.rate * dt)
  elseif love.keyboard.isDown('right', 'd') then
    --scene_house.gondola.x = scene_house.gondola.x + scene_house.speed * dt
    scene_house.percentage = scene_house.percentage + (scene_house.rate * dt)
  end
  if(scene_house.percentage <= -.85) then
    scene_house.percentage = -.85
  elseif(scene_house.percentage <= 1) then
    scene_info.gondola.x = 720 + scene_house.percentage*(1483-687)

    scene_info.gondola.y = 745 - scene_house.percentage*(748-630)
  elseif(scene_house.percentage > 1) then
    scene_info.gondola.y = scene_info.gondola.y + dt * scene_info.speed
    if(scene_info.gondola.y > 900) then
      scene_house.percentage = 0
      next_scene = scene4
    end
  end

  scene_info.quad:setViewport(scene_info.gondola.x , scene_info.gondola.y, vpw, vph)
end

return scene_house
