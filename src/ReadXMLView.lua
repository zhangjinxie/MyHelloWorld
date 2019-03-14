local ReadXMLView = class("ReadXMLView", function() return cc.Scene:create() end)

function ReadXMLView:create()
	local scene = ReadXMLView:new()
	scene:addChild(scene:createLayer())
	return scene
end

function ReadXMLView:createLayer()
	local layer = cc.LayerColor:create(cc.BLUE)
	local closeBtn = ccui.Button:create("close.png")
	local closeSize = closeBtn:getContentSize()
	closeBtn:setPosition(cc.p(display.width - closeSize.width/2, display.height - closeSize.height/2))
	layer:addChild(closeBtn)
	closeBtn:addTouchEventListener(function(sender, event) if event == ccui.TouchEventType.ended then cc.Director:getInstance():popScene() end end)

	local sharedFileUtils = cc.FileUtils:getInstance()
	local dict = sharedFileUtils:getValueMapFromFile("chenai.plist")
	dump(dict)

	local result = {}
	local function newDump(value, description)
		if type(value) ~= "table" then

		end
	end

	return layer
end
return ReadXMLView