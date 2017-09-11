
local scene_ocean_2 = {
bg = love.graphics.newImage('assets/backgrounds/ocean_bottom_1_2.png'),
speed = 40,
gondola={x=30,y=900, image = love.graphics.newImage('assets/gondola.png')},
camera={x=30,y=820},
status=''
}

scene_ocean_2.quad = love.graphics.newQuad(0, 0, 1920, 1080, scene_ocean_2.bg:getDimensions())

scene_ocean_2.draw = function(canvas)
  canvas:renderTo(function()
    love.graphics.push()
    love.graphics.clear()

    love.graphics.draw(scene_ocean_2.bg, scene_ocean_2.quad,0,0)
    love.graphics.draw(scene_ocean_2.gondola.image, scene_ocean_2.gondola.x,scene_ocean_2.gondola.y, 0, .55)
    love.graphics.pop()

    if (infodump) then
      love.graphics.push()
      love.graphics.print('scene_ocean_2',0,0)
      love.graphics.print('x '..scene_ocean_2.gondola.x,0,15)
      love.graphics.print('y '..scene_ocean_2.gondola.y,0,30)
      love.graphics.pop()
    end
  end)
end

scene_ocean_2.update=function(dt)

  local vpx,vpy,vpw,vph = scene_ocean_2.quad:getViewport()
  if love.keyboard.isDown('up', 'w') then
    scene_ocean_2.gondola.y = scene_ocean_2.gondola.y - scene_ocean_2.speed * dt
  elseif love.keyboard.isDown('down', 's') then
    scene_ocean_2.gondola.y = scene_ocean_2.gondola.y + scene_ocean_2.speed * dt
  end
  if love.keyboard.isDown('left', 'a') then
    scene_ocean_2.gondola.x = scene_ocean_2.gondola.x - scene_ocean_2.speed * dt
  elseif love.keyboard.isDown('right', 'd') then
    scene_ocean_2.gondola.x = scene_ocean_2.gondola.x + scene_ocean_2.speed * dt
  end

  if(scene_ocean_2.gondola.y > 900) then
    scene_ocean_2.gondola.y = 900
  end
  if(scene_ocean_2.gondola.y < 200) then
    scene_ocean_2.gondola.y = 200
  end
  if(scene_ocean_2.gondola.x < 10) then
    nextscene=scene6
  end
  if(scene_ocean_2.gondola.x>800) then
    nextscene=scene8
    scene_ocean_2.gondola.x = 780
  end
  scene_ocean_2.quad:setViewport(scene_ocean_2.gondola.x *10, scene_ocean_2.gondola.y, vpw, vph)
end

return scene_ocean_2
