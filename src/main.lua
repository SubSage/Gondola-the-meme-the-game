anim8 = require('lib.anim8')
scene_config = require('scene_info')
transition = require('transition')

scene_house = require 'worlds.World1.scene_house'
scene_fall = require 'worlds.World1.scene_cliff_fall'
scene2 = require 'worlds.World1.scene_ocean'
scene5 = require 'worlds.World1.scene_ocean_fall'
scene6 = require 'worlds.World1.scene_ocean'
scene7 = require 'worlds.World1.scene_ocean_2'
scene8 = require 'worlds.World1.scene_ocean_3'
scene9 = require 'worlds.World1.scene_ocean_4'
scene10 = require 'worlds.World1.scene_ocean_cave'
scene11 = require 'worlds.World1.scene_space'

world = {
  scene_house,
  scene_fall,
  scene2,
  scene5,
  scene6,
  scene7,
  scene8,
  scene9,
  scene10,
  scene11
}

music = {
  love.audio.newSource('assets/audio/Starting House/housemusicpart1.ogg'),
  love.audio.newSource('assets/audio/Cave Music/cavesong.ogg'),
  love.audio.newSource('assets/audio/Backing Tracks Ocean/oceanbackingguitarloop.ogg'),
  love.audio.newSource('assets/audio/Backing Tracks Ocean/oceancellodroneloop.ogg')
}

music[3]:setLooping(true)
music[4]:setLooping(true)
music[3]:setVolume(.5)
music[4]:setVolume(.5)

local current_scene = 1
local scene, next_scene = world[current_scene], world[current_scene]

canvas = love.graphics.newCanvas(1920, 1080)

function love.load()
  love.window.setMode(1920, 1080, {fullscreen=false, vsync=true})
  love.graphics.setDefaultFilter('nearest', 'nearest')
  music[1]:play()

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

function love.keypressed(key, scancode, isrepeat)

  if key=='escape' then love.event.quit() end

  if key=='f12' then
    local screenshot = love.graphics.newScreenshot();
      screenshot:encode('png', os.time() .. '.png');
  end

  if key == 'q' then
    scene_info.debug = not scene_info.debug
  end

  if scene_info.debug then
    if key == 'f1' then
      if current_scene > 2 then
        current_scene = current_scene + 1
      end
      next_scene = world[current_scene]
    end
    if key == 'f2' then
      if current_scene < table.maxn(world) then
        current_scene = current_scene + 1
      end
      next_scene = world[current_scene]
    end
  end
end
