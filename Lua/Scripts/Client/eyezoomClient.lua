
	zSpeed=0.02 -- zoom speed
	zMin=0.5 -- minimum zoom modifier
	zMax=9 -- maximum zoom modifier
	zStart=1 -- default zoom level

	decreaseZoomKey1=Keys.Subtract -- decrease zoom key
	increaseZoomKey1=Keys.Add -- increase zoom key 
	
	decreaseZoomKey2=Keys.OemMinus -- decrease zoom key
	increaseZoomKey2=Keys.OemPlus -- increase zoom key

zoomOn=true
gzsDefault=false
gzsDefaultMin=0.1
gzsDefaultMax=2
zStart=math.max(math.min(zMax,zStart),zMin)
gzsNew=zStart
gzsMin=zMin
gzsMax=zMax
gzsUpd=false

dHeld=false
iHeld=false
zHeld=false



LuaUserData.MakeFieldAccessible(Descriptors["Barotrauma.Camera"],"globalZoomScale")
LuaUserData.MakeMethodAccessible(Descriptors["Barotrauma.Camera"],"CreateMatrices")

Hook.HookMethod("Barotrauma.Camera","CreateMatrices",function(instance,ptable)
	

	gzsDefault=instance.globalZoomScale


	gzsDefaultMin=instance.MinZoom
	gzsDefaultMax=instance.MaxZoom
	gzsMin=math.max(zMin,gzsDefault*zMin)
	gzsMax=math.min(zMax,gzsDefault*zMax)
	gzsNew=math.max(math.min(gzsMax,gzsDefault*zStart),gzsMin)
	gzsUpd=true
	instance.MinZoom=math.min(gzsMin/2,instance.MinZoom)
	instance.MaxZoom=math.max(gzsMax*2,instance.MaxZoom)
end,Hook.HookMethodType.After)

Hook.HookMethod("Barotrauma.Character","ControlLocalPlayer",function(instance,ptable)

if
	not gzsDefault
then
	ptable.cam.CreateMatrices()
end

	if --Zoom Lens
		HF.HasAffliction(Character.Controlled, "zoomlens")
	then
		
		gzsUpd=false

		if 
			not Character.DisableControls 
			and Character.Controlled 
		then

				if --Decrease Zoom
					   PlayerInput.KeyDown(decreaseZoomKey1) 
					or PlayerInput.KeyDown(decreaseZoomKey2) 
				then
					gzsNew=math.max(gzsMin,gzsNew*(1-zSpeed))
					gzsUpd=true
				else
					dHeld=false
				end
					
					
					
				if --Increase Zoom
					   PlayerInput.KeyDown(increaseZoomKey1) 
					or PlayerInput.KeyDown(increaseZoomKey2) 
				then
					gzsNew=math.min(gzsMax,gzsNew*(1+zSpeed))
					gzsUpd=true
				else
					iHeld=false
				end
		end
			
		if gzsUpd then
			ptable.cam.globalZoomScale=zoomOn and gzsNew or gzsDefault
		end
		
			
	elseif --Plastic Eyes
		HF.HasAffliction(Character.Controlled, "eyeplastic")
	then
		ptable.cam.globalZoomScale=gzsDefault+0.7
	
	elseif --Glasses
		HF.HasAffliction(Character.Controlled, "hasglasses")
	then
		ptable.cam.globalZoomScale=gzsDefault
		
	else --Eye Damage
		ptable.cam.globalZoomScale=gzsDefault+HF.GetAfflictionStrength(Character.Controlled,"eyedamage",0)/135
	end

end,Hook.HookMethodType.After) 
