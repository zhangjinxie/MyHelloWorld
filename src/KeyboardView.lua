local KeyboardView = class("KeyboardView", function() return cc.Scene:create() end)

function KeyboardView:create()
	local scene = KeyboardView:new()
	scene:addChild(scene:createLayer())
	return scene
end

function KeyboardView:createLayer()
	local layer = cc.LayerColor:create(cc.c3b(0, 0, 255))
	local closeBtn = ccui.Button:create("assetsRes/res/btn/btn60c.png")
	local size = closeBtn:getContentSize()
	closeBtn:setPosition(cc.p(display.width - size.width/2, display.height - size.height/2))
	layer:addChild(closeBtn)
	closeBtn:addTouchEventListener(function(sender, event) cc.Director:getInstance():popScene() end)

	local label = cc.Label:create()
	label:setString("现在无输入")
	label:setSystemFontSize(30)
	label:setSystemFontName("Arial")
	label:setTextColor(cc.c3b(47, 32, 28))
	label:setPosition(cc.p(display.width/2, display.height/2))
	layer:addChild(label)

	local function pressedHd(keycode, event)
		local buf = string.format("%d按下", keycode)
		local item = event:getCurrentTarget()
		item:setString(buf)
	end

	local function releasedHd(keycode, event)
		local buf = string.format("%d松开", keycode)
		local item = event:getCurrentTarget()
		item:setString(buf)
	end

	local listener = cc.EventListenerKeyboard:create()
	listener:registerScriptHandler(pressedHd, cc.Handler.EVENT_KEYBOARD_PRESSED)
	listener:registerScriptHandler(releasedHd, cc.Handler.EVENT_KEYBOARD_RELEASED)

	local eventDispatcher = self:getEventDispatcher()
	eventDispatcher:addEventListenerWithSceneGraphPriority(listener, label)
	return layer
end
return KeyboardView
