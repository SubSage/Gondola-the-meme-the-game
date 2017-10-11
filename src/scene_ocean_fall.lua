
local scene_ocean_fall = {}

scene_ocean_fall.init = function()
  scene_info.name = 'Ocean Fall'
  scene_info.bg = love.graphics.newImage('assets/backgrounds/ocean_start.png')
  scene_info.gondola.x = 50
  scene_info.gondola.y = 20
  scene_info.gondola.speed = 40
  scene_info.gondola.image = love.graphics.newImage('assets/gondola.png')
  scene_info.songplaying = false

  scene_info.quad = love.graphics.newQuad(0, 0, 1920, 1080, scene_info.bg:getDimensions())
end

scene_ocean_fall.draw = function(canvas)
  canvas:renderTo(function()
    love.graphics.push()
    love.graphics.clear()

    love.graphics.draw(scene_info.bg, scene_info.quad,0,0)
    love.graphics.draw(scene_info.gondola.image, scene_info.gondola.x,scene_info.gondola.y, 0, .25)
    love.graphics.pop()
  end)
end

scene_ocean_fall.update=function(dt)

  local vpx,vpy,vpw,vph = scene_info.quad:getViewport()

  if love.keyboard.isDown('left', 'a') then
    scene_info.gondola.x = scene_info.gondola.x - scene_info.speed * dt
  elseif love.keyboard.isDown('right', 'd') then
    scene_info.gondola.x = scene_info.gondola.x + scene_info.speed * dt
  end

  scene_info.gondola.y = scene_info.gondola.y + scene_info.speed * dt
  if(scene_info.gondola.y >= 1400) then
    nextscene = scene6
  end
  if(scene_info.gondola.x <= 50 ) then
    scene_info.gondola.x = 50
  end
  if(scene_info.songplaying==false and scene_info.gondola.y >80) then
    scene_info.songplaying =true
    if(music[1]:isPlaying())then
      music[1]:pause()
    end
    love.audio.setVolume(1)
    music[2] = love.audio.newSource('assets/audio/Ocean Steel Guitar Parts/oceanenteringwatersteelguitar.ogg')
    music[2]:play()
  end
  if(music[3]:isPlaying() == false) then
    music[3]:play()
    music[4]:play()
  end
  scene_info.quad:setViewport(scene_info.gondola.x , scene_info.gondola.y*4, vpw, vph)
end

return scene_ocean_fall
