local GridView = class("GridView", function() return cc.Scene:create() end) 

function GridView:create()
	local scene = GridView:new()
	scene:addChild(scene:createLayer())
	return scene
end

function GridView:createLayer()
	local layer = cc.LayerColor:create(cc.c3b(200,100,200))

	local closeItem = cc.MenuItemImage:create("green.png", "red.png")
	closeItem:setPosition(cc.p(display.width - closeItem:getContentSize().width/2, display.height - closeItem:getContentSize().height/2))
	local function closeHd()
		cc.Director:getInstance():popScene()
	end
	closeItem:registerScriptTapHandler(closeHd)

	local mn = cc.Menu:create(closeItem)
	mn:setPosition(cc.p(0,0))
	layer:addChild(mn)

	local boss = cc.Sprite:create("Attack1.png")
	boss:setScale(0.5)
	boss:setPosition(cc.p(display.cx, display.cy))
	-- layer:addChild(boss)

	local girl = cc.Sprite:create("girl1.png")
	girl:setPosition(cc.p(200, 300))
	layer:addChild(girl)

	local FlipX3D = cc.MenuItemFont:create("FlipX3D")
	FlipX3D:setName("FlipX3D")

	local PageTurn3D = cc.MenuItemFont:create("PageTurn3D")
	PageTurn3D:setName("PageTurn3D")

	local Lens3D = cc.MenuItemFont:create("Lens3D")
	Lens3D:setName("Lens3D")

	local Shaky3D = cc.MenuItemFont:create("Shaky3D")
	Shaky3D:setName("Shaky3D")

	local Waves3D = cc.MenuItemFont:create("Waves3D")
	Waves3D:setName("Waves3D")

	local JumpTiles3D = cc.MenuItemFont:create("JumpTiles3D")
	JumpTiles3D:setName("JumpTiles3D")

	local ShakyTiles3D = cc.MenuItemFont:create("ShakyTiles3D")
	ShakyTiles3D:setName("ShakyTiles3D")

	local WavesTiles3D = cc.MenuItemFont:create("WavesTiles3D")
	WavesTiles3D:setName("WavesTiles3D")

	local menu = cc.Menu:create(FlipX3D,PageTurn3D,Lens3D,Shaky3D,Waves3D,JumpTiles3D,ShakyTiles3D,WavesTiles3D)
	menu:alignItemsVertically()
	menu:setPositionX(100)
	layer:addChild(menu)

	local gridManger = cc.NodeGrid:create()
	layer:addChild(gridManger)
	gridManger:addChild(boss)
	local function clickHd(tag, sender)
		print("========================sender", sender:getName())
		local size = cc.size(50, 50)
		if sender:getName() == "FlipX3D" then
			gridManger:runAction(cc.FlipX3D:create(3))
		elseif sender:getName() == "PageTurn3D" then
			gridManger:runAction(cc.PageTurn3D:create(3,size))
		elseif sender:getName() == "Lens3D" then
			gridManger:runAction(cc.Lens3D:create(3,size,cc.p(500, display.cy), 240))
		elseif sender:getName() == "Shaky3D" then
			gridManger:runAction(cc.Shaky3D:create(3,size,5,false))
		elseif sender:getName() == "Waves3D" then
			gridManger:runAction(cc.Waves3D:create(3,size,5,5))
		elseif sender:getName() == "JumpTiles3D" then
			gridManger:runAction(cc.JumpTiles3D:create(3,size,5,40))
		elseif sender:getName() == "ShakyTiles3D" then
			gridManger:runAction(cc.ShakyTiles3D:create(3,size,5,false))
		elseif sender:getName() == "WavesTiles3D" then
			gridManger:runAction(cc.WavesTiles3D:create(3,size,5,40))
		end
	end

	for i, v in pairs(menu:getChildren()) do
		v:registerScriptTapHandler(clickHd)
	end

	return layer
end
return GridView