local TouchView = class("TouchView", function() return cc.Scene:create() end)

function TouchView:create()
	local scene = TouchView:new()
	scene:addChild(scene:createLayer())
	return scene
end

function TouchView:createLayer()
	local layer = cc.LayerColor:create(cc.c3b(22, 45, 200))

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

	local box1 = cc.Sprite:create("Attack1.png")
	box1:setPosition(cc.p(display.cx, display.cy))
	box1:setContentSize(cc.size(200, 200))
	layer:addChild(box1)

	local function isContains(touches, event)
		local node = event:getCurrentTarget()
		local po = node:convertToNodeSpace(touches[1]:getLocation())
		local size = node:getContentSize()
		local rect = cc.rect(0, 0, size.width, size.height)
		if cc.rectContainsPoint(rect, po) then
			return true
		end
		return false
	end
	local function touchesBegan(touches, event)
		if isContains(touches, event) then
			event:getCurrentTarget():runAction(cc.ScaleBy:create(0.06, 1.5))
			return true
		end
		return false
	end

	local function touchesMoved(touches, event)
		if isContains(touches, event) then
			local node = event:getCurrentTarget()
			local diff = touches[1]:getDelta()
			local curX, curY = node:getPosition()
			node:setPosition(cc.p(curX + diff.x, curY + diff.y))
		end
	end

	local function touchesEnded(touches, event)
		if isContains(touches, event) then
			event:getCurrentTarget():runAction(cc.ScaleTo:create(0.06, 1))
		end
	end

	local eventListener = cc.EventListenerTouchAllAtOnce:create()
	eventListener:registerScriptHandler(touchesBegan, cc.Handler.EVENT_TOUCHES_BEGAN)
	eventListener:registerScriptHandler(touchesMoved, cc.Handler.EVENT_TOUCHES_MOVED)
	eventListener:registerScriptHandler(touchesEnded, cc.Handler.EVENT_TOUCHES_ENDED)

	local eventDispatcher = cc.Director:getInstance():getEventDispatcher()
	eventDispatcher:addEventListenerWithSceneGraphPriority(eventListener, box1)

	local spFramesCache = cc.SpriteFrameCache:getInstance()
	spFramesCache:addSpriteFrames("attack.plist")

	local animation = cc.Animation:create()
	for i = 0, 9 do
		local spFrame = spFramesCache:getSpriteFrameByName(string.format("Attack__00%d.png", i))
		animation:addSpriteFrame(spFrame)
	end
	animation:setDelayPerUnit(0.15)
	animation:setRestoreOriginalFrame(true)
	local animate = cc.Animate:create(animation)
	box1:runAction(cc.RepeatForever:create(animate))

	return layer

end
return TouchView