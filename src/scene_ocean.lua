
local scene_ocean = {}

scene_ocean.init = function()
  scene_info.name = 'Ocean 1'
  scene_info.bg = love.graphics.newImage('assets/backgrounds/ocean_bottom_1.png')
  scene_info.gondola.x = 30
  scene_info.gondola.y = 880
  scene_info.gondola.speed = 40
  scene_info.gondola.image = love.graphics.newImage('assets/gondola.png')

  scene_info.quad = love.graphics.newQuad(0, 0, 1920, 1080, scene_info.bg:getDimensions())
end

scene_ocean.draw = function(canvas)
  canvas:renderTo(function()
    love.graphics.push()
    love.graphics.clear()

    love.graphics.draw(scene_info.bg, scene_info.quad,0,0)
    love.graphics.draw(scene_info.gondola.image, scene_info.gondola.x,scene_info.gondola.y, 0, .8)
    love.graphics.pop()
  end)
end

scene_ocean.update=function(dt)

  local vpx,vpy,vpw,vph = scene_info.quad:getViewport()
  if love.keyboard.isDown('up', 'w') then
    scene_info.gondola.y = scene_info.gondola.y - scene_info.speed * dt
  elseif love.keyboard.isDown('down', 's') then
    scene_info.gondola.y = scene_info.gondola.y + scene_info.speed * dt
  end
  if love.keyboard.isDown('left', 'a') then
    scene_info.gondola.x = scene_info.gondola.x - scene_info.speed * dt
  elseif love.keyboard.isDown('right', 'd') then
    scene_info.gondola.x = scene_info.gondola.x + scene_info.speed * dt
  end

  if(scene_info.gondola.y > 880) then
    scene_info.gondola.y = 880
  end
  if(scene_info.gondola.y < 200) then
    scene_info.gondola.y = 200
  end
  if(scene_info.gondola.x < 10) then
    next_scene=scene10
  end
  if(scene_info.gondola.x>800) then
    next_scene=scene7
    scene_info.gondola.x = 780
  end
  if(music[2]:isPlaying()) then
    music[2]:pause()
  end
  scene_info.quad:setViewport(scene_info.gondola.x *10, scene_info.gondola.y, vpw, vph)
end

return scene_ocean
