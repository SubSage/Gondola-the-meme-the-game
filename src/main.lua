version = 'CLEAN-UP 0.0.1'
debug = false

scene_info = {
  name = '',
  bg = '',
  speed = 200,
  gondola = { x = 0, y = 0, image = love.graphics.newImage('assets/gondola.png') },
  status = ''
}

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

scene = nil
nextscene = nil

anim8 = require 'anim8'
scene2 = require 'scene_ocean'
scene3 = require 'scene_house'
scene4 = require 'scene_cliff_fall'
scene5 = require 'scene_ocean_fall'
scene6 = require 'scene_ocean'
scene7 = require 'scene_ocean_2'
scene8 = require 'scene_ocean_3'
scene9 = require 'scene_ocean_4'
scene10 = require 'scene_ocean_cave'
scene11 = require 'scene_space'
transition = require 'transition'

love.window.setTitle('Gondolic Sensation ' .. version)
love.filesystem.setIdentity('Gondolic Sensation ' .. version);

musicocean={
  love.audio.newSource('assets/audio/Ocean Cello Parts/cello1.ogg'),
  love.audio.newSource('assets/audio/Ocean Cello Parts/cello2.ogg'),
  love.audio.newSource('assets/audio/Ocean Cello Parts/cello3.ogg'),
  love.audio.newSource('assets/audio/Ocean Cello Parts/cello4.ogg'),
  love.audio.newSource('assets/audio/Ocean Cello Parts/cello5.ogg'),
  love.audio.newSource('assets/audio/Ocean Cello Parts/cello6.ogg'),
  love.audio.newSource('assets/audio/Ocean Cello Parts/cello7.ogg'),
  love.audio.newSource('assets/audio/Ocean Cello Parts/cello8.ogg'),
  love.audio.newSource('assets/audio/Ocean Cello Parts/cello9.ogg'),
  love.audio.newSource('assets/audio/Ocean Cello Parts/cello10.ogg'),
  love.audio.newSource('assets/audio/Ocean Cello Parts/cello11.ogg'),
  love.audio.newSource('assets/audio/Ocean Cello Parts/cello12.ogg'),
  love.audio.newSource('assets/audio/Ocean Cello Parts/cello13.ogg'),
  love.audio.newSource('assets/audio/Ocean Cello Parts/cello14.ogg')
}

musicsteel={
  love.audio.newSource('assets/audio/Ocean Steel Guitar Parts/steel1.ogg'),
  love.audio.newSource('assets/audio/Ocean Steel Guitar Parts/steel2.ogg'),
  love.audio.newSource('assets/audio/Ocean Steel Guitar Parts/steel3.ogg'),
  love.audio.newSource('assets/audio/Ocean Steel Guitar Parts/steel4.ogg'),
  love.audio.newSource('assets/audio/Ocean Steel Guitar Parts/steel5.ogg'),
  love.audio.newSource('assets/audio/Ocean Steel Guitar Parts/steel6.ogg'),
  love.audio.newSource('assets/audio/Ocean Steel Guitar Parts/steel7.ogg'),
  love.audio.newSource('assets/audio/Ocean Steel Guitar Parts/steel8.ogg'),
  love.audio.newSource('assets/audio/Ocean Steel Guitar Parts/steel9.ogg'),
  love.audio.newSource('assets/audio/Ocean Steel Guitar Parts/steel10.ogg'),
  love.audio.newSource('assets/audio/Ocean Steel Guitar Parts/steel11.ogg'),
  love.audio.newSource('assets/audio/Ocean Steel Guitar Parts/steel12.ogg'),
  love.audio.newSource('assets/audio/Ocean Steel Guitar Parts/steel13.ogg')
}

musicvibe={
  love.audio.newSource('assets/audio/Ocean Vibraphone/vibes3.ogg'),
  love.audio.newSource('assets/audio/Ocean Vibraphone/vibes4.ogg'),
  love.audio.newSource('assets/audio/Ocean Vibraphone/vibes5.ogg'),
  love.audio.newSource('assets/audio/Ocean Vibraphone/vibes6.ogg'),
  love.audio.newSource('assets/audio/Ocean Vibraphone/vibes7.ogg'),
  love.audio.newSource('assets/audio/Ocean Vibraphone/vibes8.ogg'),
  love.audio.newSource('assets/audio/Ocean Vibraphone/vibes9.ogg'),
  love.audio.newSource('assets/audio/Ocean Vibraphone/vibes10.ogg'),
  love.audio.newSource('assets/audio/Ocean Vibraphone/vibes11.ogg'),
  love.audio.newSource('assets/audio/Ocean Vibraphone/vibes12.ogg'),
  love.audio.newSource('assets/audio/Ocean Vibraphone/vibes13.ogg'),
  love.audio.newSource('assets/audio/Ocean Vibraphone/vibes15.ogg')
}


function love.load()
  canvas = love.graphics.newCanvas(1920, 1080)
  love.window.setMode(1920, 1080, {fullscreen=false, vsync=true})
  love.graphics.setDefaultFilter('nearest', 'nearest')
  music[1]:play()

  --transition.draw(scene, scene2, 'x')
  --collectgarbage('collect')
  scene = scene3
  scene.init()
end

function love.update(dt)
  --need to check status of scene for transition state
  if(nextscene ~= nil) then
    transition.draw(nextscene)
    scene = nextscene
    nextscene = nil
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

  if debug == true then
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
    if debug == true then
      debug = false
    else
      debug = true
    end
  end

  if debug == true then
    if k == 'f1' then
      nextscene = scene3
    end
    if k == 'f2' then
      nextscene = scene4
    end
    if k == 'f3' then
      nextscene = scene5
    end
    if k == 'f4' then
      nextscene = scene6
    end
    if k == 'f5' then
      nextscene = scene7
    end
    if k == 'f6' then
      nextscene = scene8
    end
    if k == 'f7' then
      nextscene = scene9
    end
    if k == 'f8' then
      nextscene = scene10
    end
    if k == 'f9' then
      nextscene = scene11
    end
  end
end
