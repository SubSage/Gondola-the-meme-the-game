
local scene_ocean = {
bg = love.graphics.newImage('assets/backgrounds/ocean_bottom_1_1.png'),
speed = 40,
gondola={x=30,y=880, image = love.graphics.newImage('assets/gondola.png')},
camera={x=30,y=850},
status=''
}

scene_ocean.quad = love.graphics.newQuad(0, 0, 1920, 1080, scene_ocean.bg:getDimensions())

scene_ocean.draw = function(canvas)
  canvas:renderTo(function()
    love.graphics.push()
    love.graphics.clear()

    love.graphics.draw(scene_ocean.bg, scene_ocean.quad,0,0)
    love.graphics.draw(scene_ocean.gondola.image, scene_ocean.gondola.x,scene_ocean.gondola.y, 0, .8)
    love.graphics.pop()

    if (infodump) then
      love.graphics.push()
      love.graphics.print('scene_ocean',0,0)
      love.graphics.print('x '..scene_ocean.gondola.x,0,15)
      love.graphics.print('y '..scene_ocean.gondola.y,0,30)
      love.graphics.pop()
    end
  end)
end

scene_ocean.update=function(dt)

  local vpx,vpy,vpw,vph = scene_ocean.quad:getViewport()
  if love.keyboard.isDown('up', 'w') then
    scene_ocean.gondola.y = scene_ocean.gondola.y - scene_ocean.speed * dt
  elseif love.keyboard.isDown('down', 's') then
    scene_ocean.gondola.y = scene_ocean.gondola.y + scene_ocean.speed * dt
  end
  if love.keyboard.isDown('left', 'a') then
    scene_ocean.gondola.x = scene_ocean.gondola.x - scene_ocean.speed * dt
  elseif love.keyboard.isDown('right', 'd') then
    scene_ocean.gondola.x = scene_ocean.gondola.x + scene_ocean.speed * dt
  end

  if(scene_ocean.gondola.y > 880) then
    scene_ocean.gondola.y = 880
  end
  if(scene_ocean.gondola.y < 200) then
    scene_ocean.gondola.y = 200
  end
  if(scene_ocean.gondola.x < 10) then
    nextscene=scene10
  end
  if(scene_ocean.gondola.x>800) then
    nextscene=scene7
    scene_ocean.gondola.x = 780
  end

  if(music[5]:isPlaying())then
    music[5]:pause()
  end
  scene_ocean.quad:setViewport(scene_ocean.gondola.x *10, scene_ocean.gondola.y, vpw, vph)
end

return scene_ocean
