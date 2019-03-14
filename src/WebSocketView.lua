local WebSocketView = class("WebSocketView", function() return cc.Scene:create() end)

function WebSocketView:create()
	local scene = WebSocketView:new()
	scene:addChild(scene:createLayer())
	return scene
end

function WebSocketView:createLayer()
	local layer = cc.LayerColor:create(cc.BLUE)

	local closeBtn = ccui.Button:create("close.png")
	local closeSize = closeBtn:getContentSize()
	closeBtn:setPosition(display.width - closeSize.width/2, display.height - closeSize.height/2)
	layer:addChild(closeBtn)
	local function closeHd(touch, eventType)
		if eventType == ccui.TouchEventType.ended then
			cc.Director:getInstance():popScene()
		end
	end
	closeBtn:addTouchEventListener(closeHd)

	local ws = cc.WebSocket:create("ws://127.0.0.1:3001")

	local function onWSOpen()
		print("----------open")
	end

	local function onMessage(data)
		print("----------receive message from server:", data)
	end

	local function onClose()
		print("==========outline")
	end

	local function onError()
		print("==========Error")
	end

	ws:registerScriptHandler(onWSOpen, cc.WEBSOCKET_OPEN)
	ws:registerScriptHandler(onMessage, cc.WEBSOCKET_MESSAGE)
	ws:registerScriptHandler(onClose, cc.WEBSOCKET_CLOSE)
	ws:registerScriptHandler(onError, cc.WEBSOCKET_ERROR)

	local function onClick(sender)
		if ws:getReadyState() == cc.WEBSOCKET_STATE_OPEN then
			print("-----------sending now")
			ws:sendString("=======hello server")
		else
			print("========WebSocket实例还没准备好")
		end
	end

	local item = cc.MenuItemFont:create("send message")
	item:registerScriptTapHandler(onClick)
	local mn = cc.Menu:create(item)
	mn:alignItemsVertically()
	layer:addChild(mn)

	return layer
end
return WebSocketView