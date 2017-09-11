
local scene_cave = {
bg = love.graphics.newImage('assets/backgrounds/cave.png'),
speed = 200,
gondola={x=1500,y=750, image = love.graphics.newImage('assets/gondola.png')},
camera={x=3000,y=820},
status=''
}

scene_cave.quad = love.graphics.newQuad(0, 0, 1920, 1080, scene_cave.bg:getDimensions())

scene_cave.draw = function(canvas)
  canvas:renderTo(function()
    love.graphics.push()
    love.graphics.clear()

    love.graphics.draw(scene_cave.bg, scene_cave.quad,0,0)
    love.graphics.draw(scene_cave.gondola.image, scene_cave.gondola.x,scene_cave.gondola.y, 0, -1,1)
    love.graphics.pop()

    if (infodump) then
      love.graphics.push()
      love.graphics.print('scene_cave',0,0)
      love.graphics.print('x '..scene_cave.gondola.x,0,15)
      love.graphics.print('y '..scene_cave.gondola.y,0,30)
      love.graphics.pop()
    end
  end)
end

scene_cave.update=function(dt)

  local vpx,vpy,vpw,vph = scene_cave.quad:getViewport()

  if love.keyboard.isDown('left', 'a') then
    scene_cave.gondola.x = scene_cave.gondola.x - scene_cave.speed * dt/2
    scene_cave.camera.x = scene_cave.camera.x - scene_cave.speed * dt
  elseif love.keyboard.isDown('right', 'd') then
    scene_cave.gondola.x = scene_cave.gondola.x + scene_cave.speed * dt/2
    scene_cave.camera.x = scene_cave.camera.x + scene_cave.speed * dt
  end
  scene_cave.quad:setViewport(scene_cave.camera.x, scene_cave.camera.y, vpw, vph)

  if(scene_cave.gondola.x <=10) then
    nextscene = scene3
  end
  if(scene_cave.gondola.x >1550) then
    nextscene = scene6
  end

  if(music[5]:isPlaying()==false)then
    music[5]:play()
  end
  if(music[3]:isPlaying()==true)then
    music[3]:pause()
    music[4]:pause()
  end
end

return scene_cave
