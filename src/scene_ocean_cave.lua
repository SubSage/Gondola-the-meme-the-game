
local scene_cave = {}

scene_cave.init = function()
  scene_info.name = 'Ocean 3'
  scene_info.bg = love.graphics.newImage('assets/backgrounds/cave.png')
  scene_info.camera = {x=3000, y=820}
  scene_info.gondola.x = 1500
  scene_info.gondola.y = 750
  scene_info.gondola.speed = 200
  scene_info.gondola.image = love.graphics.newImage('assets/gondola.png')

  scene_info.quad = love.graphics.newQuad(0, 0, 1920, 1080, scene_info.bg:getDimensions())
end

scene_cave.draw = function(canvas)
  canvas:renderTo(function()
    love.graphics.push()
    love.graphics.clear()

    love.graphics.draw(scene_info.bg, scene_info.quad,0,0)
    love.graphics.draw(scene_info.gondola.image, scene_info.gondola.x,scene_info.gondola.y, 0, -1,1)
    love.graphics.pop()
  end)
end

scene_cave.update=function(dt)

  local vpx,vpy,vpw,vph = scene_info.quad:getViewport()

  if love.keyboard.isDown('left', 'a') then
    scene_info.gondola.x = scene_info.gondola.x - scene_info.speed * dt/2
    scene_info.camera.x = scene_info.camera.x - scene_info.speed * dt
  elseif love.keyboard.isDown('right', 'd') then
    scene_info.gondola.x = scene_info.gondola.x + scene_info.speed * dt/2
    scene_info.camera.x = scene_info.camera.x + scene_info.speed * dt
  end
  scene_info.quad:setViewport(scene_info.camera.x, scene_info.camera.y, vpw, vph)

  if(scene_info.gondola.x <=10) then
    nextscene = scene3
  end
  if(scene_info.gondola.x >1550) then
    nextscene = scene6
  end

  if(music[2]:isPlaying()==false)then
    music[2]:play()
  end
  if(music[3]:isPlaying()==true)then
    music[3]:pause()
    music[4]:pause()
  end
end

return scene_cave
