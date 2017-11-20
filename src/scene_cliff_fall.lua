
local scene_cliff = {}

scene_cliff.init = function()
  scene_info.name = 'Cliff Fall'
  scene_info.bg = love.graphics.newImage('assets/backgrounds/cliff_fall.png')
  scene_info.gondola.x = 330
  scene_info.gondola.y = 10
  scene_info.speed = 50
  scene_info.gravity = 200
  scene_info.jumping = false
  scene_info.gondola.image = love.graphics.newImage('assets/gondola.png')

  scene_info.quad = love.graphics.newQuad(0, 0, 1920, 1080, scene_info.bg:getDimensions())
end

scene_cliff.draw = function(canvas)
  canvas:renderTo(function()
    love.graphics.push()
    love.graphics.clear()

    love.graphics.draw(scene_info.bg, scene_info.quad,0,0)
    love.graphics.draw(scene_info.gondola.image, scene_info.gondola.x,scene_info.gondola.y)
    love.graphics.pop()
  end)
end

scene_cliff.update=function(dt)

  local vpx,vpy,vpw,vph = scene_info.quad:getViewport()

  scene_info.gondola.y = scene_info.gondola.y + scene_info.gravity * dt *.9

  if scene_info.gondola.y >= 1000 then
    next_scene = scene5
  end

  if music[1]:isPlaying() then
    music[1]:setVolume(music[1]:getVolume()*.99)
  end

  scene_info.quad:setViewport(scene_info.gondola.x , scene_info.gondola.y*4, vpw, vph)
end

return scene_cliff
