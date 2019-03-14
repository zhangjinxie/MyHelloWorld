local ActionView = class("ActionView", function() return cc.Scene:create() end)
print("================ActionView")
function ActionView.create()
	local scene = ActionView:new()
	scene:addChild(scene:createLayer())
	return scene
end

function ActionView:createLayer()
	local layer = cc.LayerColor:create(cc.c3b(100,200,255))
	local director = cc.Director:getInstance()
	local winSize = director:getWinSize()
	local boss = cc.Sprite:create("bossPlane.png")
	-- boss:setVisible(false)
	local bossSize = boss:getContentSize()
	boss:setPosition(cc.p(winSize.width/2, winSize.height/2))
	layer:addChild(boss)

	local goItem = cc.MenuItemImage:create("green.png", "red.png")

	goItem:setPosition(cc.p(winSize.width/2, goItem:getContentSize().height/2 + 50))
	local menu = cc.Menu:create(goItem)
	menu:setPosition(cc.p(0,0))
	layer:addChild(menu)
	goItem:registerScriptTapHandler(function(tag, sender) director:popScene() end)
	if actionTag == PLACE then
		boss:runAction(cc.Place:create(cc.p(100, 100)))
	elseif actionTag == FLIPX then
		boss:runAction(cc.FlipX:create(true))
	elseif actionTag == FLIPY then
		boss:runAction(cc.FlipY:create(true))
	elseif actionTag == HIDE then
		boss:runAction(cc.Hide:create())
	elseif actionTag == SHOW then
		boss:runAction(cc.Show:create())
	elseif actionTag == TOGGLEVISIBILITY then
		boss:runAction(cc.ToggleVisibility:create())
	else
		print("=========error", actionTag)
	end
	return layer
end


return ActionView