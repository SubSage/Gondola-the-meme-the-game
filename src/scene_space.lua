local scene_space = {
bg = love.graphics.newImage('assets/backgrounds/space.png'),
speed = 10,
gondola={x=30,y=700, image = love.graphics.newImage('assets/gondola.png')},
camera={x=30,y=820},
status=''
}

scene_space.quad = love.graphics.newQuad(0, 0, 1920, 1080, scene_space.bg:getDimensions())

scene_space.draw = function(canvas)
  canvas:renderTo(function()
    love.graphics.push()
    love.graphics.clear()

    love.graphics.draw(scene_space.bg, scene_space.quad,0,0)
    love.graphics.draw(scene_space.gondola.image, scene_space.gondola.x,scene_space.gondola.y, 0, .15)
    love.graphics.pop()

    if (infodump) then
      love.graphics.push()
      love.graphics.print('scene_space',0,0)
      love.graphics.print('x '..scene_space.gondola.x,0,15)
      love.graphics.print('y '..scene_space.gondola.y,0,30)
      love.graphics.pop()
    end
  end)
end

scene_space.update=function(dt)

  local vpx,vpy,vpw,vph = scene_space.quad:getViewport()
  if love.keyboard.isDown('up', 'w') then
    scene_space.gondola.y = scene_space.gondola.y - scene_space.speed * dt
  elseif love.keyboard.isDown('down', 's') then
    scene_space.gondola.y = scene_space.gondola.y + scene_space.speed * dt
  end
  if love.keyboard.isDown('left', 'a') then
    scene_space.gondola.x = scene_space.gondola.x - scene_space.speed * dt
  elseif love.keyboard.isDown('right', 'd') then
    scene_space.gondola.x = scene_space.gondola.x + scene_space.speed * dt
  end

  if(scene_space.gondola.y > 900) then
    scene_space.gondola.y = 900
  end
  if(scene_space.gondola.y < 200) then
    scene_space.gondola.y = 200
  end
  if(scene_space.gondola.x < 10) then
    nextscene=scene10
  end
  if(scene_space.gondola.x>800) then
    nextscene=scene3
    scene_space.gondola.x = 780
  end
  scene_space.quad:setViewport(scene_space.gondola.x *5, scene_space.gondola.y, vpw, vph)
end

return scene_space
