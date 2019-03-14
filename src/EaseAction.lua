local EaseAction = class("EaseAction", function() return cc.Scene:create() end)

function EaseAction:create()
	local scene = EaseAction:new()
	scene:addChild(scene:createLayer())
	return scene
end

function EaseAction:createLayer()
	local layer = cc.LayerGradient:create(cc.c4b(0,0,0,200), cc.c4b(30, 48, 74, 255))
	local boss = ccui.ImageView:create("bossPlane.png")
	boss:setPosition(cc.p(boss:getContentSize().width/2, display.cy))
	layer:addChild(boss)

	local imgClose = cc.MenuItemImage:create("green.png", "red.png")
	local closeSize = imgClose:getContentSize()
	imgClose:setPosition(cc.p(display.width - closeSize.width/2, display.height - closeSize.height/2))
	local function closeHd()
		cc.Director:getInstance():popScene()
	end
	imgClose:registerScriptTapHandler(closeHd)
	local mn = cc.Menu:create(imgClose)
	mn:setPosition(cc.p(0, 0))
	layer:addChild(mn)
	

	local function clickHd(tag, sender)
		local act1 = cc.MoveBy:create(2, cc.p(400, 0))
		local act2 = act1:reverse()
		local seq = cc.Sequence:create(act1, act2)
		if sender:getName() == "EaseIn" then
			boss:runAction(cc.EaseIn:create(seq, 3))
		elseif sender:getName() == "EaseOut" then
			boss:runAction(cc.EaseOut:create(seq, 3))
		elseif sender:getName() == "EaseSineIn" then
			boss:runAction(cc.EaseSineIn:create(seq))
		elseif sender:getName() == "EaseSineOut" then
			boss:runAction(cc.EaseSineOut:create(seq))
		elseif sender:getName() == "EaseExponentialIn" then
			boss:runAction(cc.EaseExponentialIn:create(seq))
		elseif sender:getName() == "EaseExponentialOut" then
			boss:runAction(cc.EaseExponentialOut:create(seq))
		elseif sender:getName() == "EaseExponentialInOut" then
			boss:runAction(cc.EaseExponentialInOut:create(seq))
		elseif sender:getName() == "Speed" then
			boss:runAction(cc.Speed:create(seq, math.random() * 5))
		end
	end

	local EaseIn = cc.MenuItemFont:create("EaseIn")
	EaseIn:setName("EaseIn")

	local EaseOut = cc.MenuItemFont:create("EaseOut")
	EaseOut:setName("EaseOut")

	local EaseSineIn = cc.MenuItemFont:create("EaseSineIn")
	EaseSineIn:setName("EaseSineIn")

	local EaseSineOut = cc.MenuItemFont:create("EaseSineOut")
	EaseSineOut:setName("EaseSineOut")

	local EaseExponentialIn = cc.MenuItemFont:create("EaseExponentialIn")
	EaseExponentialIn:setName("EaseExponentialIn")

	local EaseExponentialOut = cc.MenuItemFont:create("EaseExponentialOut")
	EaseExponentialOut:setName("EaseExponentialOut")

	local EaseExponentialInOut = cc.MenuItemFont:create("EaseExponentialInOut")
	EaseExponentialInOut:setName("EaseExponentialInOut")

	local Speed = cc.MenuItemFont:create("Speed")
	Speed:setName("Speed")

	local menu = cc.Menu:create(EaseIn,EaseOut,EaseSineIn,EaseSineOut,EaseExponentialIn,EaseExponentialOut,EaseExponentialInOut,Speed)
	menu:alignItemsVertically()
	layer:addChild(menu)

	for i, v in pairs(menu:getChildren()) do
		v:registerScriptTapHandler(clickHd)
	end

	return layer
end
return EaseAction