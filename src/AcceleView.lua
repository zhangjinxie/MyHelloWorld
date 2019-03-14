local AcceleView = class("AcceleView", function() return cc.Scene:create() end)

SPEED = 9.81
function AcceleView:create()
	local scene = AcceleView:new()
	scene:addChild(scene:createLayer())
	return scene
end

function AcceleView:createLayer()
	local layer = cc.LayerColor:create(cc.c3b(47, 32, 28))
	layer:setAccelerometerEnabled(true)		--启用硬件加速度计

	local bg = cc.Sprite:create("bg1.png", cc.rect(0, 0, display.width, display.height))
	bg:getTexture():setTexParameters(gl.LINEAR, gl.LINEAR, gl.REPEAT, gl.REPEAT)
	bg:setPosition(cc.p(display.cx, display.cy))
	layer:addChild(bg)

	local closeBtn = ccui.Button:create("close.png")
	local size = closeBtn:getContentSize()
	closeBtn:setPressedActionEnabled(true)		--启用按钮缩放特性(但在这里设置为false时还是具备缩放效果)
	closeBtn:setPosition(cc.p(display.width - size.width/2, display.height - size.height/2))
	bg:addChild(closeBtn)
	closeBtn:addTouchEventListener(function(sender, event) 
		if event == ccui.TouchEventType.ended then
			cc.Director:getInstance():popScene() 
		end
	end)

	local ball = cc.Sprite:create("redPoint.png")
	ball:setPosition(cc.p(display.cx, display.cy))
	-- ball:setScale(3)  --这样不会改变size的大小
	ball:setContentSize(cc.size(84, 84))
	layer:addChild(ball)

	local function acceleFunc(event, x, y, z, timestamp)
		local node = event:getCurrentTarget()
		local size = node:getContentSize()
		local px, py = node:getPosition()
		px = px + x * SPEED
		py = py + y * SPEED
		if px > display.width - size.width/2 then
			px = display.width - size.width/2
		elseif px < size.width/2 then
			px = size.width/2
		end

		if py > display.height - size.height/2 then
			py = display.height - size.height/2
		elseif py < size.height/2 then
			py = size.height/2
		end

		node:setPosition(cc.p(px, py))
	end

	local listener = cc.EventListenerAcceleration:create(acceleFunc)
	self:getEventDispatcher():addEventListenerWithSceneGraphPriority(listener, ball)


	return layer
end
return AcceleView