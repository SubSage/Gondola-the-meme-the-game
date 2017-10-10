
local scene_ocean_4 = {
bg = love.graphics.newImage('assets/backgrounds/ocean_bottom_2.png'),
speed = 10,
gondola={x=30,y=700, image = love.graphics.newImage('assets/gondola.png')},
camera={x=30,y=820},
status=''
}

scene_ocean_4.quad = love.graphics.newQuad(0, 0, 1920, 1080, scene_ocean_4.bg:getDimensions())

scene_ocean_4.draw = function(canvas)
  canvas:renderTo(function()
    love.graphics.push()
    love.graphics.clear()

    love.graphics.draw(scene_ocean_4.bg, scene_ocean_4.quad,0,0)
    love.graphics.draw(scene_ocean_4.gondola.image, scene_ocean_4.gondola.x,scene_ocean_4.gondola.y, 0, .15)
    love.graphics.pop()

    if (infodump) then
      love.graphics.push()
      love.graphics.print('scene_ocean_4',0,0)
      love.graphics.print('x '..scene_ocean_4.gondola.x,0,15)
      love.graphics.print('y '..scene_ocean_4.gondola.y,0,30)
      love.graphics.pop()
    end
  end)
end

scene_ocean_4.update=function(dt)

  local vpx,vpy,vpw,vph = scene_ocean_4.quad:getViewport()
  if love.keyboard.isDown('up', 'w') then
    scene_ocean_4.gondola.y = scene_ocean_4.gondola.y - scene_ocean_4.speed * dt
  elseif love.keyboard.isDown('down', 's') then
    scene_ocean_4.gondola.y = scene_ocean_4.gondola.y + scene_ocean_4.speed * dt
  end
  if love.keyboard.isDown('left', 'a') then
    scene_ocean_4.gondola.x = scene_ocean_4.gondola.x - scene_ocean_4.speed * dt
  elseif love.keyboard.isDown('right', 'd') then
    scene_ocean_4.gondola.x = scene_ocean_4.gondola.x + scene_ocean_4.speed * dt
  end

  if(scene_ocean_4.gondola.y > 900) then
    scene_ocean_4.gondola.y = 900
  end
  if(scene_ocean_4.gondola.y < 200) then
    scene_ocean_4.gondola.y = 200
  end
  if(scene_ocean_4.gondola.x < 10) then
    nextscene=scene8
  end
  if(scene_ocean_4.gondola.x>800) then
    nextscene=scene11
    scene_ocean_4.gondola.x = 780
  end
  scene_ocean_4.quad:setViewport(scene_ocean_4.gondola.x *5, scene_ocean_4.gondola.y, vpw, vph)
end

return scene_ocean_4
