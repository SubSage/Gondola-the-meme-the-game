
local transition = {}

transition.draw = function(next_scene)
	next_scene.init()
end

return transition
