-- 0 - 不显示debug信息，1 - 打印少量debug信息，2 - 打印标准debug信息
DEBUG = 1

-- 使用框架，将禁用所有过时的API，false - 用过时的API
CC_USE_FRAMEWORK = true

-- 屏幕显示FPS
CC_SHOW_FPS = true

-- 禁止未预期的全局变量
CC_DISABLE_GLOBAL = false

--设计分辨率
CC_DESIGN_RESOLUTION = {
    width = 750,
    height = 1334,
    autoscale = "FIXED_HEIGHT",
    callback = function(framesize)
        local ratio = framesize.width / framesize.height
        if ratio <= 1.34 then
            -- iPad 768*1024(1536*2048) is 4:3 screen
            return {autoscale = "EXACT_FIT"}
        end
    end
}