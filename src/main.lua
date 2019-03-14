-- cc.FileUtils:getInstance():setPopupNotify(false)

require "config"
require "cocos.init"
-- local print = release_print

local function main()
    collectgarbage("collect")
    collectgarbage("setpause", 100)
    collectgarbage("setstepmul", 5000)
    local director = cc.Director:getInstance()
    -- director:getOpenGLView():setDesignResolutionSize(750, 1334, cc.ResolutionPolicy.FIXED_HEIGHT)
    director:setDisplayStats(true)
    director:setAnimationInterval(1.0 / 60)
    local scene = require("GameScene")
    local gameScene = scene.create()
    if cc.Director:getInstance():getRunningScene() then
    	cc.Director:getInstance():replaceScene(gameScene)
    else
    	cc.Director:getInstance():runWithScene(gameScene)
    end
end

local status, msg = xpcall(main, __G__TRACKBACK__)
if not status then
    print(msg)
end
