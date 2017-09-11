
scene_forest = {}
scene_forest.bg = love.graphics.newImage('assets/cliff_house.png')
scene_forest.update=function()end

scene_forest.draw = function(canvas)
  canvas:renderTo(function()
    love.graphics.draw(scene_forest.bg,0,0)
    love.graphics.print('forest',0,10)
  end)
end

return scene_forest
