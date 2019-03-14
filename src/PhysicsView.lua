local PhysicsView = class("PhysicsView", function() return cc.Scene:createWithPhysics() end)

function PhysicsView:create()
	local scene = PhysicsView:new()
	scene:getPhysicsWorld():setDebugDrawMask(cc.PhysicsWorld.DEBUGDRAW_ALL)
	scene:addChild(scene:createLayer())
	return scene
end

function PhysicsView:createLayer()
	local layer = cc.LayerColor:create(cc.c3b(19,48,28))

	local closeBtn = ccui.Button:create("close.png")
	local size = closeBtn:getContentSize()
	closeBtn:setPosition(cc.p(display.width - size.width/2, display.height - size.height/2))
	layer:addChild(closeBtn)
	local function closeHd(sender, event)
		if event == ccui.TouchEventType.ended then
			audio.playEffect("sound/click.mp3")
			cc.Director:getInstance():popScene()
		end
	end
	closeBtn:addTouchEventListener(closeHd)

	local size = cc.Director:getInstance():getWinSize()
	local box = cc.PhysicsBody:createEdgeBox(size, cc.PHYSICSBODY_MATERIAL_DEFAULT, 5.0)
	local node = cc.Node:create()
	node:setPosition(cc.p(display.cx, display.cy))
	node:setPhysicsBody(box)
	layer:addChild(node)

	local function onToucheBegan(touch, event)
		local po = touch:getLocation()
		-- self:addNewSpriteAtPosition(po)
		self:addTwoNewSpriteAtPosition(po)
		return false
	end

	local listener = cc.EventListenerTouchOneByOne:create()
	listener:registerScriptHandler(onToucheBegan, cc.Handler.EVENT_TOUCH_BEGAN)
	local dispatcher = cc.Director:getInstance():getEventDispatcher()
	dispatcher:addEventListenerWithSceneGraphPriority(listener, layer)

	local function onContactBegin(contact)
		local spA = contact:getShapeA():getBody():getNode()
		local spB = contact:getShapeB():getBody():getNode()
		if spA and spB then
			spA:setColor(cc.c3b(0,0,0))
			spB:setColor(cc.c3b(0,0,0))
		end
		return true
	end

	local function onContactPresolve(contact)
		print("========onContactPresolve")
		return true
	end

	local function onContactPostsolve(contact)
		print("========onContactPostsolve")
	end

	local function onContactSeparate(contact)
		local spA = contact:getShapeA():getBody():getNode()
		local spB = contact:getShapeB():getBody():getNode()
		if spA and spB then
			spA:setColor(cc.c3b(255,255,255))
			spB:setColor(cc.c3b(255,255,255))
		end
	end

	local contactListener = cc.EventListenerPhysicsContact:create()
	contactListener:registerScriptHandler(onContactBegin, cc.Handler.EVENT_PHYSICS_CONTACT_BEGIN)
	contactListener:registerScriptHandler(onContactPresolve, cc.Handler.EVENT_PHYSICS_CONTACT_PRESOLVE)
	contactListener:registerScriptHandler(onContactPostsolve, cc.Handler.EVENT_PHYSICS_CONTACT_POSTSOLVE)
	contactListener:registerScriptHandler(onContactSeparate, cc.Handler.EVENT_PHYSICS_CONTACT_SEPARATE)
	dispatcher:addEventListenerWithSceneGraphPriority(contactListener, layer)
	return layer
end

function PhysicsView:addNewSpriteAtPosition(po)
	local sprite = cc.Sprite:create("redPoint.png")
	local size = sprite:getContentSize()
	local circle = cc.PhysicsBody:createCircle(size.width/2, cc.PHYSICSBODY_MATERIAL_DEFAULT)
	-- local circle = cc.PhysicsBody:createBox(cc.size(10,10), cc.PHYSICSBODY_MATERIAL_DEFAULT, cc.p(0,0))
	circle:setContactTestBitmask(0x01)	--设置 接触检测掩码,并自动启用接触检测
	-- circle:setCategoryBitmask(0x11)		--设置 类别掩码
	-- circle:setCollisionBitmask(0x11)	--设置 碰撞掩码
	sprite:setPhysicsBody(circle)
	sprite:setPosition(po)
	self:addChild(sprite)
end

function PhysicsView:addTwoNewSpriteAtPosition(po)
	local sp1 = cc.Sprite:create("btn126.png")
	local body1 = cc.PhysicsBody:createBox(sp1:getContentSize())
	sp1:setPhysicsBody(body1)
	sp1:setPosition(po)
	self:addChild(sp1)

	local sp2 = cc.Sprite:create("btn126.png")
	local body2 = cc.PhysicsBody:createBox(sp2:getContentSize())
	sp2:setPhysicsBody(body2)
	sp2:setPosition(cc.p(po.x + 100, po.y + 100))
	self:addChild(sp2)

	local joint = cc.PhysicsJointDistance:construct(body1, body2, cc.p(0,0), cc.p(0,sp2:getContentSize().height/2))
	local world = cc.Director:getInstance():getRunningScene():getPhysicsWorld()
	world:addJoint(joint)
end
return PhysicsView