local sprite3DView = class("sprite3DView", function() return cc.Scene:create() end)

function sprite3DView:create()
	local scene = sprite3DView:new()
	scene:addChild(scene:createLayer())
	return scene
end

function sprite3DView:createLayer()
	local layer = cc.LayerColor:create(cc.c3b(49, 93, 87))
	local closeBtn = ccui.Button:create("close.png")
	local closeSize = closeBtn:getContentSize()
	closeBtn:setPosition(cc.p(display.width - closeSize.width/2, display.height - closeSize.height/2))
	layer:addChild(closeBtn)
	closeBtn:addTouchEventListener(function(sender, event) if event == ccui.TouchEventType.ended then cc.Director:getInstance():popScene() end end)

	local robot = cc.Sprite3D:create("file.obj")
	-- robot:setTexture("file.mtl")
	robot:setPosition(center)
	robot:setCameraMask(cc.CameraFlag.USER1)
	layer:addChild(robot)

	local camera = cc.Camera:createPerspective(60, display.width/display.height, 1, 1000)
	-- local camera = cc.Camera:createOrthographic(60, 60, 1, 1000)
	local po3D = robot:getPosition3D()
	po3D.y = po3D.y + 200
	po3D.z = po3D.z + 600
	camera:setPosition3D(po3D)
	camera:lookAt(po3D)
	camera:setCameraFlag(cc.CameraFlag.USER1)
	layer:addChild(camera)

	return layer
end
return sprite3DView