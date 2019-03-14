local SettingScene = class("SettingScene", function() return cc.Scene:create() end)

function SettingScene.create()
	local scene = SettingScene.new()
	scene:addChild(scene:createLayer())
	return scene
end	
function SettingScene:ctor()
	local function nodeEvent(eventType)
		if eventType == "enter" then
			print("onEnter")
		elseif eventType == "enterTransitionFinish" then
			print("onEnterTransitionFinish")
		elseif eventType == "exit" then
			print("OnExit")
		elseif eventType == "exitTransitionStart" then
			print("OnExitTransitionStart")
		elseif eventType == "cleanup" then
			print("OnCleanup")
		end
	end
	self:registerScriptHandler(nodeEvent)
end
function SettingScene:createLayer()
	local layer = cc.LayerColor:create(cc.c3b(205,205,205))
	local director = cc.Director:getInstance()
	local texture = director:getTextureCache():addImage("HelloWorld.png")
	-- local imgClose = cc.Sprite:createWithTexture(texture)
	local imgClose = ccui.ImageView:create("HelloWorld.png")
	local size = director:getWinSize()
	local imgCloseSize = imgClose:getContentSize()
	imgClose:setPosition(cc.p(size.width - imgCloseSize.width/2, size.height - imgCloseSize.height/2))
	layer:addChild(imgClose)

	local function closeHd()
		director:popScene()
	end
	imgClose:setTouchEnabled(true)
	imgClose:addTouchEventListener(closeHd)

	return layer
end
return SettingScene