local AnimationView = class("AnimationView", function() return cc.Scene:create() end)

function AnimationView:create()
	local scene = AnimationView:new()
	scene:addChild(scene:createLayer())
	return scene
end

function AnimationView:createLayer()
	local layer = cc.LayerColor:create(cc.c3b(0,0,255))
	local closeItem = cc.MenuItemImage:create("green.png", "red.png")
	closeItem:setPosition(cc.p(display.width - closeItem:getContentSize().width/2, display.height - closeItem:getContentSize().height/2))
	local function closeHd()
		cc.Director:getInstance():popScene()
	end
	closeItem:registerScriptTapHandler(closeHd)

	local mn = cc.Menu:create(closeItem)
	mn:setPosition(cc.p(0,0))
	layer:addChild(mn)

	local spFramesCache = cc.SpriteFrameCache:getInstance()
	spFramesCache:addSpriteFrames("attack.plist")
	local sp1 = cc.Sprite:createWithSpriteFrameName("Attack__000.png")
	sp1:setPosition(cc.p(display.cx, display.cy))
	sp1:setScale(0.5)
	layer:addChild(sp1)

	local animation = cc.Animation:create()
	for i = 0, 9 do
		local spFrame = spFramesCache:getSpriteFrameByName(string.format("Attack__00%d.png", i))
		animation:addSpriteFrame(spFrame)
	end
	animation:setDelayPerUnit(0.15)
	animation:setRestoreOriginalFrame(true)
	local animate = cc.Animate:create(animation)
	sp1:runAction(cc.RepeatForever:create(animate))

	return layer
end
return AnimationView