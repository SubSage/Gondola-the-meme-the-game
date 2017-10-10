
local scene_ocean_3 = {
bg = love.graphics.newImage('assets/backgrounds/ocean_bottom_2.png'),
speed = 40,
gondola={x=30,y=800, image = love.graphics.newImage('assets/gondola.png')},
camera={x=30,y=820},
status=''
}

scene_ocean_3.quad = love.graphics.newQuad(0, 0, 1920, 1080, scene_ocean_3.bg:getDimensions())

scene_ocean_3.draw = function(canvas)
  canvas:renderTo(function()
    love.graphics.push()
    love.graphics.clear()

    love.graphics.draw(scene_ocean_3.bg, scene_ocean_3.quad,0,0)
    love.graphics.draw(scene_ocean_3.gondola.image, scene_ocean_3.gondola.x,scene_ocean_3.gondola.y, 0, .3)
    love.graphics.pop()

    if (infodump) then
      love.graphics.push()
      love.graphics.print('scene_ocean_3',0,0)
      love.graphics.print('x '..scene_ocean_3.gondola.x,0,15)
      love.graphics.print('y '..scene_ocean_3.gondola.y,0,30)
      love.graphics.pop()
    end
  end)
end

scene_ocean_3.update=function(dt)

  local vpx,vpy,vpw,vph = scene_ocean_3.quad:getViewport()
  if love.keyboard.isDown('up', 'w') then
    scene_ocean_3.gondola.y = scene_ocean_3.gondola.y - scene_ocean_3.speed * dt
  elseif love.keyboard.isDown('down', 's') then
    scene_ocean_3.gondola.y = scene_ocean_3.gondola.y + scene_ocean_3.speed * dt
  end
  if love.keyboard.isDown('left', 'a') then
    scene_ocean_3.gondola.x = scene_ocean_3.gondola.x - scene_ocean_3.speed * dt
  elseif love.keyboard.isDown('right', 'd') then
    scene_ocean_3.gondola.x = scene_ocean_3.gondola.x + scene_ocean_3.speed * dt
  end

  if(scene_ocean_3.gondola.y > 900) then
    scene_ocean_3.gondola.y = 900
  end
  if(scene_ocean_3.gondola.y < 200) then
    scene_ocean_3.gondola.y = 200
  end
  if(scene_ocean_3.gondola.x < 10) then
    nextscene=scene7
  end
  if(scene_ocean_3.gondola.x>820) then
    nextscene=scene9
    scene_ocean_3.gondola.x = 780
  end
  scene_ocean_3.quad:setViewport(scene_ocean_3.gondola.x *10, scene_ocean_3.gondola.y, vpw, vph)
end

return scene_ocean_3
