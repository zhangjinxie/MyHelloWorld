local MulParticleView = class("MulParticleView", function() return cc.Scene:create() end)

function MulParticleView:create()
	local scene = MulParticleView:new()
	scene:addChild(scene:createLayer())
	return scene
end

function MulParticleView:createLayer()
	local layer = cc.LayerColor:create(cc.c3b(100,38,50))
	local function closeHd(sender, event)
		if event == ccui.TouchEventType.ended then
			cc.Director:getInstance():popScene()
		end
	end
	local closeBtn = ccui.Button:create("close.png")
	local size = closeBtn:getContentSize()
	closeBtn:setPosition(cc.p(display.width - size.width/2, display.height - size.height/2))
	layer:addChild(closeBtn)
	closeBtn:addTouchEventListener(closeHd)

	local sun = cc.MenuItemFont:create("sun")
	sun:setName("sun")

	local snow = cc.MenuItemFont:create("snow")
	snow:setName("snow")

	local smoke = cc.MenuItemFont:create("smoke")
	smoke:setName("smoke")

	local rain = cc.MenuItemFont:create("rain")
	rain:setName("rain")

	local fire = cc.MenuItemFont:create("fire")
	fire:setName("fire")

	local fireworks = cc.MenuItemFont:create("fireworks")
	fireworks:setName("fireworks")

	local galaxy = cc.MenuItemFont:create("galaxy")
	galaxy:setName("galaxy")

	local flower = cc.MenuItemFont:create("flower")
	flower:setName("flower")

	local spiral = cc.MenuItemFont:create("spiral")
	spiral:setName("spiral")

	local meteor = cc.MenuItemFont:create("meteor")
	meteor:setName("meteor")

	local explosion = cc.MenuItemFont:create("explosion")
	explosion:setName("explosion")

	local mn = cc.Menu:create(sun,snow,smoke,rain,fire,fireworks,galaxy,flower,spiral,meteor,explosion)
	mn:alignItemsInColumns(3,3,3,2)
	layer:addChild(mn)

	local function clickHd(tag, sender)
		local selectName = sender:getName()
		local particle
		if selectName == "sun" then
			particle = cc.ParticleSun:create()
		elseif selectName == "snow" then
			particle = cc.ParticleSnow:create()
		elseif selectName == "smoke" then
			particle = cc.ParticleSmoke:create()
		elseif selectName == "rain" then
			particle = cc.ParticleRain:create()
		elseif selectName == "fire" then
			particle = cc.ParticleFire:create()
		elseif selectName == "fireworks" then
			particle = cc.ParticleFireworks:create()
		elseif selectName == "galaxy" then
			particle = cc.ParticleGalaxy:create()
		elseif selectName == "flower" then
			particle = cc.ParticleFlower:create()
		elseif selectName == "spiral" then
			particle = cc.ParticleSpiral:create()
		elseif selectName == "meteor" then
			particle = cc.ParticleMeteor:create()
		elseif selectName == "explosion" then
			particle = cc.ParticleExplosion:create()
		end
		particle:setPosition(cc.p(display.cx, display.cy))
		layer:addChild(particle)
	end
	for i, v in ipairs(mn:getChildren()) do
		v:registerScriptTapHandler(clickHd)
	end
	return layer
end
return MulParticleView