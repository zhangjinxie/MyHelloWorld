function getEmitter(idx)
        local emitter = cc.ParticleSnow:create()      --创建一个雪花粒子发射器
        emitter:setDuration(-1)                       --设置发射粒子的持续时间-1表示一直发射，0没有意义，其他值表示持续时间 
        emitter:setPosition(300, display.height)                --设置粒子发射器的位置  
        emitter:setLife(5)                           --设置粒子的生命值
        emitter:setLifeVar(1)                         --设置粒子生命值衰减变化区间

        emitter:setGravity(cc.p(30, -10))              --设置粒子重力方向,这个点是相对发射点，x正方向为右，y正方向为上 
        emitter:setSpeed(130)                         --设置粒子速度
        emitter:setSpeedVar(40)                       --设置速度变化区间  

        local startColor = emitter:getStartColor()    --设置粒子开始的颜色  
        startColor.r = 0.9
        startColor.g = 0.9
        startColor.b = 0.9
        emitter:setStartColor(startColor)

        local startColorVar = emitter:getStartColorVar()
        startColorVar.b = 0.1
        emitter:setStartColorVar(startColorVar)       --设置粒子颜色变化区间  
        local size = cc.Sprite:create("redPoint.png"):getContentSize()
        emitter:setStartSize(size.width)              --设置粒子开始的大小
        emitter:setEndSize(size.width / 3)            --设置粒子生命结束时的大小
        emitter:setEndSizeVar(size.width / 3 / emitter:getLife())  
        if idx == 3 then
            emitter:setEmissionRate(emitter:getTotalParticles() / emitter:getLife() / 2)  --设置发射器每秒钟发射的粒子个数
        else
            emitter:setEmissionRate(emitter:getTotalParticles() / emitter:getLife() / 20)
            emitter:setTotalParticles(8)              --设置总的粒子个数
        end

        emitter:setTexture(cc.Director:getInstance():getTextureCache():addImage("redPoint.png")) --设置发射的粒子图片
        return emitter
end

return getEmitter