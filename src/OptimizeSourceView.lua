local OptimizeSourceView = class("OptimizeSourceView", function() return cc.Scene:create() end)

function OptimizeSourceView:create()
	local scene = OptimizeSourceView:new()
	scene:addChild(scene:createLayer())
	return scene
end

function OptimizeSourceView:createLayer()
	local layer = cc.LayerColor:create(cc.BLUE)
	local closeBtn = ccui.Button:create("close.png")
	local closeSize = closeBtn:getContentSize()
	closeBtn:setPosition(display.width - closeSize.width/2, display.height - closeSize.height/2)
	layer:addChild(closeBtn)
	local function closeHd(touch, eventType)
		if eventType == ccui.TouchEventType.ended then
			cc.Director:getInstance():popScene()
		end
	end
	closeBtn:addTouchEventListener(closeHd)

	local shareFileUtils = cc.FileUtils:getInstance()
	shareFileUtils:addSearchPath("res/_ATTACK")
	local dict = shareFileUtils:getValueMapFromFile("opSource.plist")
	local sum = 0
	for i, v in pairs(dict.frames) do
		sum = sum + 1
	end
	local curNum = 0

	local loadingBar = ccui.LoadingBar:create("proBar1.png")
	loadingBar:setDirection(ccui.LoadingBarDirection.LEFT)
	loadingBar:setPosition(center)
	layer:addChild(loadingBar)

	local txtPer = ccui.Text:create()
	local barSize = loadingBar:getContentSize()
	txtPer:setFontSize(40)
	txtPer:setColor(cc.BLACK)
	txtPer:setPosition(barSize.width/2, barSize.height/2)
	loadingBar:addChild(txtPer)

	local i = 0
	local function createSprite(texture)
		local sprite = cc.Sprite:createWithTexture(texture)
		local spriteSize = cc.size(sprite:getContentSize().width * 0.2, sprite:getContentSize().height * 0.2)
		sprite:setPosition((spriteSize.width/2 + i % 3 * spriteSize.width) , spriteSize.height/2 + spriteSize.height * math.floor((spriteSize.width/2 + i * spriteSize.width) / 750))
		i = i + 1
		sprite:setScale(0.2)
		layer:addChild(sprite)
		curNum = curNum + 1
		txtPer:setText(string.format("%d%%", curNum / sum * 100))
		loadingBar:setPercent(curNum / sum * 100) 
	end
	for i, v in pairs(dict.frames) do
		local fileName = shareFileUtils:fullPathForFilename(v)
		cc.Director:getInstance():getTextureCache():addImageAsync(fileName, createSprite)
	end
	-- dump(dict)
	return layer
end
return OptimizeSourceView