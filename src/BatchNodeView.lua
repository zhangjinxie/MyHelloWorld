local BatchNodeView = class("BatchNodeView", function() return cc.Scene:create() end)

function BatchNodeView:create()
	local scene = BatchNodeView:new()
	scene:addChild(scene:createLayer())
	return scene
end

function BatchNodeView:createLayer()
	local layer = cc.LayerColor:create(cc.c3b(1, 33, 66))

	local closeBtn = ccui.Button:create("close.png")
	local size = closeBtn:getContentSize()
	closeBtn:setPressedActionEnabled(true)		--启用按钮缩放特性(但在这里设置为false时还是具备缩放效果)
	closeBtn:setPosition(cc.p(display.width - size.width/2, display.height - size.height/2))
	layer:addChild(closeBtn)
	closeBtn:addTouchEventListener(function(sender, event) 
		if event == ccui.TouchEventType.ended then
			cc.Director:getInstance():popScene() 
		end
	end)

	local frameCache = cc.SpriteFrameCache:getInstance()
	frameCache:addSpriteFrames("attack.plist")
	local batchNode = cc.SpriteBatchNode:create("attack.png")
	layer:addChild(batchNode)
	for i = 1, 1000 do
		local att
		att = cc.Sprite:createWithSpriteFrameName("Attack__00" .. math.random(0, 9) ..".png")
		att:setPosition(cc.p(math.random(1, 960), math.random(1, 640)))
		att:setName("att1")
		batchNode:addChild(att)
	end

	local listener = cc.EventListenerTouchOneByOne:create()

	local function touchBegan(touch, event)
		return true
	end

	local function touchMoved(touch, event)
		local node = event:getCurrentTarget()
		local px, py = node:getPosition()
		node:setPosition(cc.p(px + touch:getDelta().x, py + touch:getDelta().y))
	end

	listener:registerScriptHandler(touchBegan, cc.Handler.EVENT_TOUCH_BEGAN)
	listener:registerScriptHandler(touchMoved, cc.Handler.EVENT_TOUCH_MOVED)
	local dispatcher = cc.Director:getInstance():getEventDispatcher()
	dispatcher:addEventListenerWithSceneGraphPriority(listener, layer)


	return layer
end

return BatchNodeView