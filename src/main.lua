canvas = love.graphics.newCanvas(1920, 1080)

scene_info = {
  name = '',
  bg = '',
  speed = 200,
  gravity = 200,
  jumping = false,
  gondola = { x = 0, y = 0, image = love.graphics.newImage('assets/animations/basic_idle.png') },
  status = '',
  debug = false
}

anim8 = require 'anim8'
scene2 = require 'scene_ocean'
scene_house = require 'scene_house'
scene_fall = require 'scene_cliff_fall'
scene5 = require 'scene_ocean_fall'
scene6 = require 'scene_ocean'
scene7 = require 'scene_ocean_2'
scene8 = require 'scene_ocean_3'
scene9 = require 'scene_ocean_4'
scene10 = require 'scene_ocean_cave'
scene11 = require 'scene_space'
transition = require 'transition'

music={
  love.audio.newSource('assets/audio/Starting House/housemusicpart1.ogg'),
  love.audio.newSource('assets/audio/Cave Music/cavesong.ogg'),
  love.audio.newSource('assets/audio/Backing Tracks Ocean/oceanbackingguitarloop.ogg'),
  love.audio.newSource('assets/audio/Backing Tracks Ocean/oceancellodroneloop.ogg')
}

music[3]:setLooping(true)
music[4]:setLooping(true)
music[3]:setVolume(.5)
music[4]:setVolume(.5)

scene = scene_house
next_scene = scene_house

love.window.setTitle('Gondolic Sensation ' .. version)
love.filesystem.setIdentity('Gondolic Sensation ' .. version);


function love.load()
  love.window.setMode(1920, 1080, {fullscreen=false, vsync=true})
  love.graphics.setDefaultFilter('nearest', 'nearest')
  music[1]:play()

  --transition.draw(scene, scene2, 'x')
  --collectgarbage('collect')
  scene.init()
end

function love.update(dt)
  --need to check status of scene for transition state
  if next_scene ~= scene then
    transition.draw(next_scene)
    scene = next_scene
  end

  if love.keyboard.isDown('left', 'a') then
    scene_info.gondola.x = scene_info.gondola.x - scene_info.speed * dt/2
  end

  if love.keyboard.isDown('right', 'd') then
    scene_info.gondola.x = scene_info.gondola.x + scene_info.speed * dt/2
  end

  if love.keyboard.isDown('up', 'w') and scene_info.jumping then
    scene_info.gondola.y = scene_info.gondola.y - scene_info.gravity * dt
  end

  if love.keyboard.isDown('down', 's') and scene_info.jumping then
    scene_info.gondola.y = scene_info.gondola.y + scene_info.gravity * dt
  end

  scene.update(dt)
end

function love.draw()
  --clear any color modifcations from previous frame
  love.graphics.setBackgroundColor(0,0,0)
  love.graphics.setColor(255, 255, 255, 255)
  love.graphics.clear()

  scene.draw(canvas)

  --adjust game to fit monitor screen
  local screenwidth, screenheight = love.graphics.getDimensions()
  local sx, sy = screenwidth/1920, screenheight/1080
  love.graphics.scale(sx,sy)

  love.graphics.draw(canvas)
  love.graphics.setShader()

  if scene_info.debug == true then
    drawDebug()
  end
end

function drawDebug()
   love.graphics.push()

      love.graphics.setColor(255, 0, 0)
      love.graphics.print('DEBUG MODE', 5, 5)
      love.graphics.setColor(0, 0, 0)
      love.graphics.print(scene_info.name, 5, 20)
      love.graphics.print('Gond X: ' .. scene_info.gondola.x, 5, 35)
      love.graphics.print('Gond Y: ' .. scene_info.gondola.y, 5, 50)

    love.graphics.pop()
end

--Button presses Button presses, not hold
function love.keypressed(k)

  if k=='escape' then love.event.quit() end

  if k=='f12' then
    local screenshot = love.graphics.newScreenshot();
      screenshot:encode('png', os.time() .. '.png');
  end

  --Debug
  if k == 'q' then
    if scene_info.debug == true then
      scene_info.debug = not scene_info.debug
    else
      scene_info.debug = not scene_info.debug
    end
  end

  if scene_info.debug == true then
    if k == 'f1' then
      next_scene = scene_house
    end
    if k == 'f2' then
      next_scene = scene_fall
    end
    if k == 'f3' then
      next_scene = scene5
    end
    if k == 'f4' then
      next_scene = scene6
    end
    if k == 'f5' then
      next_scene = scene7
    end
    if k == 'f6' then
      next_scene = scene8
    end
    if k == 'f7' then
      next_scene = scene9
    end
    if k == 'f8' then
      next_scene = scene10
    end
    if k == 'f9' then
      next_scene = scene11
    end
  end
end
