
local scene_house = {}

scene_house.init = function()
  scene_info.name = 'House'
  scene_info.bg = love.graphics.newImage('assets/backgrounds/cliff_house.png')
  scene_info.gondola.x = 687
  scene_info.gondola.y = 750
  scene_info.gondola.speed = 200
  scene_info.gravity = 200
  scene_info.jumping = false
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

  if love.keyboard.isDown('left', 'a') then
    scene_info.gondola.y = scene_info.gondola.y + scene_info.speed * dt/10
  end

  if love.keyboard.isDown('right', 'd') then
    scene_info.gondola.y = scene_info.gondola.y - scene_info.speed * dt/14
  end

  if(scene_info.gondola.x >= 1490) then
    scene_info.gondola.y = scene_info.gondola.y + scene_info.speed * dt *.9
  end

  if(scene_info.gondola.y >= 950)then
    next_scene = scene_fall
  end

  scene_info.quad:setViewport(scene_info.gondola.x , scene_info.gondola.y, vpw, vph)
end

return scene_house
