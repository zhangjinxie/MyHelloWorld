local TouchView = class("TouchView", function() return cc.Scene:create() end)

function TouchView:create()
	local scene = TouchView:new()
	scene:addChild(scene:createLayer())
	return scene
end

function TouchView:createLayer()
	local layer = cc.LayerColor:create(cc.c3b(22, 45, 200))


	local box1 = cc.Sprite:create("Attack1.png")
	local box2 = cc.Sprite:create("boy1.png")
	local box3 = cc.Sprite:create("girl1.png")
	layer:addChild(box1)
	layer:addChild(box2)
	layer:addChild(box3)
	for i, v in ipairs(layer:getChildren()) do
		v:setContentSize(cc.size(100, 100))
		v:setPosition(cc.p(100 + 50 * i, 100 + 50 * i))
	end

	local closeBtn = ccui.Button:create("green.png")
	local size = closeBtn:getContentSize()
	closeBtn:setPosition(cc.p(display.width - size.width / 2, display.height - size.height / 2))
	local function closeHd(sender, eventType)
		if eventType == ccui.TouchEventType.began then
			print("=========closeBtn=======began")
		elseif eventType == ccui.TouchEventType.moved then
			print("=========closeBtn=======moved")
		elseif eventType == ccui.TouchEventType.ended then
			print("=========closeBtn=======ended")
			cc.Director:getInstance():popScene()
		else
			print("=========closeBtn=======cancel")
		end
	end
	closeBtn:addTouchEventListener(closeHd)
	closeBtn:setPressedActionEnabled(true)
	layer:addChild(closeBtn)
	
	local function touchBegan(touch, event)
		print("===============touchBegan")
		local box = event:getCurrentTarget()
		local size = box:getContentSize()
		local rect = cc.rect(0, 0, size.width, size.height)
		local po = box:convertToNodeSpace(touch:getLocation())
		if cc.rectContainsPoint(rect, po) then
			box:runAction(cc.ScaleBy:create(0.06, 1.06))
			return true
		end
		print("================not in box")
		return false
	end
	local function touchMoved(touch, event)
		print("===============touchMoved")
		local box = event:getCurrentTarget()
		box:setPosition(cc.p(box:getPositionX() + touch:getDelta().x, box:getPositionY() + touch:getDelta().y))
	end
	local function touchEnded(touch, event)
		print("===============touchEnded")
		local box = event:getCurrentTarget()
		local po = box:convertToNodeSpace(touch:getLocation())
		local size = box:getContentSize()
		local rect = cc.rect(0, 0, size.width, size.height)
		if cc.rectContainsPoint(rect, po) then
			box:runAction(cc.ScaleTo:create(0.06, 1))
		end
	end
	local eventListener1 = cc.EventListenerTouchOneByOne:create()
	eventListener1:setSwallowTouches(true)
	eventListener1:registerScriptHandler(touchBegan, cc.Handler.EVENT_TOUCH_BEGAN)
	eventListener1:registerScriptHandler(touchMoved, cc.Handler.EVENT_TOUCH_MOVED)
	eventListener1:registerScriptHandler(touchEnded, cc.Handler.EVENT_TOUCH_ENDED)

	local eventDispatcher = cc.Director:getInstance():getEventDispatcher()
	eventDispatcher:addEventListenerWithSceneGraphPriority(eventListener1, box1)
	local eventListener2 = eventListener1:clone()
	eventDispatcher:addEventListenerWithSceneGraphPriority(eventListener2, box2)
	local eventListener3 = eventListener2:clone()
	eventDispatcher:addEventListenerWithSceneGraphPriority(eventListener3, box3)
	return layer

end
return TouchView