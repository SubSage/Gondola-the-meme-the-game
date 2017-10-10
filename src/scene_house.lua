
local scene_house = {
bg = love.graphics.newImage('assets/backgrounds/cliff_house.png'),
speed = 200,
gondola={x=687,y=750, image = love.graphics.newImage('assets/animations/basic_idle.png')},
camera={x=687,y=750},
status='',
percentage = 0,
points = {{30,820},{620,820},{950,730},{1467,630},{1493,630}},
rate = .248,
pointsmin=30,
pointsmax=1493
}
scene_house.gondola.g =  anim8.newGrid(78, 220, scene_house.gondola.image:getWidth(), scene_house.gondola.image:getHeight())
scene_house.gondola.animation = anim8.newAnimation(scene_house.gondola.g('1-4',1), 1)

scene_house.quad = love.graphics.newQuad(0, 0, 1920, 1080, scene_house.bg:getDimensions())

scene_house.draw = function(canvas)
  canvas:renderTo(function()
    love.graphics.push()
    love.graphics.clear()

    love.graphics.draw(scene_house.bg, scene_house.quad,0,0)
    --love.graphics.draw(scene_house.gondola.image, scene_house.gondola.x,scene_house.gondola.y)
    scene_house.gondola.animation:draw(scene_house.gondola.image, scene_house.gondola.x,scene_house.gondola.y, 0.0, .5)
    love.graphics.pop()

    if (infodump) then
      love.graphics.push()
      love.graphics.print('scene_house',0,0)
      love.graphics.print('x '..scene_house.gondola.x,0,15)
      love.graphics.print('y '..scene_house.gondola.y,0,30)
      love.graphics.print('% '..scene_house.percentage,0,45)
      love.graphics.pop()
    end
  end)
end

scene_house.update=function(dt)
  scene_house.gondola.animation:update(dt)
  local vpx,vpy,vpw,vph = scene_house.quad:getViewport()
  --gond falls off cliff at x : 1480
  if love.keyboard.isDown('up', 'w') then
    --scene_house.gondola.y = scene_house.gondola.y - scene_house.speed * dt
  elseif love.keyboard.isDown('down', 's') then
    --scene_house.gondola.y = scene_house.gondola.y + scene_house.speed * dt
  end
  if love.keyboard.isDown('left', 'a') then
    --scene_house.gondola.x = scene_house.gondola.x - scene_house.speed * dt
    scene_house.percentage= scene_house.percentage - (scene_house.rate * dt)
  elseif love.keyboard.isDown('right', 'd') then
    --scene_house.gondola.x = scene_house.gondola.x + scene_house.speed * dt
    scene_house.percentage= scene_house.percentage + (scene_house.rate * dt)
  end
  if(scene_house.percentage <= -.85) then
    scene_house.percentage = -.85
  elseif(scene_house.percentage <= 1) then
    scene_house.gondola.x = 720 + scene_house.percentage*(1483-687)
    scene_house.gondola.y = 745 - scene_house.percentage*(748-630)
  elseif(scene_house.percentage > 1) then
    scene_house.gondola.y = scene_house.gondola.y +dt * scene_house.speed
    if(scene_house.gondola.y > 900) then
      scene_house.percentage=0
      nextscene=scene4
    end
  end

  scene_house.quad:setViewport(scene_house.gondola.x , scene_house.gondola.y, vpw, vph)
end

return scene_house
