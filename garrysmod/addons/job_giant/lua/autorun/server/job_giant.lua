-------------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------					Made by Murky					-----------------------------------------
-----------------------------				https://steamcommunity.com/id/murkytheone/					-----------------------------
-------------------------------------------------------------------------------------------------------------------------------------

job_giant = job_giant or {}

job_giant.LastStep = job_giant.LastStep or {}
hook.Add( "OnPlayerChangedTeam", "job_giant", function( ply, oldTeam, newTeam )
	if newTeam==_G[job_giant.teamid] then
		job_giant.LastStep[ply]=0
	else
		job_giant.LastStep[ply]=nil
	end
end )

local SoundQueue = {}
local MoveButtons = bit.bor( IN_BACK, IN_FORWARD, IN_MOVELEFT, IN_MOVERIGHT )
local buttons
local stepinterval
hook.Add( "FinishMove", "job_giant", function( ply, mv )
	if job_giant.LastStep[ply] then
		buttons = mv:GetButtons()
		if bit.band( buttons, MoveButtons )==0 then
			return
		elseif bit.band( buttons, IN_DUCK )~=0 then
			return
		elseif ply:Health()<=0 then
			return
		elseif ply:GetMoveType()==MOVETYPE_NOCLIP then
			return
		else
			if bit.band( buttons, IN_SPEED )~=0 then
				stepinterval = job_giant.stepintervalrun
			elseif bit.band( buttons, IN_WALK )~=0 then
				stepinterval = job_giant.stepintervalwalk
			else
				stepinterval = job_giant.stepintervalnormal
			end
			if CurTime() > job_giant.LastStep[ply]+stepinterval then
				SoundQueue[ply]=true
			end
		end
	end
end )
util.AddNetworkString( job_giant.stepsound )
hook.Add( "Think", "job_giant", function( ply, mv )
	local CurrentSoundQueue = SoundQueue
	SoundQueue={}
	for ply in pairs( CurrentSoundQueue ) do
		job_giant.LastStep[ply] = CurTime()
		net.Start( job_giant.stepsound, true )
			net.WriteVector( ply:GetPos() )
		net.Broadcast()
	end
end )
hook.Add( "PlayerFootstep", "job_giant", function( ply )
	if job_giant.LastStep[ply] then
		return true
	end
end )

hook.Add( "PlayerDisconnected", "job_giant", function( ply )
	job_giant.LastStep[ply]=nil
	SoundQueue[ply]=nil
end )
