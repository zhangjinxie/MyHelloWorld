local TileView = class("TileView", function() return cc.Scene:create() end)

function TileView:create()
	local scene = TileView:new()
	scene:addChild(scene:createLayer())
	return scene
end

function TileView:createLayer()
	local layer = cc.LayerColor:create(cc.c3b(17,64,73))
	local closeBtn = ccui.Button:create("close.png")
	local size = closeBtn:getContentSize()
	closeBtn:setPosition(cc.p(display.width - size.width/2, display.height - size.height/2))
	closeBtn:addTouchEventListener(function(sender, event) if event == ccui.TouchEventType.ended then cc.Director:getInstance():popScene() end end)
	layer:addChild(closeBtn,10)

	local map = cc.TMXTiledMap:create("map/tileDemo.tmx")
	layer:addChild(map)

	local sprite = cc.Sprite:create("redPoint.png")
	local property = map:getObjectGroup("obj1"):getObject("ninja")
	local po = layer:convertToNodeSpace(cc.p(property.x, property.y))
	sprite:setPosition(po)
	layer:addChild(sprite)

	local function getTileCoordFromPosition(point)
		local tileX = point.x / map:getTileSize().width
		local tileY = (map:getMapSize().height * map:getTileSize().height - point.y) / map:getTileSize().height
		return cc.p(math.floor(tileX), math.floor(tileY))
	end

	local poCenter = cc.p(display.cx, display.cy)
	local function setViewpointCenter(po)
		local x = math.max(po.x, display.cx)
		local y = math.max(po.y, display.cy)
		x = math.min(x, map:getMapSize().width * map:getTileSize().width - display.cx)
		y = math.min(y, map:getMapSize().height * map:getTileSize().height - display.cy)
		local diff = cc.pSub(poCenter, cc.p(x, y))
		layer:setPosition(diff)
		closeBtn:setPosition(cc.p(display.width - size.width/2 - diff.x, display.height - size.height/2 - diff.y))
	end
	
	local function setPlayerPosition(po)
		local tiledPo = getTileCoordFromPosition(po)
		local tileGid = map:getLayer("coLayer"):getTileGIDAt(tiledPo)
		if tileGid > 0 then
			local prop = map:getPropertiesForGID(tileGid)
			if prop.co == "true" then
				audio.playEffect("sound/click.mp3")
				return
			end
		end
		sprite:setPosition(po)
		setViewpointCenter(po)
	end

	local function touchBegan(touch, event)
		return true
	end

	local function touchMoved(touch, event)

	end

	local function touchEnded(touch, event)
		local location = touch:getLocation()
		location = layer:convertToNodeSpace(location)
		local po = cc.p(sprite:getPosition())
		local diff = cc.pSub(location, po)
		local closePo = cc.p(closeBtn:getPosition())
		if math.abs(diff.x) > math.abs(diff.y) then
			if diff.x > 0 then
				po.x = po.x + map:getTileSize().width
			else
				po.x = po.x - map:getTileSize().width
			end
		else
			if diff.y > 0 then
				po.y = po.y + map:getTileSize().height
			else
				po.y = po.y - map:getTileSize().height
			end
		end
		setPlayerPosition(po)
	end

	local listener = cc.EventListenerTouchOneByOne:create()
	listener:setSwallowTouches(true)
	local dispatcher = cc.Director:getInstance():getEventDispatcher()
	listener:registerScriptHandler(touchBegan, cc.Handler.EVENT_TOUCH_BEGAN)
	listener:registerScriptHandler(touchMoved, cc.Handler.EVENT_TOUCH_MOVED)
	listener:registerScriptHandler(touchEnded, cc.Handler.EVENT_TOUCH_ENDED)
	dispatcher:addEventListenerWithSceneGraphPriority(listener, layer)

	
	return layer
end
return TileView
