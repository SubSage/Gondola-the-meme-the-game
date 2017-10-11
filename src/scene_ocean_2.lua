
local scene_ocean_2 = {}

scene_ocean_2.init = function()
  scene_info.name = 'Ocean 2'
  scene_info.bg = love.graphics.newImage('assets/backgrounds/ocean_bottom_1.png')
  scene_info.gondola.x = 30
  scene_info.gondola.y = 900
  scene_info.gondola.speed = 40
  scene_info.gondola.image = love.graphics.newImage('assets/gondola.png')

  scene_info.quad = love.graphics.newQuad(0, 0, 1920, 1080, scene_info.bg:getDimensions())
end

scene_ocean_2.draw = function(canvas)
  canvas:renderTo(function()
    love.graphics.push()
    love.graphics.clear()

    love.graphics.draw(scene_info.bg, scene_info.quad,0,0)
    love.graphics.draw(scene_info.gondola.image, scene_info.gondola.x,scene_info.gondola.y, 0, .55)
    love.graphics.pop()
  end)
end

scene_ocean_2.update=function(dt)

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

  if(scene_info.gondola.y > 900) then
    scene_info.gondola.y = 900
  end
  if(scene_info.gondola.y < 200) then
    scene_info.gondola.y = 200
  end
  if(scene_info.gondola.x < 10) then
    nextscene=scene6
  end
  if(scene_info.gondola.x>800) then
    nextscene=scene8
    scene_info.gondola.x = 780
  end
  scene_info.quad:setViewport(scene_info.gondola.x *10, scene_info.gondola.y, vpw, vph)
end

return scene_ocean_2
