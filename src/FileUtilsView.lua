local FileUtilsView = class("FileUtilsView", function() return cc.Scene:create() end)

function FileUtilsView:create()
	local scene = FileUtilsView:new()
	scene:addChild(scene:createLayer())
	return scene
end

function FileUtilsView:createLayer()
	local layer = cc.LayerColor:create(cc.c3b(47, 32, 28))
	local closeBtn = ccui.Button:create("close.png")
	local closeSize = closeBtn:getContentSize()
	closeBtn:setPosition(cc.p(display.width - closeSize.width/2, display.height - closeSize.height/2))
	closeBtn:addTouchEventListener(function(sender, event) if event == ccui.TouchEventType.ended then cc.Director:getInstance():popScene() end end)
	layer:addChild(closeBtn)

	local sharedFileUtils = cc.FileUtils:getInstance()

	local menuItem1 = cc.MenuItemFont:create("file.obj is Exist?")
	menuItem1:setFontSizeObj(30)
	menuItem1:setFontNameObj("Arial")
	menuItem1:setPosition(center)
	menuItem1:registerScriptTapHandler(function(tag, sender) 
		-- print("======file.obj isExist:", sharedFileUtils:isFileExist("file.obj"))
		print(string.format("======file.obj is Exist:%s", sharedFileUtils:isFileExist("file.obj")))
	 end)

	local menuItem2 = cc.MenuItemFont:create("readFile fileUtilsTest")
	menuItem2:setFontSizeObj(30)
	menuItem2:setFontNameObj("Arial")
	menuItem2:setPosition(cc.p(display.cx, display.cy - 100))
	menuItem2:registerScriptTapHandler(function(tag, sender) 
		print("======fileUtilsTest:", sharedFileUtils:getStringFromFile("fileUtilsTest.txt"))
	 end)

	local menuItem3 = cc.MenuItemFont:create("show search paths")
	menuItem3:setFontSizeObj(30)
	menuItem3:setFontNameObj("Arial")
	menuItem3:setPosition(cc.p(display.cx, display.cy + 100))
	menuItem3:registerScriptTapHandler(function(tag, sender) 
		dump(sharedFileUtils:getSearchPaths(), "======show search paths:")
	 end)

	local menuItem4 = cc.MenuItemFont:create("set search paths")
	menuItem4:setFontSizeObj(30)
	menuItem4:setFontNameObj("Arial")
	menuItem4:setPosition(cc.p(display.cx, display.cy + 200))
	menuItem4:registerScriptTapHandler(function(tag, sender) 
		local t = sharedFileUtils:getSearchPaths()
		table.insert(t, "test1/random1")
		table.insert(t, "test1/random2")
		table.insert(t, "test2")
		print(sharedFileUtils:setSearchPaths(t), "======set search paths")
	 end)

	local menuItem5 = cc.MenuItemFont:create("add search path")
	menuItem5:setFontSizeObj(30)
	menuItem5:setFontNameObj("Arial")
	menuItem5:setPosition(cc.p(display.cx, display.cy + 300))
	menuItem5:registerScriptTapHandler(function(tag, sender) 
		local t = sharedFileUtils:getSearchPaths()
		print(sharedFileUtils:addSearchPath("test3"), "======add search path")
	 end)

	local menuItem6 = cc.MenuItemFont:create("get writable search path")
	menuItem6:setFontSizeObj(30)
	menuItem6:setFontNameObj("Arial")
	menuItem6:setPosition(cc.p(display.cx, display.cy + 400))
	menuItem6:registerScriptTapHandler(function(tag, sender) 
		dump(sharedFileUtils:getWritablePath(), "==========get writable search path")
	 end)

	local mn = cc.Menu:create(menuItem1, menuItem2, menuItem3, menuItem4, menuItem5, menuItem6)
	mn:setPosition(cc.p(0,0))
	layer:addChild(mn)
	return layer
end
return FileUtilsView