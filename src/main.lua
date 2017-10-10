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

music[1] = love.audio.newSource('assets/audio/House Music (Opening)/housemusicpart1.wav')
music[1]:play()
music[5]= love.audio.newSource('assets/audio/Cave Song/cavesong.wav')
music[3]= love.audio.newSource('assets/audio/backingparts/oceanbackingguitarloop.wav')
music[4]= love.audio.newSource('assets/audio/backingparts/oceancellodroneloop.wav')
music[3]:setLooping(true)
music[4]:setLooping(true)
music[3]:setVolume(.5)
music[4]:setVolume(.5)
musicocean={}
musicocean[1]= love.audio.newSource('assets/audio/Ocean cello parts/cello1.wav')
musicocean[2]= love.audio.newSource('assets/audio/Ocean cello parts/cello2.wav')
musicocean[3]= love.audio.newSource('assets/audio/Ocean cello parts/cello3.wav')
musicocean[4]= love.audio.newSource('assets/audio/Ocean cello parts/cello4.wav')
musicocean[5]= love.audio.newSource('assets/audio/Ocean cello parts/cello5.wav')
musicocean[6]= love.audio.newSource('assets/audio/Ocean cello parts/cello6.wav')
musicocean[7]= love.audio.newSource('assets/audio/Ocean cello parts/cello7.wav')
musicocean[8]= love.audio.newSource('assets/audio/Ocean cello parts/cello8.wav')
musicocean[9]= love.audio.newSource('assets/audio/Ocean cello parts/cello9.wav')
musicocean[10]= love.audio.newSource('assets/audio/Ocean cello parts/cello10.wav')
musicocean[11]= love.audio.newSource('assets/audio/Ocean cello parts/cello11.wav')
musicocean[12]= love.audio.newSource('assets/audio/Ocean cello parts/cello12.wav')
musicocean[13]= love.audio.newSource('assets/audio/Ocean cello parts/cello13.wav')
musicocean[14]= love.audio.newSource('assets/audio/Ocean cello parts/cello14.wav')
musicsteel={}
musicsteel[1]= love.audio.newSource('assets/audio/steelguitarparts/steel1.wav')
musicsteel[2]= love.audio.newSource('assets/audio/steelguitarparts/steel2.wav')
musicsteel[3]= love.audio.newSource('assets/audio/steelguitarparts/steel3.wav')
musicsteel[4]= love.audio.newSource('assets/audio/steelguitarparts/steel4.wav')
musicsteel[5]= love.audio.newSource('assets/audio/steelguitarparts/steel5.wav')
musicsteel[6]= love.audio.newSource('assets/audio/steelguitarparts/steel6.wav')
musicsteel[7]= love.audio.newSource('assets/audio/steelguitarparts/steel7.wav')
musicsteel[8]= love.audio.newSource('assets/audio/steelguitarparts/steel8.wav')
musicsteel[9]= love.audio.newSource('assets/audio/steelguitarparts/steel9.wav')
musicsteel[10]= love.audio.newSource('assets/audio/steelguitarparts/steel10.wav')
musicsteel[11]= love.audio.newSource('assets/audio/steelguitarparts/steel11.wav')
musicsteel[12]= love.audio.newSource('assets/audio/steelguitarparts/steel12.wav')
musicsteel[13]= love.audio.newSource('assets/audio/steelguitarparts/steel13.wav')
musicvibe={}
musicvibe[1]= love.audio.newSource('assets/audio/vibraphoneparts/vibes1.wav')
musicvibe[2]= love.audio.newSource('assets/audio/vibraphoneparts/vibes2.wav')
musicvibe[3]= love.audio.newSource('assets/audio/vibraphoneparts/vibes3.wav')
musicvibe[4]= love.audio.newSource('assets/audio/vibraphoneparts/vibes4.wav')
musicvibe[5]= love.audio.newSource('assets/audio/vibraphoneparts/vibes5.wav')
musicvibe[6]= love.audio.newSource('assets/audio/vibraphoneparts/vibes6.wav')
musicvibe[7]= love.audio.newSource('assets/audio/vibraphoneparts/vibes7.wav')
musicvibe[8]= love.audio.newSource('assets/audio/vibraphoneparts/vibes8.wav')
musicvibe[9]= love.audio.newSource('assets/audio/vibraphoneparts/vibes9.wav')
musicvibe[10]= love.audio.newSource('assets/audio/vibraphoneparts/vibes10.wav')
musicvibe[11]= love.audio.newSource('assets/audio/vibraphoneparts/vibes11.wav')
musicvibe[12]= love.audio.newSource('assets/audio/vibraphoneparts/vibes12.wav')
musicvibe[13]= love.audio.newSource('assets/audio/vibraphoneparts/vibes13.wav')
musicvibe[14]= love.audio.newSource('assets/audio/vibraphoneparts/vibes15.wav')


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
