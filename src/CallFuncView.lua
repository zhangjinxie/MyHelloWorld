local CallFuncView = class("CallFuncView", function() return cc.Scene:create() end)

function CallFuncView:create()
	local scene = CallFuncView:new()
	scene:addChild(scene:createLayer())
	return scene
end

function CallFuncView:createLayer()
	local layer = cc.LayerGradient:create(cc.c4b(255, 0, 0, 255), cc.c4b(40, 255, 0, 255))
	local closeItem = cc.MenuItemImage:create("green.png", "red.png")
	closeItem:setPosition(cc.p(display.width - closeItem:getContentSize().width/2, display.height - closeItem:getContentSize().height/2))
	local function closeHd()
		cc.Director:getInstance():popScene()
	end
	closeItem:registerScriptTapHandler(closeHd)
	local mn = cc.Menu:create(closeItem)
	mn:setPosition(cc.p(0, 0))
	layer:addChild(mn)

	-- local Callfunc = cc.MenuItemFont:create("Callfunc")
	-- Callfunc:setName("Callfunc")

	-- local CallfuncN = cc.MenuItemFont:create("CallfuncN")
	-- CallfuncN:setName("CallfuncN")

	-- local CallfuncND = cc.MenuItemFont:create("CallfuncND")
	-- CallfuncND:setName("CallfuncND")

	local boss = cc.Sprite:create("Attack1.png") 
	boss:setPosition(cc.p(100, display.cy))
	boss:setScale(0.5)
	layer:addChild(boss)

	local boy = cc.Sprite:create("boy1.png")
	boy:setPosition(cc.p(500, display.cy))
	boy:setScale(0.5)
	layer:addChild(boy)

	local girl = cc.Sprite:create("girl1.png")
	girl:setPosition(cc.p(800, display.cy))
	girl:setScale(0.5)
	layer:addChild(girl)

	local jumpBy = cc.JumpBy:create(0.1, cc.p(0, 0), 3, 5)  --duration, position, height, jumps

	local function callBack3(sender, ta)
		print("have do callBack3")
		dump(ta, "===================ta")
		sender:runAction(cc.TintBy:create(ta[1], ta[2], ta[3], ta[4]))
	end
	local function callBack2(sender)
		print("have do callBack2")
		sender:runAction(cc.Blink:create(3, 30))
		girl:runAction(cc.Sequence:create(cc.DelayTime:create(3), jumpBy, cc.CallFunc:create(callBack3, {20, 58, 99, 100})))
	end
	local function callBack1(...)
		print("have do callBack1")
		boy:runAction(cc.Sequence:create(cc.DelayTime:create(3), jumpBy, cc.CallFunc:create(callBack2)))
	end


	boss:runAction(cc.Sequence:create(cc.DelayTime:create(3), jumpBy, cc.CallFunc:create(callBack1)))

	return layer
end

return CallFuncView