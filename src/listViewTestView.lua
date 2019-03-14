local PanelUI = require("PanelUI")
local __Class = class("__Class", PanelUI)
-- local __Class = class("__Class", cc.Node)
-- function __Class:getChild(...)
-- 	local args = {...}
-- 	parent = self
-- 	if parent then
-- 		for i, v in pairs(args) do
-- 			parent = parent:getChildByName(v)
-- 		end
-- 		return parent
-- 	end
-- end
-- local display = {}
-- display.width = 750
-- display.height = 1334
-- display.cx = 375
-- display.cy = 667
function __Class:using()
	local stu = self
	-- self = __Class
	self.stu = stu
	local bg = cc.Sprite:create("map/bg1.jpg")
	local bg2 = cc.Sprite:create("map/bg2.png")
	bg2:setPosition(cc.p(0, -display.cy + bg2:getContentSize().height/2))
	stu:addChild(bg)
	stu:addChild(bg2)
	bg:setLocalZOrder(-99999)
	bg2:setLocalZOrder(99999)

	local closeBtn = ccui.Button:create("close.png")
	local closeSize = closeBtn:getContentSize()
	closeBtn:setPosition(cc.p(display.cx - closeSize.width/2, display.cy - closeSize.height/2))
	stu:addChild(closeBtn)
	local function closeHd(sender, event)
		if event == ccui.TouchEventType.ended then
			stu:removeFromParentAndCleanup(true)
			stu = nil 	--可以不用置为nil，但建议这样做
		end
	end
	closeBtn:addTouchEventListener(closeHd)

	local poNew
	local poOld
	local cards = {}
	for i = 1, 6 do
		local node = cc.Node:create()
		local image = ccui.ImageView:create("map/11.png")
		stu:addChild(node)
		node:addChild(image)
		image:setName("Image_16")
		node:setName("node"..i)
		image:setTag(i)
		table.insert(cards, node)
		local text = ccui.Text:create()
		text:setString(i..i..i..i)
		text:setFontSize(40)
		text:setTextColor(cc.c3b(0,0,0))
		node:addChild(text)
	end
	self.cards = cards
	self.cardsLen = #cards - 1 == 0 and 1 or #cards - 1
	self.selectedCard = 99999
	self.itemSize = stu:getChild("node1", "Image_16"):getContentSize()
	local r = display.cx + self.itemSize.width
	self.r = r
	self.offsetY = display.cx + self.itemSize.width + display.cy - self.itemSize.height/2 + 17
	for i, v in ipairs(cards) do
		v:setPositionX((display.width / self.cardsLen) * (i - 0.5) - display.cx)
		v:setPositionY((math.sqrt(math.pow(r,2) - math.pow(v:getPositionX(),2))) - self.offsetY - (math.abs(v:getPositionX())/5))
		local angle = math.atan(v:getPositionX()/r)*180/math.pi
		v:setRotation(angle)
	end
	local function onTouch(sender, touch, event)
		if event == ccui.TouchEventType.began then
			self.stu:unscheduleUpdate()
			poOld = touch:getTouchBeganPosition()
			self.poBegan = poOld
			self.startTime = os.time()
		elseif event == ccui.TouchEventType.moved then
			poNew = touch:getTouchMovePosition()
			self:updatePo(poNew.x - poOld.x)
			poOld = poNew
		elseif event == ccui.TouchEventType.ended or event == ccui.TouchEventType.canceled then
			poEnd = touch:getTouchEndPosition()
			if self.poBegan.x == poEnd.x then 		--选中某项
				-- if self.selectedCard == sender:getTag() then
				-- 	return
				-- end
				self.selectedCard = sender:getTag()
				self:gotoItem(sender:getTag())
			else
				local diffTime = os.time() - self.startTime
				self.speed = (poEnd.x - self.poBegan.x) / diffTime

				local tableY = {}
				for i, v in ipairs(cards) do
					local tmp = {i, v:getPositionY(),v:getPositionX()}
					table.insert(tableY, tmp)
				end
				table.sort(tableY, function(a,b) return a[2] > b[2] end)
				self.maxHeightIndex = tableY[1][1]
				self:gotoItem(self.maxHeightIndex)
			end
		end	
	end

	for i, v in ipairs(cards) do
		v:getChildByName("Image_16"):setTouchEnabled(true)
		v:getChildByName("Image_16"):setSwallowTouches(true)
		v:getChildByName("Image_16"):addTouchEventListener(handler(v:getChildByName("Image_16"),onTouch))
	end
	return stu
end

function __Class:updatePo(speed)
	for i, v in ipairs(self.cards) do
		local offset = display.cx + self.itemSize.width/2 - self.itemSize.width/4
		v:setPositionX((v:getPositionX() + offset) % (display.width + display.width / self.cardsLen) - offset + speed)
		v:setPositionY((math.sqrt(math.abs(math.pow(self.r,2) - math.pow(v:getPositionX(),2)))) - self.offsetY - (math.abs(v:getPositionX())/5))
		v:setLocalZOrder(math.floor(v:getPositionX()))
		local angle = math.atan(v:getPositionX()/self.r)*180/math.pi
		v:setRotation(angle)
	end
end
function __Class:gotoItem(index)
	local mid_card = self.cards[index]
	local firstIndex = index + #self.cards - (#self.cards/2 - 1)
	firstIndex = firstIndex % #self.cards == 0 and #self.cards or firstIndex % #self.cards
	local speed = mid_card:getPositionX() > 0 and -10 or 10
	local function updatePo(delta)
		if mid_card:getPositionX() > 0 then
			if mid_card:getPositionX() + speed < 0 then
				speed =  0 - mid_card:getPositionX()
			end
		elseif mid_card:getPositionX() < 0 then
			if mid_card:getPositionX() + speed > 0 then
				speed =  0 - mid_card:getPositionX()
			end
		elseif mid_card:getPositionX() == 0 then 		--停止
			self.stu:unscheduleUpdate()
			mid_card:setPositionY((math.sqrt(math.abs(math.pow(self.r,2) - math.pow(mid_card:getPositionX(),2)))) - self.offsetY - (math.abs(mid_card:getPositionX())/5))
			mid_card:runAction(cc.MoveBy:create(0.3, cc.p(0,40)))
			for i = 1, math.ceil(#self.cards/2) do
				self.cards[index]:setLocalZOrder(-self.cards[index]:getPositionX())
				index = (index + 1)%#self.cards == 0 and #self.cards or (index + 1)%#self.cards
			end
			-- cc.Director:getInstance():getScheduler():unscheduleScriptEntry(self.scheduleId)
			return
		end
		self:updatePo(speed)
	end
	self.stu:scheduleUpdateWithPriorityLua(updatePo, 1)
	-- self.scheduleId = cc.Director:getInstance():getScheduler():scheduleScriptFunc(updatePo, 2, false)
end
return __Class
-- end