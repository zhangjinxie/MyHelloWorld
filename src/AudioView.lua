local AudioView = class("AudioView", function() return cc.Scene:create() end)

local userDefault = cc.UserDefault:getInstance()
MUSIC = "music"
function AudioView:ctor()
	local function nodeEvent(event)
		if event == "enterTransitionFinish" then
			print("============AudioView enterTransitionFinish")
			if userDefault:getBoolForKey(MUSIC) then
				audio.playMusic("sound/bmusic1.mp3", true)
				self.menuTog:setSelectedIndex(0)
			else
				print("===============userDefault stop")
				audio.stopMusic()
				self.menuTog:setSelectedIndex(1)
			end
		elseif event == "cleanup" then
			audio.stopMusic()
		end
	end
	self:registerScriptHandler(nodeEvent)
end

function AudioView:create()
	local scene = AudioView:new()
	scene:addChild(AudioView:createLayer())
	return scene
end

function AudioView:createLayer()
	local layer = cc.LayerColor:create(cc.c3b(2, 5,30))

	local closeBtn = ccui.Button:create("close.png")
	local size = closeBtn:getContentSize()
	closeBtn:setPosition(cc.p(display.width - size.width/2, display.height - size.height/2))
	layer:addChild(closeBtn)
	local function closeHd(sender, event)
		audio.playEffect("sound/click.mp3")
		if event == ccui.TouchEventType.ended then
			cc.Director:getInstance():popScene()
		end
	end
	closeBtn:addTouchEventListener(closeHd)


	local playItem = cc.MenuItemImage:create("select1d.png", "select1d.png")
	local stopItem = cc.MenuItemImage:create("select1c.png", "select1c.png")
	local menuTog = cc.MenuItemToggle:create(playItem, stopItem)
	menuTog:setPosition(cc.p(display.cx, display.cy))
	local menu = cc.Menu:create(menuTog)
	menu:setPosition(cc.p(0, 0))
	layer:addChild(menu)
	local function musicHd(tag, sender)
		print("menuTog:getSelectedIndex()=========", menuTog:getSelectedIndex())
		if menuTog:getSelectedIndex() == 0 then
			audio.playMusic("sound/bmusic1.mp3", true)
			userDefault:setBoolForKey(MUSIC, true)
		else
			audio.stopMusic()
			userDefault:setBoolForKey(MUSIC, false)
		end
	end
	menuTog:registerScriptTapHandler(musicHd)
	self.menuTog = menuTog

	return layer
end


return AudioView