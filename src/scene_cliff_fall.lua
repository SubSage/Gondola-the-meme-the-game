
local scene_cliff = {
bg = love.graphics.newImage('assets/backgrounds/cliff_fall.png'),
speed = 200,
gondola={x=330,y=10, image = love.graphics.newImage('assets/gondola.png')},
status=''
}

scene_cliff.quad = love.graphics.newQuad(0, 0, 1920, 1080, scene_cliff.bg:getDimensions())

scene_cliff.draw = function(canvas)
  canvas:renderTo(function()
    love.graphics.push()
    love.graphics.clear()

    love.graphics.draw(scene_cliff.bg, scene_cliff.quad,0,0)
    love.graphics.draw(scene_cliff.gondola.image, scene_cliff.gondola.x,scene_cliff.gondola.y)
    love.graphics.pop()

    if (infodump) then
      love.graphics.push()
      love.graphics.print('scene_cliff_fall',0,0)
      love.graphics.print('x '..scene_cliff.gondola.x,0,15)
      love.graphics.print('y '..scene_cliff.gondola.y,0,30)
      love.graphics.pop()
    end
  end)
end

scene_cliff.update=function(dt)

  local vpx,vpy,vpw,vph = scene_cliff.quad:getViewport()

  if love.keyboard.isDown('left', 'a') then
    scene_cliff.gondola.x = scene_cliff.gondola.x - scene_cliff.speed * dt/10
  elseif love.keyboard.isDown('right', 'd') then
    scene_cliff.gondola.x = scene_cliff.gondola.x + scene_cliff.speed * dt/10
  end

  scene_cliff.gondola.y = scene_cliff.gondola.y + scene_cliff.speed * dt *.9
  if(scene_cliff.gondola.y >= 1400) then
    nextscene = scene5
    scene_cliff.gondola.y=10
  end
  if (music[1]:isPlaying())then
    music[1]:setVolume(music[1]:getVolume()*.99)
  end
  scene_cliff.quad:setViewport(scene_cliff.gondola.x , scene_cliff.gondola.y*4, vpw, vph)
end

return scene_cliff
