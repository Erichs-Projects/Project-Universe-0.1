class_name TalentMods
extends Resource


enum talentMod { name,
	healthMod, stressTest, Might, soak,
	Cog, Imp, Morl, Corp, AG, FO, TE, SC,
	IN, MA, PE , energyW, physicalW, magicW,
	energyS, physicalS, magicS, Dodge, DefenseVal
	}


var Talent_Modifier = {
	talentMod.name: "",
	talentMod.healthMod: 0, talentMod.stressTest: 0, talentMod.Might: 0, talentMod.soak: 0,
	talentMod.Cog: 0, talentMod.Imp: 0, talentMod.Morl: 0, talentMod.Corp: 0,
	talentMod.AG: 0, talentMod.FO: 0, talentMod.TE: 0, talentMod.SC: 0, talentMod.IN: 0,
	talentMod.MA: 0, talentMod.PE: 0, talentMod.energyW: 0, talentMod.physicalW: 0,
	talentMod.magicW: 0, talentMod.energyS: 0, talentMod.physicalS: 0, talentMod.magicS: 0,
	talentMod.Dodge: 0, talentMod.DefenseVal: 0
}
	
func _init(name: String, healthM: int, stress: int, Mi: int, so: int, C: int, Im: int, Mo: int, Co: int, AG: int, FO: int, TE: int, SC: int, IN: int, MA: int, PE: int , energyW: int, physicalW: int, magicW: int, energyS: int, physicalS: int, magicS: int, dodge: int, defVal):
	Talent_Modifier[talentMod.name] = name
	Talent_Modifier[talentMod.healthMod] = healthM
	Talent_Modifier[talentMod.stressTest] = stress
	Talent_Modifier[talentMod.Might] = Mi 
	Talent_Modifier[talentMod.soak] = so
	Talent_Modifier[talentMod.Cog] = C
	Talent_Modifier[talentMod.Imp ] = Im
	Talent_Modifier[talentMod.Morl] = Mo
	Talent_Modifier[talentMod.Corp] = Co
	Talent_Modifier[talentMod.AG] = AG
	Talent_Modifier[talentMod.FO] = FO
	Talent_Modifier[talentMod.TE] = TE
	Talent_Modifier[talentMod.SC] = SC
	Talent_Modifier[talentMod.IN] = IN
	Talent_Modifier[talentMod.MA] = MA
	Talent_Modifier[talentMod.PE] = PE
	Talent_Modifier[talentMod.energyW] = energyW
	Talent_Modifier[talentMod.physicalW] = physicalW
	Talent_Modifier[talentMod.magicW] = magicW
	Talent_Modifier[talentMod.energyS] = energyS
	Talent_Modifier[talentMod.physicalS] = physicalS
	Talent_Modifier[talentMod.magicS] = magicS
	Talent_Modifier[talentMod.Dodge] = dodge
	Talent_Modifier[talentMod.DefenseVal] = defVal

	
#
#enum Adpt_Talent {AW, CE}
#enum ATK_Talent {AgS, ArtS, FS, MS, PS}
#enum Bal_Talent {BW, BD, BM, JAS, LB, PoZW, VoDT}
#enum Blaster_Talent {CRS, FS, PBS, ArtilS, BlasterM}
#enum Cond_Talent { CT, PT, BDT}
#enum Counter_Talent {WC, FC, PC, JC, FullC}
#enum DG_Talent {DS, CunE, InE, MastE, FFS}
#enum Dura_Talent {EffD, Res, TouW, SupD}
#enum Grap_Talent {Br, Wres, JudoT, Heel, Supl, HumSh, PersS}
#enum Init_Talent { Alert, ImIn, LI, PaF}
#enum Mag_Talent {MagW, MagBlas, MagM}
#enum Mind_Talent { SerW, CombM, TranC, ClearM, CombZ}
#enum Min_Talent {MoM, MinC, AscM, MinMar, SacM}
#enum Mobi_Talent { FW, HPA, PoM, FoF}
#enum MultiTy_Talent {MT_A, MT_G, MT_M}
#enum Phys_Talent {I_F, R_F, P_F, S_F}
#enum Racial_Talent{M_I, C_M, N_P, D_S, T_P, A_T_V, B_G, M_Maj, S_T_R, Tuf_P }
#enum Ragin_Talent {Fre, B_A, B_R}
#enum Skill_Talent {Pract, DYN_P, Pos_M, Team_P, An_F, Comp_An, Ge_D, C_J_R, Sil_Fo, Ste_Str, Assas, Mast_Assa, Acr_S, Exp_Pio, Yoi, BatDr, RefSen, Mas_Tam, Terr_P, Des_Dis, LasDEff}
#enum Special_Talent {Arch_F, Perc_Kata, Burt_Kat, Prof_Foc}
#enum Starter_Talent {Slow_S, Warm_Up, Res_Comb, Jump_S}
#enum S_Stack_Talent {Musc_W, Hef_M, Ste_M, Herc_P}
#enum Surge_Talent {Sec_Win, Nev_Sur, Lion_H, Light_S}
#enum Taunt_Talent {Ment_W, Taunt, Imp_Tau}
#enum TWork_Talent {Flex_F, Sup_D, Oppor, Tea_Wor, Synch_Comb, Sup_Synch}
#enum Tech_Talent {Eng_Cont, Tech_M, Fav_Tec, Flex_Tec, Pwr_Tech, Uniq_T, Terrf_T, Qui_L, Perf_Mim, Cop_Ind, Adv_Le  }
#enum Thresh_Talent { Vig, DieH, Forti, Undy_Det}
#enum Transf_Talent {Blind_T, Des_T, Enh_T, Forc_Tra, Under_P, Spec_Tra, Comf_Tr, Insp_Tr, Overw_Tr, Tr_Ini, Restr_Tr, }
#enum Weapon_Talent {Weap_S, Cate_Sp, Duel_Spe, L_We_Sp, Heav_W_Spec, Iaij_Speci, Du_W_Sp, Criti_Sp, Vari_Spec, Improv_Spec, Weap_Fix, Weap_M, Vari_Fig, Var_Champ}
#enum Misc_Talent {App_o_Sk, Conce_Eng, Furi_Fle, Luc, Natur, Snac_Fi, Drunk_F, Freq_Fly, Swag_Wag, Willpo}
