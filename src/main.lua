music={}
anim8 = require 'anim8'
scene = nil
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


love.window.setTitle('Gondolic Sensation Jam-build 1')
love.filesystem.setIdentity('Gondolic Sensation Jam-build 1');

music[1] = love.audio.newSource('assets/audio/Starting House/housemusicpart1.ogg')
music[1]:play()
music[5]= love.audio.newSource('assets/audio/Cave Music/cavesong.ogg')
music[3]= love.audio.newSource('assets/audio/Backing Tracks Ocean/oceanbackingguitarloop.ogg')
music[4]= love.audio.newSource('assets/audio/Backing Tracks Ocean/oceancellodroneloop.ogg')
music[3]:setLooping(true)
music[4]:setLooping(true)
music[3]:setVolume(.5)
music[4]:setVolume(.5)
musicocean={}
musicocean[1]= love.audio.newSource('assets/audio/Ocean Cello Parts/cello1.ogg')
musicocean[2]= love.audio.newSource('assets/audio/Ocean Cello Parts/cello2.ogg')
musicocean[3]= love.audio.newSource('assets/audio/Ocean Cello Parts/cello3.ogg')
musicocean[4]= love.audio.newSource('assets/audio/Ocean Cello Parts/cello4.ogg')
musicocean[5]= love.audio.newSource('assets/audio/Ocean Cello Parts/cello5.ogg')
musicocean[6]= love.audio.newSource('assets/audio/Ocean Cello Parts/cello6.ogg')
musicocean[7]= love.audio.newSource('assets/audio/Ocean Cello Parts/cello7.ogg')
musicocean[8]= love.audio.newSource('assets/audio/Ocean Cello Parts/cello8.ogg')
musicocean[9]= love.audio.newSource('assets/audio/Ocean Cello Parts/cello9.ogg')
musicocean[10]= love.audio.newSource('assets/audio/Ocean Cello Parts/cello10.ogg')
musicocean[11]= love.audio.newSource('assets/audio/Ocean Cello Parts/cello11.ogg')
musicocean[12]= love.audio.newSource('assets/audio/Ocean Cello Parts/cello12.ogg')
musicocean[13]= love.audio.newSource('assets/audio/Ocean Cello Parts/cello13.ogg')
musicocean[14]= love.audio.newSource('assets/audio/Ocean Cello Parts/cello14.ogg')
musicsteel={}
musicsteel[1]= love.audio.newSource('assets/audio/Ocean Steel Guitar Parts/steel1.ogg')
musicsteel[2]= love.audio.newSource('assets/audio/Ocean Steel Guitar Parts/steel2.ogg')
musicsteel[3]= love.audio.newSource('assets/audio/Ocean Steel Guitar Parts/steel3.ogg')
musicsteel[4]= love.audio.newSource('assets/audio/Ocean Steel Guitar Parts/steel4.ogg')
musicsteel[5]= love.audio.newSource('assets/audio/Ocean Steel Guitar Parts/steel5.ogg')
musicsteel[6]= love.audio.newSource('assets/audio/Ocean Steel Guitar Parts/steel6.ogg')
musicsteel[7]= love.audio.newSource('assets/audio/Ocean Steel Guitar Parts/steel7.ogg')
musicsteel[8]= love.audio.newSource('assets/audio/Ocean Steel Guitar Parts/steel8.ogg')
musicsteel[9]= love.audio.newSource('assets/audio/Ocean Steel Guitar Parts/steel9.ogg')
musicsteel[10]= love.audio.newSource('assets/audio/Ocean Steel Guitar Parts/steel10.ogg')
musicsteel[11]= love.audio.newSource('assets/audio/Ocean Steel Guitar Parts/steel11.ogg')
musicsteel[12]= love.audio.newSource('assets/audio/Ocean Steel Guitar Parts/steel12.ogg')
musicsteel[13]= love.audio.newSource('assets/audio/Ocean Steel Guitar Parts/steel13.ogg')
musicvibe={}
musicvibe[3]= love.audio.newSource('assets/audio/Ocean Vibraphone/vibes3.ogg')
musicvibe[4]= love.audio.newSource('assets/audio/Ocean Vibraphone/vibes4.ogg')
musicvibe[5]= love.audio.newSource('assets/audio/Ocean Vibraphone/vibes5.ogg')
musicvibe[6]= love.audio.newSource('assets/audio/Ocean Vibraphone/vibes6.ogg')
musicvibe[7]= love.audio.newSource('assets/audio/Ocean Vibraphone/vibes7.ogg')
musicvibe[8]= love.audio.newSource('assets/audio/Ocean Vibraphone/vibes8.ogg')
musicvibe[9]= love.audio.newSource('assets/audio/Ocean Vibraphone/vibes9.ogg')
musicvibe[10]= love.audio.newSource('assets/audio/Ocean Vibraphone/vibes10.ogg')
musicvibe[11]= love.audio.newSource('assets/audio/Ocean Vibraphone/vibes11.ogg')
musicvibe[12]= love.audio.newSource('assets/audio/Ocean Vibraphone/vibes12.ogg')
musicvibe[13]= love.audio.newSource('assets/audio/Ocean Vibraphone/vibes13.ogg')
musicvibe[14]= love.audio.newSource('assets/audio/Ocean Vibraphone/vibes15.ogg')


nextscene = nil

function love.load()
  canvas = love.graphics.newCanvas(1920,1080)
  love.window.setMode(1920, 1080, {fullscreen=true, vsync=true})
  love.graphics.setDefaultFilter( 'nearest', 'nearest' )

  infodump=false

  --transition.draw(scene, scene2, 'x')
  --collectgarbage('collect')
  scene=scene3
end

function love.update(dt)
  --need to check status of scene for transition state
  if(nextscene ~= nil) then
    scene = nextscene
    nextscene = nil
  end
  scene.update(dt, nextscene)
end

function love.draw()
  --clear any color modifcations from previous frame
  love.graphics.setBackgroundColor(0,0,0)
  love.graphics.clear()

  scene.draw(canvas)

  --adjust game to fit monitor screen
  local screenwidth, screenheight = love.graphics.getDimensions()
  local sx, sy = screenwidth/1920, screenheight/1080
  love.graphics.scale(sx,sy)

  love.graphics.draw(canvas)
  love.graphics.setShader()

end

----- Button presses, not hold
function love.keypressed(k)
  if k=='escape' then love.event.quit() end
  if k=='f12' then
    local screenshot = love.graphics.newScreenshot();
      screenshot:encode('png', os.time() .. '.png');
  end
  if k=='f1' then
    nextscene = scene3
  end
  if k=='f3' then
    infodump = not infodump
  end
  if k=='f4' then
    nextscene = scene4
  end
  if k=='f5' then
    nextscene = scene5
  end
  if k=='f6' then
    nextscene = scene6
  end
  if k=='f7' then
    nextscene = scene7
  end
  if k=='f8' then
    nextscene = scene8
  end
  if k=='f9' then
    nextscene = scene9
  end
  if k=='f10' then
    nextscene = scene10
  end
  if k=='f11' then
    nextscene = scene11
  end
end
