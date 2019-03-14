local BASE_RUL = "http://www.51work6.com/service/mynotes/WebService.php"
-- local selectedRowId = 1483
local XmlHttpRequestView = class("XmlHttpRequestView", function() return cc.Scene:create() end)

function XmlHttpRequestView:create()
	local scene = XmlHttpRequestView:new()
	scene:addChild(scene:createLayer())
	return scene
end

function XmlHttpRequestView:createLayer()
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

	local function onQueryHd()
		local xhr = cc.XMLHttpRequest:new()
		xhr.responseType = cc.XMLHTTPREQUEST_RESPONSE_JSON

		local data = string.format("email=%s&type=%s&action=%s", "77944968@qq.com", "JSON", "query")
		local url = BASE_RUL .. "?" .. data
		xhr:open("GET", url)

		local function onReadyStateChange()
			if xhr.readyState == 4 and xhr.status == 200 then
				print("========query================xhr.responseText", xhr.responseText)
				local jsonStr = json.decode(xhr.responseText)
				print("===============ResultCode:", jsonStr.ResultCode)
				for i, v in pairs(jsonStr.Record)do
					print("\n++++++++++++++++++++++++++++record:\t" .. i .. "\t++++++++++++++++++++++++++++\n")
					print("========ID:", v.ID .. "\n")
					print("========CDate:", v.CDate .. "\n")
					print("========Content:", v.Content .. "\n")
				end
			end
		end
		xhr:registerScriptHandler(onReadyStateChange)
		xhr:send()
	end

	local queryItem = cc.MenuItemFont:create("query")
	queryItem:registerScriptTapHandler(onQueryHd)

	local function onInsertHd()
		local xhr = cc.XMLHttpRequest:new()
		xhr.responseType = cc.XMLHTTPREQUEST_RESPONSE_JSON

		local data = string.format("email=%s&type=%s&action=%s&date=%s&content=%s", "77944968@qq.com", "JSON", "add", "2019 - 02 - 25", "哈哈哈哈哈哈")
		xhr:open("POST", BASE_RUL)

		local function onReadyStateChange()
			if xhr.readyState == 4 and xhr.status == 200 then
				print("========insert================xhr.responseText", xhr.responseText)
			end
		end
		xhr:registerScriptHandler(onReadyStateChange)
		xhr:send(data)
	end

	local insertItem = cc.MenuItemFont:create("insert")
	insertItem:registerScriptTapHandler(onInsertHd)

	local function onRemoveHd()
		local xhr = cc.XMLHttpRequest:new()
		xhr.responseType = cc.XMLHTTPREQUEST_RESPONSE_JSON

		local data = string.format("email=%s&type=%s&action=%s&id=%s", "77944968@qq.com", "JSON", "remove", "6281")
		xhr:open("POST", BASE_RUL)

		local function onReadyStateChange()
			if xhr.readyState == 4 and xhr.status == 200 then
				print("========remove================xhr.responseText", xhr.responseText)
			end
		end
		xhr:registerScriptHandler(onReadyStateChange)
		xhr:send(data)
	end

	local removeItem = cc.MenuItemFont:create("remove")
	removeItem:registerScriptTapHandler(onRemoveHd)

	local function onModifyHd()
		local xhr = cc.XMLHttpRequest:new()
		xhr.responseType = cc.XMLHTTPREQUEST_RESPONSE_JSON

		local data = string.format("email=%s&type=%s&action=%s&id=%s&date=%s&content=%s", "77944968@qq.com", "JSON", "modify", "6282", "2019 - 02 - 28", "我的天啊")
		xhr:open("POST", BASE_RUL)

		local function onReadyStateChange()
			if xhr.readyState == 4 and xhr.status == 200 then
				print("========modify================xhr.responseText", xhr.responseText)
			end
		end
		xhr:registerScriptHandler(onReadyStateChange)
		xhr:send(data)
	end

	local modifyItem = cc.MenuItemFont:create("modify")
	modifyItem:registerScriptTapHandler(onModifyHd)

	local tmpStr1 = {id = 1, content = "我是谁"}
	print("===========tmpStr1 encode", json.encode(tmpStr1))

	local tmpStr2 = {{ResultCode = 1}, {id = "1", content = "我是谁"}, {id = 2, content = "我是谁1"}}
	print("===========tmpStr2 encode", json.encode(tmpStr2))

	local tmpStr3 = {ResultCode = 1, record = {{id = "1", content = "我是谁"}, {id = 2, content = "我是谁1"}}}
	print("===========tmpStr3 encode", json.encode(tmpStr3))

	local menu = cc.Menu:create(queryItem, insertItem, removeItem, modifyItem)
	menu:alignItemsVertically()
	layer:addChild(menu)


	return layer
end
return XmlHttpRequestView