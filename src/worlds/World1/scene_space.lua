
local scene_space = {}

scene_space.init = function()
  scene_info.name = 'Space'
  scene_info.bg = love.graphics.newImage('assets/backgrounds/space.png')
  scene_info.gondola.x = 30
  scene_info.gondola.y = 700
  scene_info.gondola.speed = 10
  scene_info.gondola.image = love.graphics.newImage('assets/gondola.png')
  scene_info.songplaying = false

  scene_info.quad = love.graphics.newQuad(0, 0, 1920, 1080, scene_info.bg:getDimensions())
end

scene_space.draw = function(canvas)
  canvas:renderTo(function()
    love.graphics.push()
    love.graphics.clear()

    love.graphics.draw(scene_info.bg, scene_info.quad,0,0)
    love.graphics.draw(scene_info.gondola.image, scene_info.gondola.x,scene_info.gondola.y, 0, .15)
    love.graphics.pop()
  end)
end

scene_space.update=function(dt)
  local vpx,vpy,vpw,vph = scene_info.quad:getViewport()

  if scene_info.gondola.y > 900  then
    scene_info.gondola.y = 900
  end

  if scene_info.gondola.y < 200  then
    scene_info.gondola.y = 200
  end

  if scene_info.gondola.x < 10  then
    next_scene = scene10
  end

  if scene_info.gondola.x > 800 then
    next_scene =scene3
    scene_info.gondola.x = 780
  end

  scene_info.quad:setViewport(scene_info.gondola.x * 5, scene_info.gondola.y, vpw, vph)
end

return scene_space