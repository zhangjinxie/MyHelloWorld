local CcuiView = class("CcuiView", function() return cc.Scene:create() end)
function CcuiView:create()
	local scene = CcuiView:new()
	scene:addChild(scene:createLayer())
	return scene
end
function CcuiView:createLayer()
	local layer = cc.LayerColor:create(cc.c3b(87, 255, 250))

	local closeBtn = ccui.Button:create("close.png")
	local btnSize = closeBtn:getContentSize()
	closeBtn:setPosition(cc.p(display.width - btnSize.width/2, display.height - btnSize.height/2))
	layer:addChild(closeBtn)
	closeBtn:addTouchEventListener(function(sender, event) 
		if event == ccui.TouchEventType.ended then
			cc.Director:getInstance():popScene()
		end
	 end)

	local richText = ccui.RichText:create()
	richText:ignoreContentAdaptWithSize(false)
	richText:setContentSize(200, 200)
	richText:setPosition(cc.p(display.cx, display.cy))
	layer:addChild(richText)

	local richElementText1 = ccui.RichElementText:create(1, cc.c3b(0,0,0), 255, "what a fuck", "Arial", 25)
	local richElementText2 = ccui.RichElementText:create(2, cc.c3b(178,33,66), 255, "i heat you", "Arial", 30)
	local richElementText3 = ccui.RichElementText:create(6, cc.c3b(178,33,66), 255, "大魔王u", "Arial", 50, 16, "http://api.cocos.org/", cc.c3b(0, 32, 44), 2, cc.c3b(100,100,100), cc.p(0, 0), 0, cc.c3b(0,0,0))
	local richElementImage = ccui.RichElementImage:create(3, cc.c3b(255,255,255), 255, "redPoint.png")
	local richElementNewLine = ccui.RichElementNewLine:create(4, cc.c3b(0,0,0), 255)
	local sprite = cc.Sprite:create("close.png")
	local richElementCustomNode = ccui.RichElementCustomNode:create(5, cc.c3b(0, 0, 0), 255, sprite)
	richText:pushBackElement(richElementText1)
	richText:pushBackElement(richElementText2)
	richText:pushBackElement(richElementText3)
	richText:pushBackElement(richElementImage)
	richText:insertElement(richElementNewLine, 1)
	richText:pushBackElement(richElementCustomNode)

	local radioBtnGroup = ccui.RadioButtonGroup:create()
	layer:addChild(radioBtnGroup)
	radioBtnGroup:addEventListener(function(sender, index, event) 
		print("-=======index", index)
	 end)

	local RADIOBTNNUM = 5
	local RADIOBTNWIDTH = 50
	local stratX = display.cx - (RADIOBTNNUM - 1) / 2 * RADIOBTNWIDTH
	for i = 0, RADIOBTNNUM - 1 do 
		local radioBtn = ccui.RadioButton:create("green.png", "redPoint.png")
		radioBtn:setPositionX(stratX + i * RADIOBTNWIDTH)
		radioBtn:setPositionY(display.cy + 200)
		layer:addChild(radioBtn)
		radioBtnGroup:addRadioButton(radioBtn)
	end
	radioBtnGroup:setSelectedButton(2)

	local checkBox = ccui.CheckBox:create("select2d.png", "select2c.png")
	checkBox:setPosition(cc.p(display.cx, display.cy + 300))
	layer:addChild(checkBox)
	checkBox:addEventListener(function(sender, event) 
		if event == ccui.CheckBoxEventType.selected then
			print("-------selected")
		elseif event == ccui.CheckBoxEventType.unselected then
			print("-------unselected")
		end
	 end)

	local loadingBar = ccui.LoadingBar:create("proBar1.png")
	loadingBar:setDirection(ccui.LoadingBarDirection.LEFT)
	layer:addChild(loadingBar)
	loadingBar:setPosition(display.cx, display.cy - 200)
	loadingBar:ignoreContentAdaptWithSize(false)
	-- loadingBar:setContentSize(200, 50)
	local text = ccui.Text:create()
	text:setColor(cc.c3b(0,0,0))
	text:setFontSize(30)
	text:setPosition(cc.p(loadingBar:getContentSize().width/2, loadingBar:getContentSize().height/2))
	loadingBar:addChild(text)
	local num = 0
	local function update(delta)
		num = (num + 1) % 101
		loadingBar:setPercent(num)
		text:setText(num)
	end
	layer:scheduleUpdateWithPriorityLua(update, 0)

	local slider = ccui.Slider:create()
	slider:setPosition(cc.p(display.cx, display.cy + 400))
	slider:loadBarTexture("Bar.png")
	slider:loadSlidBallTextures("green.png", "red.png")
	slider:loadProgressBarTexture("loadingBar.png")
	slider:setMaxPercent(1000)
	slider:addEventListener(function(sender, event) 
		if event == ccui.SliderEventType.percentChanged then
			print("========percent", sender:getPercent())
		end
	 end)
	layer:addChild(slider)
	return layer
end
return CcuiView