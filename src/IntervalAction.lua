MOVETO = 11
MOVEBY = 12
JUMPTO = 13
JUMPBY = 14
BEZIERBY = 15
SCALETO = 16
SCALEBY = 17
ROTATETO = 18
ROTATEBY = 19
BLINK = 21
TINTTO = 22
TINTBY = 23
FADETO = 24
FADEIN = 25
FADEOUT = 26
SEQUENCE = 27
REPEAT = 28
REPEATFOREVER = 29
REVERSE = 30
local IntervalAction = class("IntervalAction", function() return cc.Scene:create() end)

function IntervalAction:create()
	local scene = IntervalAction:new()
	scene:addChild(scene:createLayer())
	return scene
end

function IntervalAction:createLayer()
	local layer = cc.LayerColor:create(cc.c3b(150,150,150))

	local boss = cc.Sprite:create("bossPlane.png")
	boss:setPosition(cc.p(display.cx, display.cy))
	boss:setScale(0.3)
	layer:addChild(boss)

	local close = cc.MenuItemImage:create("red.png", "green.png")
	local closeSize = close:getContentSize()
	close:setPosition(cc.p(display.width - closeSize.width/2, display.height - closeSize.height/2))

	local function closeScene()
		cc.Director:getInstance():popScene()
	end
	close:registerScriptTapHandler(closeScene)
	local menu = cc.Menu:create(close)
	menu:setPosition(cc.p(0, 0))
	layer:addChild(menu)

	local moveTo = cc.MenuItemFont:create("moveTo")
	moveTo:setTag(MOVETO)

	local moveBy = cc.MenuItemFont:create("moveBy")
	moveBy:setTag(MOVEBY)

	local jumpTo = cc.MenuItemFont:create("jumpTo")
	jumpTo:setTag(JUMPTO)

	local jumpBy = cc.MenuItemFont:create("jumpBy")
	jumpBy:setTag(JUMPBY)

	local bezierBy = cc.MenuItemFont:create("bezierBy")
	bezierBy:setTag(BEZIERBY)

	local scaleTo = cc.MenuItemFont:create("scaleTo")
	scaleTo:setTag(SCALETO)

	local scaleBy = cc.MenuItemFont:create("scaleBy")
	scaleBy:setTag(SCALEBY)

	local rotateTo = cc.MenuItemFont:create("rotateTo")
	rotateTo:setTag(ROTATETO)

	local rotateBy = cc.MenuItemFont:create("rotateBy")
	rotateBy:setTag(ROTATEBY)

	local blink = cc.MenuItemFont:create("blink")
	blink:setTag(BLINK)

	local tintTo = cc.MenuItemFont:create("tintTo")
	tintTo:setTag(TINTTO)

	local tintBy = cc.MenuItemFont:create("tintBy")
	tintBy:setTag(TINTBY)

	local fadeTo = cc.MenuItemFont:create("fadeTo")
	fadeTo:setTag(FADETO)

	local fadeIn = cc.MenuItemFont:create("fadeIn")
	fadeIn:setTag(FADEIN)

	local fadeOut = cc.MenuItemFont:create("fadeOut")
	fadeOut:setTag(FADEOUT)

	local sequence = cc.MenuItemFont:create("sequence")
	sequence:setTag(SEQUENCE)

	local repeatMenu = cc.MenuItemFont:create("repeatMenu")
	repeatMenu:setTag(REPEAT)

	local repeatForeverMenu = cc.MenuItemFont:create("repeatForeverMenu")
	repeatForeverMenu:setTag(REPEATFOREVER)

	local reverse = cc.MenuItemFont:create("reverse")
	reverse:setTag(REVERSE)


	local menu1 = cc.Menu:create(moveTo,moveBy,jumpTo,jumpBy,bezierBy,scaleTo,scaleBy,rotateTo,rotateBy,blink,tintTo,tintBy,fadeTo,fadeIn,fadeOut,sequence,repeatMenu,repeatForeverMenu,reverse)
	menu1:alignItemsInRows(5,5,5,4)
	layer:addChild(menu1)

	local function clickFunc(tag, sender)
		print("==============clickFunc", tag)
		if tag == MOVETO then
			boss:setPosition(cc.p(0, 0))
			boss:runAction(cc.MoveTo:create(1, cc.p(display.cx, display.cy)))
		elseif tag == MOVEBY then
			boss:setPosition(cc.p(100, 100))
			boss:runAction(cc.MoveBy:create(1, cc.p(display.cx, display.cy)))
		elseif tag == JUMPTO then
			boss:setPosition(cc.p(100, 100))
			boss:runAction(cc.JumpTo:create(1, cc.p(display.cx, display.cy), 30, 5)) -- time,point,jump hight once,jump count
		elseif tag == JUMPBY then
			boss:setPosition(cc.p(100, 100))
			boss:runAction(cc.JumpBy:create(1, cc.p(display.cx, display.cy), 30, 5))
		elseif tag == BEZIERBY then
			local bezier = {
				cc.p(100,100),
				cc.p(200,160),
				cc.p(300,350)
			} 
			boss:runAction(cc.BezierBy:create(1, bezier))
		elseif tag == SCALETO then
			boss:runAction(cc.ScaleTo:create(2, 4))
		elseif tag == SCALEBY then
			boss:setScale(1)
			boss:runAction(cc.ScaleBy:create(2, 2))
		elseif tag == ROTATETO then
			boss:runAction(cc.RotateTo:create(1, 90))
		elseif tag == ROTATEBY then
			boss:runAction(cc.RotateBy:create(1, 90))
		elseif tag == BLINK then
			boss:runAction(cc.Blink:create(3, 10))
		elseif tag == TINTTO then
			boss:runAction(cc.TintTo:create(2, cc.c3b(255, 0, 0)))
		elseif tag == TINTBY then
			boss:runAction(cc.TintBy:create(2, 255, 255, 255))
		elseif tag == FADETO then
			boss:runAction(cc.FadeTo:create(1, 150))
		elseif tag == FADEIN then
			boss:runAction(cc.FadeIn:create(1))
		elseif tag == FADEOUT then
			boss:runAction(cc.FadeOut:create(1))
		elseif tag == SEQUENCE then
			local mo = cc.MoveTo:create(2, cc.p(display.width, display.height))		
			local blink = cc.Blink:create(2, 10)
			boss:runAction(cc.Sequence:create(mo, blink))
		elseif tag == REPEAT then
			local mo = cc.MoveTo:create(2, cc.p(display.width, display.height))		
			local blink = cc.Blink:create(2, 10)
			boss:runAction(cc.Repeat:create(cc.Spawn:create(mo,blink), 3))
		elseif tag == REPEATFOREVER then
			local mo = cc.MoveTo:create(2, cc.p(display.width, display.height))		
			local blink = cc.Blink:create(2, 10)
			boss:runAction(cc.RepeatForever:create(cc.Spawn:create(mo,blink)))
		elseif tag == REVERSE then
			local mo = cc.MoveBy:create(2, cc.p(100, 100))		
			local re = mo:reverse()
			local seq = cc.Sequence:create(mo,re)
			boss:runAction(cc.RepeatForever:create(seq))
		end
	end

	for i, v in pairs(menu1:getChildren()) do
		v:registerScriptTapHandler(clickFunc)
	end
	return layer

end

return IntervalAction