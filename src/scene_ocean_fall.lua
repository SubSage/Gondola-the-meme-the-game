
local scene_ocean_fall = {
bg = love.graphics.newImage('assets/backgrounds/ocean_start.png'),
speed = 40,
gondola={x=50,y=20, image = love.graphics.newImage('assets/gondola.png')},
camera={x=30,y=820},
status='',
songplaying = false
}

scene_ocean_fall.quad = love.graphics.newQuad(0, 0, 1920, 1080, scene_ocean_fall.bg:getDimensions())

scene_ocean_fall.init = function()
  scene_info.name = 'Cave'
  gondola = {x=50,y=20}
end

scene_ocean_fall.draw = function(canvas)
  canvas:renderTo(function()
    love.graphics.push()
    love.graphics.clear()

    love.graphics.draw(scene_ocean_fall.bg, scene_ocean_fall.quad,0,0)
    love.graphics.draw(scene_ocean_fall.gondola.image, scene_ocean_fall.gondola.x,scene_ocean_fall.gondola.y, 0, .25)
    love.graphics.pop()
  end)
end

scene_ocean_fall.update=function(dt)

  local vpx,vpy,vpw,vph = scene_ocean_fall.quad:getViewport()

  if love.keyboard.isDown('left', 'a') then
    scene_ocean_fall.gondola.x = scene_ocean_fall.gondola.x - scene_ocean_fall.speed * dt
  elseif love.keyboard.isDown('right', 'd') then
    scene_ocean_fall.gondola.x = scene_ocean_fall.gondola.x + scene_ocean_fall.speed * dt
  end

  scene_ocean_fall.gondola.y = scene_ocean_fall.gondola.y + scene_ocean_fall.speed * dt
  if(scene_ocean_fall.gondola.y >= 1400) then
    nextscene = scene6
  end
  if(scene_ocean_fall.gondola.x <= 50 ) then
    scene_ocean_fall.gondola.x = 50
  end
  if(scene_ocean_fall.songplaying==false and scene_ocean_fall.gondola.y >80) then
    scene_ocean_fall.songplaying =true
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
  scene_ocean_fall.quad:setViewport(scene_ocean_fall.gondola.x , scene_ocean_fall.gondola.y*4, vpw, vph)
end

return scene_ocean_fall
