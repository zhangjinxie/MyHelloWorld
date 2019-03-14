require "cocos/cocosdenshion/AudioEngine.lua"
local GameScene = class("GameScene", function() return cc.Scene:create() end)
PLACE = 101
FLIPX = 102
FLIPY = 103
HIDE = 104
SHOW = 105
TOGGLEVISIBILITY = 106
GOEASEACTIONVIEW = 107
CALLFUNCVIEW = 108
GRIDACTIONVIEW = 109
ANIMATIONVIEW = 110
TOUCHVIEW = 111
TOUCHESVIEW = 112
KEYBOARDVIEW = 113
ACCELEVIEW = 114
BATCHNODEVIEW = 115
AUDIOVIEW = 116
PARTICLEVIEW = 117
MULPARTICLEVIEW = 118
TILEVIEW = 119
PHYSICSVIEW = 120
LISTVIEWTESTVIEW = 121
CCUIVIEW = 122
SPRITE3DVIEW = 123
FILEUTILSVIEW = 124
READXMLVIEW = 125
XMLHTTPREQUESTVIEW = 126
WEBSOCKETVIEW = 127
OPTIMIZESOURCEVIEW = 128
actionTag = -1

-- cc.Director:getInstance():getOpenGLView():setFrameSize(750, 1334)
display= cc.Director:getInstance():getWinSize()
dump(display, "==============dis")
display.cx, display.cy = display.width/2, display.height/2
center = cc.p(display.cx, display.cy)
audio = AudioEngine
function GameScene.create()
	local scene = GameScene.new()
	local layer = scene:createLayer()
	scene:addChild(layer)
	return scene
end
function GameScene:ctor()
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
			print("OnCleanupGameScene")
		end
	end
	self:registerScriptHandler(nodeEvent)
end
function GameScene:createLayer()
	local size = cc.Director:getInstance():getWinSize()
	local layer = cc.LayerColor:create(cc.c3b(100,100,100))
	local sprite = cc.Sprite:create("HelloWorld.png")
	sprite:setPosition(cc.p(size.width/2, size.height/2))
	layer:addChild(sprite)

	local menuItemLabel = cc.MenuItemFont:create("我是大魔王1")
	menuItemLabel:setFontSizeObj(26)
	menuItemLabel:setFontNameObj("Arial")
	menuItemLabel:setPosition(cc.p(size.width/2, size.height/2))
	local menuItemImage = cc.MenuItemImage:create("HelloWorld.png", "HelloWorld1.png")
	menuItemImage:setPosition(cc.p(size.width/2, size.height/2 - 200))

	local function clickEvent(tag, sender)
		print("clickEvent", tag)
		actionTag = sender:getTag()
		local actionView = require("ActionView")
		local actionScene = actionView.create()
		cc.Director:getInstance():pushScene(cc.TransitionFadeTR:create(1, actionScene))
	end

	local itemPlace = cc.MenuItemFont:create("place")
	itemPlace:setTag(PLACE)
	itemPlace:registerScriptTapHandler(clickEvent)

	local itemFlipX = cc.MenuItemFont:create("flipx")
	itemFlipX:setTag(FLIPX)
	itemFlipX:registerScriptTapHandler(clickEvent)

	local itemFlipY = cc.MenuItemFont:create("flipY")
	itemFlipY:setTag(FLIPY)
	itemFlipY:registerScriptTapHandler(clickEvent)

	local itemHide = cc.MenuItemFont:create("hide")
	itemHide:setTag(HIDE)
	itemHide:registerScriptTapHandler(clickEvent)

	local itemShow = cc.MenuItemFont:create("show")
	itemShow:setTag(SHOW)
	itemShow:registerScriptTapHandler(clickEvent)

	local itemToggle = cc.MenuItemFont:create("ToggleVisibility")
	itemToggle:setTag(TOGGLEVISIBILITY)
	itemToggle:registerScriptTapHandler(clickEvent)

	local gotoInterval = cc.MenuItemFont:create("gotoInterval")
	local function goto()
		local sceneOb = require "IntervalAction"
		local scene = sceneOb.create()
		cc.Director:getInstance():pushScene(cc.TransitionFadeTR:create(1, scene))
	end
	gotoInterval:registerScriptTapHandler(goto)

	local goEaseActionView = cc.MenuItemFont:create("goEaseActionView")
	goEaseActionView:setTag(GOEASEACTIONVIEW)
	local function gotoEaseActionView(tag, sender)
		local sceneOb = require("EaseAction")
		local scene = sceneOb.create()
		cc.Director:getInstance():pushScene(cc.TransitionShrinkGrow:create(1, scene))
	end
	goEaseActionView:registerScriptTapHandler(gotoEaseActionView)

	local CallFuncView = cc.MenuItemFont:create("CallFuncView")
	CallFuncView:setTag(CALLFUNCVIEW)
	local function gotoCallFuncView(tag, sender)
		local sceneOb = require("CallFuncView")
		local scene = sceneOb.create()
		cc.Director:getInstance():pushScene(cc.TransitionCrossFade:create(1, scene))
	end
	CallFuncView:registerScriptTapHandler(gotoCallFuncView)

	local GridActionView = cc.MenuItemFont:create("GridActionView")
	GridActionView:setTag(GRIDACTIONVIEW)
	local function gotoGridActionView(tag, sender)
		local sceneOb = require("GridActionView")
		local scene = sceneOb.create()
		cc.Director:getInstance():pushScene(cc.TransitionCrossFade:create(1, scene))
	end
	GridActionView:registerScriptTapHandler(gotoGridActionView)

	local AnimationView = cc.MenuItemFont:create("AnimationView")
	AnimationView:setTag(ANIMATIONVIEW)
	local function gotoAnimationView(tag, sender)
		local sceneOb = require("AnimationView")
		local scene = sceneOb.create()
		cc.Director:getInstance():pushScene(cc.TransitionRotoZoom:create(1, scene))
	end
	AnimationView:registerScriptTapHandler(gotoAnimationView)

	local TouchView = cc.MenuItemFont:create("TouchView")
	TouchView:setTag(TOUCHVIEW)
	local function gotoTouchView(tag, sender)
		local sceneOb = require("TouchView")
		local scene = sceneOb.create()
		cc.Director:getInstance():pushScene(cc.TransitionJumpZoom:create(1, scene))
	end
	TouchView:registerScriptTapHandler(gotoTouchView)

	local TouchesView = cc.MenuItemFont:create("TouchesView")
	TouchesView:setTag(TOUCHESVIEW)
	local function gotoTouchesView(tag, sender)
		local sceneOb = require("TouchesView")
		local scene = sceneOb.create()
		cc.Director:getInstance():pushScene(cc.TransitionJumpZoom:create(1, scene))
	end
	TouchesView:registerScriptTapHandler(gotoTouchesView)

	local KeyboardView = cc.MenuItemFont:create("KeyboardView")
	KeyboardView:setTag(KEYBOARDVIEW)
	local function gotoKeyboardView(tag, sender)
		local sceneOb = require("KeyboardView")
		local scene = sceneOb.create()
		cc.Director:getInstance():pushScene(cc.TransitionJumpZoom:create(1, scene))
	end
	KeyboardView:registerScriptTapHandler(gotoKeyboardView)

	local AcceleView = cc.MenuItemFont:create("AcceleView")
	AcceleView:setTag(ACCELEVIEW)
	local function gotoAcceleView(tag, sender)
		local sceneOb = require("AcceleView")
		local scene = sceneOb.create()
		cc.Director:getInstance():pushScene(cc.TransitionJumpZoom:create(1, scene))
	end
	AcceleView:registerScriptTapHandler(gotoAcceleView)

	local BatchNodeView = cc.MenuItemFont:create("BatchNodeView")
	BatchNodeView:setTag(BATCHNODEVIEW)
	local function gotoBatchNodeView(tag, sender)
		local sceneOb = require("BatchNodeView")
		local scene = sceneOb.create()
		cc.Director:getInstance():pushScene(cc.TransitionJumpZoom:create(1, scene))
	end
	BatchNodeView:registerScriptTapHandler(gotoBatchNodeView)

	local AudioView = cc.MenuItemFont:create("AudioView")
	AudioView:setTag(AUDIOVIEW)
	local function gotoAudioView(tag, sender)
		local sceneOb = require("AudioView")
		local scene = sceneOb.create()
		cc.Director:getInstance():pushScene(cc.TransitionJumpZoom:create(1, scene))
	end
	AudioView:registerScriptTapHandler(gotoAudioView)

	local ParticleView = cc.MenuItemFont:create("ParticleView")
	ParticleView:setTag(PARTICLEVIEW)
	local function gotoParticleView(tag, sender)
		local sceneOb = require("ParticleView")()
		layer:addChild(sceneOb)
	end
	ParticleView:registerScriptTapHandler(gotoParticleView)

	local MulParticleView = cc.MenuItemFont:create("MulParticleView")
	MulParticleView:setTag(MULPARTICLEVIEW)
	local function gotoMulParticleView(tag, sender)
		local sceneOb = require("MulParticleView")
		local scene = sceneOb.create()
		cc.Director:getInstance():pushScene(cc.TransitionJumpZoom:create(1, scene))
	end
	MulParticleView:registerScriptTapHandler(gotoMulParticleView)

	local TileView = cc.MenuItemFont:create("TileView")
	TileView:setTag(TILEVIEW)
	local function gotoTileView(tag, sender)
		local sceneOb = require("TileView")
		local scene = sceneOb.create()
		cc.Director:getInstance():pushScene(cc.TransitionJumpZoom:create(1, scene))
	end
	TileView:registerScriptTapHandler(gotoTileView)

	local PhysicsView = cc.MenuItemFont:create("PhysicsView")
	PhysicsView:setTag(PHYSICSVIEW)
	local function gotoPhysicsView(tag, sender)
		local sceneOb = require("PhysicsView")
		local scene = sceneOb.create()
		cc.Director:getInstance():pushScene(cc.TransitionJumpZoom:create(1, scene))
	end
	PhysicsView:registerScriptTapHandler(gotoPhysicsView)

	local listViewTestView = cc.MenuItemFont:create("listViewTestView")
	listViewTestView:setTag(LISTVIEWTESTVIEW)
	local function gotolistViewTestView(tag, sender)
		--实例化
		local listViewTestView = require("listViewTestView"):new():using()
		listViewTestView:setPosition(cc.p(display.cx, display.cy))
		layer:addChild(listViewTestView)
	end
	listViewTestView:registerScriptTapHandler(gotolistViewTestView)

	local CcuiView = cc.MenuItemFont:create("CcuiView")
	CcuiView:setTag(CCUIVIEW)
	local function gotoCcuiView(tag, sender)
		local sceneOb = require("CcuiView")
		local scene = sceneOb.create()
		cc.Director:getInstance():pushScene(cc.TransitionJumpZoom:create(1, scene))
	end
	CcuiView:registerScriptTapHandler(gotoCcuiView)

	local sprite3DView = cc.MenuItemFont:create("sprite3DView")
	sprite3DView:setTag(SPRITE3DVIEW)
	local function gotosprite3DView(tag, sender)
		local sceneOb = require("sprite3DView")
		local scene = sceneOb.create()
		cc.Director:getInstance():pushScene(cc.TransitionJumpZoom:create(1, scene))
	end
	sprite3DView:registerScriptTapHandler(gotosprite3DView)

	local FileUtilsView = cc.MenuItemFont:create("FileUtilsView")
	FileUtilsView:setTag(FILEUTILSVIEW)
	local function gotoFileUtilsView(tag, sender)
		local sceneOb = require("FileUtilsView")
		local scene = sceneOb.create()
		cc.Director:getInstance():pushScene(cc.TransitionJumpZoom:create(1, scene))
	end
	FileUtilsView:registerScriptTapHandler(gotoFileUtilsView)

	local ReadXMLView = cc.MenuItemFont:create("ReadXMLView")
	ReadXMLView:setTag(READXMLVIEW)
	local function gotoReadXMLView(tag, sender)
		local sceneOb = require("ReadXMLView")
		local scene = sceneOb.create()
		cc.Director:getInstance():pushScene(cc.TransitionJumpZoom:create(1, scene))
	end
	ReadXMLView:registerScriptTapHandler(gotoReadXMLView)

	local XmlHttpRequestView = cc.MenuItemFont:create("XmlHttpRequestView")
	XmlHttpRequestView:setTag(XMLHTTPREQUESTVIEW)
	local function gotoXmlHttpRequestView(tag, sender)
		local sceneOb = require("XmlHttpRequestView")
		local scene = sceneOb.create()
		cc.Director:getInstance():pushScene(cc.TransitionJumpZoom:create(1, scene))
	end
	XmlHttpRequestView:registerScriptTapHandler(gotoXmlHttpRequestView)

	local WebSocketView = cc.MenuItemFont:create("WebSocketView")
	WebSocketView:setTag(WEBSOCKETVIEW)
	local function gotoWebSocketView(tag, sender)
		local sceneOb = require("WebSocketView")
		local scene = sceneOb.create()
		cc.Director:getInstance():pushScene(cc.TransitionJumpZoom:create(1, scene))
	end
	WebSocketView:registerScriptTapHandler(gotoWebSocketView)

	local OptimizeSourceView = cc.MenuItemFont:create("OptimizeSourceView")
	OptimizeSourceView:setTag(OPTIMIZESOURCEVIEW)
	local function gotoOptimizeSourceView(tag, sender)
		local sceneOb = require("OptimizeSourceView")
		local scene = sceneOb.create()
		cc.Director:getInstance():pushScene(cc.TransitionJumpZoom:create(0.1, scene))
	end
	OptimizeSourceView:registerScriptTapHandler(gotoOptimizeSourceView)

	local menu = cc.Menu:create(OptimizeSourceView,WebSocketView,XmlHttpRequestView,ReadXMLView,FileUtilsView,sprite3DView,CcuiView,listViewTestView,PhysicsView,TileView,MulParticleView,ParticleView,AudioView,BatchNodeView,AcceleView,KeyboardView,TouchesView,TouchView,AnimationView,GridActionView,CallFuncView,goEaseActionView,gotoInterval, menuItemLabel,itemPlace,itemFlipX,itemFlipY,itemHide,itemShow,itemToggle)
	-- menu:alignItemsVertically() 	--竖直对齐
	menu:alignItemsInRows(10,10,10)
	-- local menuItemToggle = cc.MenuItemToggle:create(menuItemLabel, menuItemImage)
	-- menuItemToggle:setPosition(cc.p(size.width/2, size.height/2 + 100))
	-- local menu = cc.Menu:create(menuItemToggle)
	-- menu:setPosition(cc.p(0, 0))
	layer:addChild(menu)


	local function updateTest(delta)
		sprite:setPositionX(sprite:getPositionX() + 2)
	end

	layer:scheduleUpdateWithPriorityLua(updateTest, 1)

	local function clickImage(sender)
		print("========i love u")
		local settingSceneOb = require("settingScene")
		local settingscene = settingSceneOb.create()
		-- cc.Director:getInstance():pushScene(cc.TransitionFadeTR:create(2, settingscene))	--网格，从左下到右上
		-- cc.Director:getInstance():pushScene(cc.TransitionJumpZoom:create(2, settingscene)) --跳动，先左后右
		-- cc.Director:getInstance():pushScene(cc.TransitionCrossFade:create(2, settingscene))	--交叉渐变
		-- cc.Director:getInstance():pushScene(cc.TransitionMoveInL:create(2, settingscene))	--从左边推入
		-- cc.Director:getInstance():pushScene(cc.TransitionShrinkGrow:create(2, settingscene))	--放缩交替过渡
		-- cc.Director:getInstance():pushScene(cc.TransitionRotoZoom:create(2, settingscene))	--旋转过渡
		-- cc.Director:getInstance():pushScene(cc.TransitionSlideInL:create(2, settingscene))	--从左边推入过渡
		-- cc.Director:getInstance():pushScene(cc.TransitionSplitCols:create(2, settingscene))	--按列分割过渡
		cc.Director:getInstance():pushScene(cc.TransitionTurnOffTiles:create(2, settingscene))	--生成随机瓦片过渡

	end
	menuItemImage:registerScriptTapHandler(clickImage)
	local function stop(sender)
		layer:unscheduleUpdate()
	end

	menuItemLabel:registerScriptTapHandler(stop)






	return layer
end

return GameScene