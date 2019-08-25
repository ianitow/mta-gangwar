local sm = {}
sm.moov = 0
sm.object1,sm.object2 = nil,nil
 
function removeCamHandler()
	if(sm.moov == 1)then
                sm.moov = 0
                return true
	end
end
 
function camRender()
	if (sm.moov == 1) then
		local x1,y1,z1 = getElementPosition(sm.object1)
		local x2,y2,z2 = getElementPosition(sm.object2)
		setCameraMatrix(x1,y1,z1,x2,y2,z2)
	end
end
 
function smoothMoveCamera(x1,y1,z1,x1t,y1t,z1t,x2,y2,z2,x2t,y2t,z2t,time)
	if(sm.moov == 1)then return false end
	sm.object1 = createObject(1337,x1,y1,z1)
	sm.object2 = createObject(1337,x1t,y1t,z1t)
	setElementAlpha(sm.object1,0)
	setElementAlpha(sm.object2,0)
	setObjectScale(sm.object1,0.01)
	setObjectScale(sm.object2,0.01)
	moveObject(sm.object1,time,x2,y2,z2,0,0,0,"InOutQuad")
	moveObject(sm.object2,time,x2t,y2t,z2t,0,0,0,"InOutQuad")
	sm.moov = 1
	setTimer(removeCamHandler,time,1)
	setTimer(destroyElement,time,1,sm.object1)
	setTimer(destroyElement,time,1,sm.object2)
	return true
end
Blur = {}
 
local shader = false
local renderTarget = false
local screenSource = false
local screenWidth, screenHeight = guiGetScreenSize()
 
function Blur.createShader()
        shader = dxCreateShader("/gfx/login/blur.fx")
 
        if not shader then
                outputDebugString("Failed to create blur shader")
                return false
        end
 
        renderTarget = dxCreateRenderTarget(screenWidth, screenHeight, true)
 
        if not renderTarget then
                destroyElement(shader)
                shader = false
                outputDebugString("Failed to create a render target for blur shader")
                return false
        end
 
        screenSource = dxCreateScreenSource(screenWidth, screenHeight)
 
        if not screenSource then
                destroyElement(renderTarget)
                destroyElement(shader)
                shader = false
                renderTarget = false
                outputDebugString("Failed to create a screen source for blur shader")
                return false
        else
                dxSetShaderValue(shader, 'texture0', renderTarget)
        end
 
        return true
end
 
function Blur.render(alpha, strength)
        -- Update screen source
        dxUpdateScreenSource(screenSource, true)
       
        -- Switch rendering to our render target
        dxSetRenderTarget(renderTarget, false)
       
        -- Prepare render target content
        dxDrawImage(0, 0, screenWidth, screenHeight, screenSource)
       
        -- Repeat shader align on the image inside the render target
        for i = 0, 8 do
                dxSetShaderValue(shader, 'factor', 0.0020 * strength + (i / 8 * 0.001 * strength))
                dxDrawImage(0, 0, screenWidth, screenHeight, shader)
        end
       
        -- Restore the default render target
        dxSetRenderTarget()
       
        dxDrawImage(0, 0, screenWidth, screenHeight, renderTarget, 0, 0, 0, tocolor(255, 255, 255, alpha))
end
 
function Blur:getScreenTexture()
        return renderTarget
end
