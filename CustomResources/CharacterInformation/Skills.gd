class_name Skill
extends Resource
enum stats {AG, FO, TE, SC, IN, MA, PE}
var Player_Sheet: CharacterAttributes
# skill list
enum skill {
	acro, bluf, clai, conc, craf, crea,
	inti, inve, know, medi, perc, perf, 
	pers, pilo, stea, surv, thie, useM
	 }
	
#Skill Rank Stats
var SkillRanks ={
	skill.acro : 0, skill.bluf : 0, skill.clai : 0, skill.conc : 0, skill.craf : 0, skill.crea : 0,
	skill.inti : 0, skill.inve : 0, skill.know : 0, skill.medi : 0, skill.perc : 0, skill.perf : 0,
	skill.pers : 0, skill.pilo : 0, skill.stea : 0, skill.surv : 0, skill.thie : 0, skill.useM : 0,
}

func update_skill(Player_Skill, skillProgress):
		SkillRanks[Player_Skill] = skillProgress

func get_skillTotal(skill_, stat)-> int:
	return SkillRanks[skill_]*2+floor(Player_Sheet.get_score(stat)/2)
