-------------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------					Made by Murky					-----------------------------------------
-----------------------------				https://steamcommunity.com/id/murkytheone/					-----------------------------
-------------------------------------------------------------------------------------------------------------------------------------

job_giant = job_giant or {}

-- Configuration
job_giant.shakeamplitude = 5
job_giant.shakefrequency = 5
job_giant.shakeduration = 0.25
job_giant.shakeradius = 5000

local radiussqr=math.pow( job_giant.shakeradius, 2 )
net.Receive( job_giant.stepsound, function()
	local pos = net.ReadVector()
	local eyes = EyePos()
	local distsqr = pos:DistToSqr( eyes )
	sound.Play( job_giant.stepsound, pos )
	if distsqr>0 then
		local amplitude = job_giant.shakeamplitude*( 1-( distsqr/radiussqr ) )
		if amplitude>0 then
			util.ScreenShake( pos, amplitude, job_giant.shakefrequency, job_giant.shakeduration, 0 )
		end
	end
end )
hook.Add( "PlayerFootstep", "job_giant", function( ply )
	if ply:Team()==_G[job_giant.teamid] then
		return true
	end
end )
