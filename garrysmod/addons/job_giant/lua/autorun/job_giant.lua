-------------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------					Made by Murky					-----------------------------------------
-----------------------------				https://steamcommunity.com/id/murkytheone/					-----------------------------
-------------------------------------------------------------------------------------------------------------------------------------

job_giant = job_giant or {}

-- Configuration
job_giant.teamid = "TEAM_GIANT"
job_giant.stepintervalwalk = 0.65
job_giant.stepintervalnormal = 0.55
job_giant.stepintervalrun = 0.40
job_giant.stepsound = "GIANT.Footstep"
job_giant.stepsoundfiles = {
	-- "npc/antlion/foot1.wav",
	-- "npc/antlion/foot2.wav",
	-- "npc/antlion/foot3.wav",
	-- "npc/antlion/foot4.wav",
	"npc/strider/strider_step1.wav",
	"npc/strider/strider_step2.wav",
	"npc/strider/strider_step3.wav",
	"npc/strider/strider_step4.wav",
	"npc/strider/strider_step5.wav",
	"npc/strider/strider_step6.wav",
}
job_giant.stepsoundlevel = 120
job_giant.stepsoundvolume = 1

sound.Add( {
	name=job_giant.stepsound,
	sound=job_giant.stepsoundfiles,
	channel=CHAN_BODY,
	level=job_giant.stepsoundlevel,
	volume=job_giant.stepsoundvolume,
} )
util.PrecacheSound( job_giant.stepsound )



-- Exemple :
hook.Add( "loadCustomDarkRPItems", "job_giant", function()
	TEAM_GIANT = DarkRP.createJob( "Giant", {
		color = Color(80, 45, 0, 255),
		model = "models/player/Group01/male_04.mdl",
		description = [[Giant man]],
		weapons = {},
		command = "giant",
		max = 1,
		salary = 200,
		admin = 0,
		modelScale = 1,
		vote = false,
		hasLicense = false,
	} )
end )
