local printTalentsMode = false

-- Slash command for printing talent tree with talent names and ID numbers
SLASH_CONROCPRINTTALENTS1 = "/ConROCPT"
SlashCmdList["CONROCPRINTTALENTS"] = function()
    printTalentsMode = not printTalentsMode
    ConROC:PopulateTalentIDs()
end

ConROC.Priest = {};

local ConROC_Priest, ids = ...;
local ConROC_Priest, optionMaxIds = ...;
local currentSpecName
local newTarget = true;
function ConROC:EnableDefenseModule()
	self.NextDef = ConROC.Priest.Defense;
end

function ConROC:UNIT_SPELLCAST_SUCCEEDED(event, unitID, lineID, spellID)
	if unitID == 'player' then
		self.lastSpellId = spellID;
	end
end

function ConROC:PopulateTalentIDs()
    local numTabs = GetNumTalentTabs()
    
    for tabIndex = 1, numTabs do
        local tabName = GetTalentTabInfo(tabIndex) .. "_Talent"
        tabName = string.gsub(tabName, "%s", "") -- Remove spaces from tab name
        if printTalentsMode then
        	print(tabName..": ")
        else
        	ids[tabName] = {}
    	end
        
        local numTalents = GetNumTalents(tabIndex)

        for talentIndex = 1, numTalents do
            local name, _, _, _, _ = GetTalentInfo(tabIndex, talentIndex)

            if name then
                local talentID = string.gsub(name, "%s", "") -- Remove spaces from talent name
                if printTalentsMode then
                	print(talentID .." = ID no: ", talentIndex)
                else
                	ids[tabName][talentID] = talentIndex
                end
            end
        end
    end
    if printTalentsMode then printTalentsMode = false end
end
ConROC:PopulateTalentIDs()

local Racial, Spec, Caster, Disc_Ability, Disc_Talent, Holy_Ability, Holy_Talent, Shad_Ability, Shad_Talent, Player_Buff, Player_Debuff, Target_Debuff = ids.Racial, ids.Spec, ids.Caster, ids.Disc_Ability, ids.Discipline_Talent, ids.Holy_Ability, ids.Holy_Talent, ids.Shad_Ability, ids.Shadow_Talent, ids.Player_Buff, ids.Player_Debuff, ids.Target_Debuff;

function ConROC:SpecUpdate()
	currentSpecName = ConROC:currentSpec()

	if currentSpecName then
	   ConROC:Print(self.Colors.Info .. "Current spec:", self.Colors.Success ..  currentSpecName)
	else
	   ConROC:Print(self.Colors.Error .. "You do not currently have a spec.")
	end
end
ConROC:SpecUpdate()
	
	--Discipline
	local _DispelMagic = Disc_Ability.DispelMagicRank1;
	local _DivineSpirit = Disc_Ability.DivineSpiritRank1;
	local _FearWard = Disc_Ability.FearWard; --new
	local _InnerFire = Disc_Ability.InnerFireRank1;
	local _InnerFocus = Disc_Ability.InnerFocus;
	local _Levitate = Disc_Ability.Levitate;
	local _ManaBurn = Disc_Ability.ManaBurn;
	local _MassDispel = Disc_Ability.MassDispel;
	local _PowerInfusion = Disc_Ability.PowerInfusion;
	local _PowerWordFortitude = Disc_Ability.PowerWordFortitudeRank1;
	local _PowerWordShield = Disc_Ability.PowerWordShieldRank1;
	local _PrayerofFortitude = Disc_Ability.PrayerofFortitudeRank1; --new
	local _PrayerofSpirit = Disc_Ability.PrayerofSpiritRank1;
	local _ShackleUndead = Disc_Ability.ShackleUndeadRank1;
	--Holy
	local _AbolishDisease = Holy_Ability.CureDisease;
	local _BindingHeal = Holy_Ability.BindingHealRank1; --new
	local _BlessedHealing = Holy_Ability.BlessedHealing; --new
	local _CureDisease = Holy_Ability.CureDisease;
	local _DivineHymn = Holy_Ability.DivineHymn;
	local _EmpoweredRenew = Holy_Ability.EmpoweredRenew;
	local _FlashHeal = Holy_Ability.FlashHealRank1;
	local _GreaterHeal = Holy_Ability.GreaterHealRank1;
	local _Heal = Holy_Ability.HealRank1;
	local _HolyFire = Holy_Ability.HolyFireRank1;
	local _HolyNova = Holy_Ability.HolyNovaRank1;
	local _HymnofHope = Holy_Ability.HymnofHope; --new
	local _LesserHeal = Holy_Ability.LesserHealRank1;
	local _Lightwell = Holy_Ability.LightwellRank1;
	local _PrayerofHealing = Holy_Ability.PrayerofHealingRank1;
	local _PrayerofMending = Holy_Ability.PrayerofMendingRank1;
	local _Renew = Holy_Ability.RenewRank1;
	local _Resurrection = Holy_Ability.ResurrectionRank1;
	local _Smite = Holy_Ability.SmiteRank1;
	--Shadow
	local _DevouringPlague = Shad_Ability.DevouringPlagueRank1;
	local _Fade = Shad_Ability.Fade;
	local _MindBlast = Shad_Ability.MindBlastRank1;
	local _MindControl = Shad_Ability.MindControl;
	local _MindFlay = Shad_Ability.MindFlayRank1;
	local _MindSear = Shad_Ability.MindSearRank1;
	local _MindSoothe = Shad_Ability.MindSoothe;
	local _MindVision = Shad_Ability.MindVisionRank1;
	local _PrayerofShadowProtection = Shad_Ability.PrayerofShadowProtectionRank1
	local _PsychicScream = Shad_Ability.PsychicScreamRank1;
	local _ShadowProtection = Shad_Ability.ShadowProtectionRank1;
	local _ShadowWordDeath = Shad_Ability.ShadowWordDeathRank1;
	local _ShadowWordPain = Shad_Ability.ShadowWordPainRank1;
	local _Shadowfiend = Shad_Ability.Shadowfiend;
	local _Shadowform = Shad_Ability.Shadowform;
	local _Silence = Shad_Ability.Silence;
	local _VampiricEmbrace = Shad_Ability.VampiricEmbrace;
	local _VampiricTouch = Shad_Ability.VampiricTouchRank1;
	local _ShadowWeaving = Player_Buff.ShadowWeavingRank1;

function ConROC:UpdateSpellID()	
--Ranks
	if IsSpellKnown(Disc_Ability.DispelMagicRank2) then _DispelMagic = Disc_Ability.DispelMagicRank2; end	
	
	if IsSpellKnown(Disc_Ability.DivineSpiritRank6) then _DivineSpirit = Disc_Ability.DivineSpiritRank6;
	elseif IsSpellKnown(Disc_Ability.DivineSpiritRank5) then _DivineSpirit = Disc_Ability.DivineSpiritRank5;
	elseif IsSpellKnown(Disc_Ability.DivineSpiritRank4) then _DivineSpirit = Disc_Ability.DivineSpiritRank4;
	elseif IsSpellKnown(Disc_Ability.DivineSpiritRank3) then _DivineSpirit = Disc_Ability.DivineSpiritRank3;	
	elseif IsSpellKnown(Disc_Ability.DivineSpiritRank2) then _DivineSpirit = Disc_Ability.DivineSpiritRank2; end

	if IsSpellKnown(Disc_Ability.InnerFireRank9) then _InnerFire = Disc_Ability.InnerFireRank9;
	elseif IsSpellKnown(Disc_Ability.InnerFireRank8) then _InnerFire = Disc_Ability.InnerFireRank8;
	elseif IsSpellKnown(Disc_Ability.InnerFireRank7) then _InnerFire = Disc_Ability.InnerFireRank7;
	elseif IsSpellKnown(Disc_Ability.InnerFireRank6) then _InnerFire = Disc_Ability.InnerFireRank6;
	elseif IsSpellKnown(Disc_Ability.InnerFireRank5) then _InnerFire = Disc_Ability.InnerFireRank5;
	elseif IsSpellKnown(Disc_Ability.InnerFireRank4) then _InnerFire = Disc_Ability.InnerFireRank4;
	elseif IsSpellKnown(Disc_Ability.InnerFireRank3) then _InnerFire = Disc_Ability.InnerFireRank3;	
	elseif IsSpellKnown(Disc_Ability.InnerFireRank2) then _InnerFire = Disc_Ability.InnerFireRank2; end	

	if IsSpellKnown(Disc_Ability.PowerWordFortitudeRank8) then _PowerWordFortitude = Disc_Ability.PowerWordFortitudeRank8;
	elseif IsSpellKnown(Disc_Ability.PowerWordFortitudeRank7) then _PowerWordFortitude = Disc_Ability.PowerWordFortitudeRank7;
	elseif IsSpellKnown(Disc_Ability.PowerWordFortitudeRank6) then _PowerWordFortitude = Disc_Ability.PowerWordFortitudeRank6;
	elseif IsSpellKnown(Disc_Ability.PowerWordFortitudeRank5) then _PowerWordFortitude = Disc_Ability.PowerWordFortitudeRank5;
	elseif IsSpellKnown(Disc_Ability.PowerWordFortitudeRank4) then _PowerWordFortitude = Disc_Ability.PowerWordFortitudeRank4;
	elseif IsSpellKnown(Disc_Ability.PowerWordFortitudeRank3) then _PowerWordFortitude = Disc_Ability.PowerWordFortitudeRank3;	
	elseif IsSpellKnown(Disc_Ability.PowerWordFortitudeRank2) then _PowerWordFortitude = Disc_Ability.PowerWordFortitudeRank2; end

	if IsSpellKnown(Disc_Ability.PowerWordShieldRank14) then _PowerWordShield = Disc_Ability.PowerWordShieldRank14;
	elseif IsSpellKnown(Disc_Ability.PowerWordShieldRank13) then _PowerWordShield = Disc_Ability.PowerWordShieldRank13;
	elseif IsSpellKnown(Disc_Ability.PowerWordShieldRank12) then _PowerWordShield = Disc_Ability.PowerWordShieldRank12;
	elseif IsSpellKnown(Disc_Ability.PowerWordShieldRank11) then _PowerWordShield = Disc_Ability.PowerWordShieldRank11;
	elseif IsSpellKnown(Disc_Ability.PowerWordShieldRank10) then _PowerWordShield = Disc_Ability.PowerWordShieldRank10;
	elseif IsSpellKnown(Disc_Ability.PowerWordShieldRank9) then _PowerWordShield = Disc_Ability.PowerWordShieldRank9;	
	elseif IsSpellKnown(Disc_Ability.PowerWordShieldRank8) then _PowerWordShield = Disc_Ability.PowerWordShieldRank8;
	elseif IsSpellKnown(Disc_Ability.PowerWordShieldRank7) then _PowerWordShield = Disc_Ability.PowerWordShieldRank7;
	elseif IsSpellKnown(Disc_Ability.PowerWordShieldRank6) then _PowerWordShield = Disc_Ability.PowerWordShieldRank6;
	elseif IsSpellKnown(Disc_Ability.PowerWordShieldRank5) then _PowerWordShield = Disc_Ability.PowerWordShieldRank5;
	elseif IsSpellKnown(Disc_Ability.PowerWordShieldRank4) then _PowerWordShield = Disc_Ability.PowerWordShieldRank4;
	elseif IsSpellKnown(Disc_Ability.PowerWordShieldRank3) then _PowerWordShield = Disc_Ability.PowerWordShieldRank3;	
	elseif IsSpellKnown(Disc_Ability.PowerWordShieldRank2) then _PowerWordShield = Disc_Ability.PowerWordShieldRank2; end

	--new
	if IsSpellKnown(Disc_Ability.PrayerofFortitudeRank4) then _PrayerofFortitude = Disc_Ability.PrayerofFortitudeRank4;
	elseif IsSpellKnown(Disc_Ability.PrayerofFortitudeRank3) then _PrayerofFortitude = Disc_Ability.PrayerofFortitudeRank3;	
	elseif IsSpellKnown(Disc_Ability.PrayerofFortitudeRank2) then _PrayerofFortitude = Disc_Ability.PrayerofFortitudeRank2; end

	--new
	if IsSpellKnown(Disc_Ability.PrayerofSpiritRank3) then _PrayerofSpirit = Disc_Ability.PrayerofSpiritRank3;	
	elseif IsSpellKnown(Disc_Ability.PrayerofSpiritRank2) then _PrayerofSpirit = Disc_Ability.PrayerofSpiritRank2; end

	if IsSpellKnown(Disc_Ability.ShackleUndeadRank3) then _ShackleUndead = Disc_Ability.ShackleUndeadRank3;	
	elseif IsSpellKnown(Disc_Ability.ShackleUndeadRank2) then _ShackleUndead = Disc_Ability.ShackleUndeadRank2; end
	
	if IsSpellKnown(Holy_Ability.AbolishDisease) then _AbolishDisease = Holy_Ability.AbolishDisease; end

	--new
	if IsSpellKnown(Holy_Ability.BindingHealRank3) then _BindingHeal = Holy_Ability.BindingHealRank3;
	elseif IsSpellKnown(Holy_Ability.BindingHealRank2) then _BindingHeal = Holy_Ability.BindingHealRank2; end	
	
	if IsSpellKnown(Holy_Ability.FlashHealRank11) then _FlashHeal = Holy_Ability.FlashHealRank11;
	elseif IsSpellKnown(Holy_Ability.FlashHealRank10) then _FlashHeal = Holy_Ability.FlashHealRank10;
	elseif IsSpellKnown(Holy_Ability.FlashHealRank9) then _FlashHeal = Holy_Ability.FlashHealRank9;
	elseif IsSpellKnown(Holy_Ability.FlashHealRank8) then _FlashHeal = Holy_Ability.FlashHealRank8;
	elseif IsSpellKnown(Holy_Ability.FlashHealRank7) then _FlashHeal = Holy_Ability.FlashHealRank7;
	elseif IsSpellKnown(Holy_Ability.FlashHealRank6) then _FlashHeal = Holy_Ability.FlashHealRank6;
	elseif IsSpellKnown(Holy_Ability.FlashHealRank5) then _FlashHeal = Holy_Ability.FlashHealRank5;
	elseif IsSpellKnown(Holy_Ability.FlashHealRank4) then _FlashHeal = Holy_Ability.FlashHealRank4;
	elseif IsSpellKnown(Holy_Ability.FlashHealRank3) then _FlashHeal = Holy_Ability.FlashHealRank3;	
	elseif IsSpellKnown(Holy_Ability.FlashHealRank2) then _FlashHeal = Holy_Ability.FlashHealRank2; end	
	
	if IsSpellKnown(Holy_Ability.GreaterHealRank9) then _GreaterHeal = Holy_Ability.GreaterHealRank9;
	elseif IsSpellKnown(Holy_Ability.GreaterHealRank8) then _GreaterHeal = Holy_Ability.GreaterHealRank8;
	elseif IsSpellKnown(Holy_Ability.GreaterHealRank7) then _GreaterHeal = Holy_Ability.GreaterHealRank7;
	elseif IsSpellKnown(Holy_Ability.GreaterHealRank6) then _GreaterHeal = Holy_Ability.GreaterHealRank6;
	elseif IsSpellKnown(Holy_Ability.GreaterHealRank5) then _GreaterHeal = Holy_Ability.GreaterHealRank5;
	elseif IsSpellKnown(Holy_Ability.GreaterHealRank4) then _GreaterHeal = Holy_Ability.GreaterHealRank4;
	elseif IsSpellKnown(Holy_Ability.GreaterHealRank3) then _GreaterHeal = Holy_Ability.GreaterHealRank3;	
	elseif IsSpellKnown(Holy_Ability.GreaterHealRank2) then _GreaterHeal = Holy_Ability.GreaterHealRank2; end
	
	if IsSpellKnown(Holy_Ability.HealRank4) then _Heal = Holy_Ability.HealRank4;
	elseif IsSpellKnown(Holy_Ability.HealRank3) then _Heal = Holy_Ability.HealRank3;	
	elseif IsSpellKnown(Holy_Ability.HealRank2) then _Heal = Holy_Ability.HealRank2; end

	if IsSpellKnown(Holy_Ability.LesserHealRank3) then _LesserHeal = Holy_Ability.LesserHealRank3;	
	elseif IsSpellKnown(Holy_Ability.LesserHealRank2) then _LesserHeal = Holy_Ability.LesserHealRank2; end
	
	if IsSpellKnown(Holy_Ability.HolyFireRank11) then _HolyFire = Holy_Ability.HolyFireRank11;
	elseif IsSpellKnown(Holy_Ability.HolyFireRank10) then _HolyFire = Holy_Ability.HolyFireRank10;
	elseif IsSpellKnown(Holy_Ability.HolyFireRank9) then _HolyFire = Holy_Ability.HolyFireRank9;
	elseif IsSpellKnown(Holy_Ability.HolyFireRank8) then _HolyFire = Holy_Ability.HolyFireRank8;
	elseif IsSpellKnown(Holy_Ability.HolyFireRank7) then _HolyFire = Holy_Ability.HolyFireRank7;
	elseif IsSpellKnown(Holy_Ability.HolyFireRank6) then _HolyFire = Holy_Ability.HolyFireRank6;
	elseif IsSpellKnown(Holy_Ability.HolyFireRank5) then _HolyFire = Holy_Ability.HolyFireRank5;
	elseif IsSpellKnown(Holy_Ability.HolyFireRank4) then _HolyFire = Holy_Ability.HolyFireRank4;
	elseif IsSpellKnown(Holy_Ability.HolyFireRank3) then _HolyFire = Holy_Ability.HolyFireRank3;
	elseif IsSpellKnown(Holy_Ability.HolyFireRank2) then _HolyFire = Holy_Ability.HolyFireRank2; end
	
	if IsSpellKnown(Holy_Ability.HolyNovaRank9) then _HolyNova = Holy_Ability.HolyNovaRank9;
	elseif IsSpellKnown(Holy_Ability.HolyNovaRank8) then _HolyNova = Holy_Ability.HolyNovaRank8;
	elseif IsSpellKnown(Holy_Ability.HolyNovaRank7) then _HolyNova = Holy_Ability.HolyNovaRank7;
	elseif IsSpellKnown(Holy_Ability.HolyNovaRank6) then _HolyNova = Holy_Ability.HolyNovaRank6;
	elseif IsSpellKnown(Holy_Ability.HolyNovaRank5) then _HolyNova = Holy_Ability.HolyNovaRank5;
	elseif IsSpellKnown(Holy_Ability.HolyNovaRank4) then _HolyNova = Holy_Ability.HolyNovaRank4;
	elseif IsSpellKnown(Holy_Ability.HolyNovaRank3) then _HolyNova = Holy_Ability.HolyNovaRank3;
	elseif IsSpellKnown(Holy_Ability.HolyNovaRank2) then _HolyNova = Holy_Ability.HolyNovaRank2; end
	
	if IsSpellKnown(Holy_Ability.LightwellRank6) then _Lightwell = Holy_Ability.LightwellRank6;	
	elseif IsSpellKnown(Holy_Ability.LightwellRank5) then _Lightwell = Holy_Ability.LightwellRank5;	
	elseif IsSpellKnown(Holy_Ability.LightwellRank4) then _Lightwell = Holy_Ability.LightwellRank4;	
	elseif IsSpellKnown(Holy_Ability.LightwellRank3) then _Lightwell = Holy_Ability.LightwellRank3;	
	elseif IsSpellKnown(Holy_Ability.LightwellRank2) then _Lightwell = Holy_Ability.LightwellRank2; end
	
	if IsSpellKnown(Holy_Ability.PrayerofHealingRank7) then _PrayerofHealing = Holy_Ability.PrayerofHealingRank7;
	elseif IsSpellKnown(Holy_Ability.PrayerofHealingRank6) then _PrayerofHealing = Holy_Ability.PrayerofHealingRank6;
	elseif IsSpellKnown(Holy_Ability.PrayerofHealingRank5) then _PrayerofHealing = Holy_Ability.PrayerofHealingRank5;
	elseif IsSpellKnown(Holy_Ability.PrayerofHealingRank4) then _PrayerofHealing = Holy_Ability.PrayerofHealingRank4;
	elseif IsSpellKnown(Holy_Ability.PrayerofHealingRank3) then _PrayerofHealing = Holy_Ability.PrayerofHealingRank3;
	elseif IsSpellKnown(Holy_Ability.PrayerofHealingRank2) then _PrayerofHealing = Holy_Ability.PrayerofHealingRank2; end
	
	--new
	if IsSpellKnown(Holy_Ability.PrayerofMendingRank3) then _PrayerofMending = Holy_Ability.PrayerofMendingRank3;
	elseif IsSpellKnown(Holy_Ability.PrayerofMendingRank2) then _PrayerofMending = Holy_Ability.PrayerofMendingRank2; end

	if IsSpellKnown(Holy_Ability.RenewRank14) then _Renew = Holy_Ability.RenewRank14;
	elseif IsSpellKnown(Holy_Ability.RenewRank13) then _Renew = Holy_Ability.RenewRank13;
	elseif IsSpellKnown(Holy_Ability.RenewRank12) then _Renew = Holy_Ability.RenewRank12;
	elseif IsSpellKnown(Holy_Ability.RenewRank11) then _Renew = Holy_Ability.RenewRank11;
	elseif IsSpellKnown(Holy_Ability.RenewRank10) then _Renew = Holy_Ability.RenewRank10;
	elseif IsSpellKnown(Holy_Ability.RenewRank9) then _Renew = Holy_Ability.RenewRank9;
	elseif IsSpellKnown(Holy_Ability.RenewRank8) then _Renew = Holy_Ability.RenewRank8;
	elseif IsSpellKnown(Holy_Ability.RenewRank7) then _Renew = Holy_Ability.RenewRank7;
	elseif IsSpellKnown(Holy_Ability.RenewRank6) then _Renew = Holy_Ability.RenewRank6;
	elseif IsSpellKnown(Holy_Ability.RenewRank5) then _Renew = Holy_Ability.RenewRank5;
	elseif IsSpellKnown(Holy_Ability.RenewRank4) then _Renew = Holy_Ability.RenewRank4;
	elseif IsSpellKnown(Holy_Ability.RenewRank3) then _Renew = Holy_Ability.RenewRank3;
	elseif IsSpellKnown(Holy_Ability.RenewRank2) then _Renew = Holy_Ability.RenewRank2; end
	
	if IsSpellKnown(Holy_Ability.ResurrectionRank7) then _Resurrection = Holy_Ability.ResurrectionRank7;
	elseif IsSpellKnown(Holy_Ability.ResurrectionRank6) then _Resurrection = Holy_Ability.ResurrectionRank6;
	elseif IsSpellKnown(Holy_Ability.ResurrectionRank5) then _Resurrection = Holy_Ability.ResurrectionRank5;
	elseif IsSpellKnown(Holy_Ability.ResurrectionRank4) then _Resurrection = Holy_Ability.ResurrectionRank4;
	elseif IsSpellKnown(Holy_Ability.ResurrectionRank3) then _Resurrection = Holy_Ability.ResurrectionRank3;
	elseif IsSpellKnown(Holy_Ability.ResurrectionRank2) then _Resurrection = Holy_Ability.ResurrectionRank2; end
	
	if IsSpellKnown(Holy_Ability.SmiteRank12) then _Smite = Holy_Ability.SmiteRank12;
	elseif IsSpellKnown(Holy_Ability.SmiteRank11) then _Smite = Holy_Ability.SmiteRank11;
	elseif IsSpellKnown(Holy_Ability.SmiteRank10) then _Smite = Holy_Ability.SmiteRank10;
	elseif IsSpellKnown(Holy_Ability.SmiteRank9) then _Smite = Holy_Ability.SmiteRank9;
	elseif IsSpellKnown(Holy_Ability.SmiteRank8) then _Smite = Holy_Ability.SmiteRank8;
	elseif IsSpellKnown(Holy_Ability.SmiteRank7) then _Smite = Holy_Ability.SmiteRank7;
	elseif IsSpellKnown(Holy_Ability.SmiteRank6) then _Smite = Holy_Ability.SmiteRank6;
	elseif IsSpellKnown(Holy_Ability.SmiteRank5) then _Smite = Holy_Ability.SmiteRank5;
	elseif IsSpellKnown(Holy_Ability.SmiteRank4) then _Smite = Holy_Ability.SmiteRank4;
	elseif IsSpellKnown(Holy_Ability.SmiteRank3) then _Smite = Holy_Ability.SmiteRank3;
	elseif IsSpellKnown(Holy_Ability.SmiteRank2) then _Smite = Holy_Ability.SmiteRank2; end

	if IsSpellKnown(Shad_Ability.DevouringPlagueRank9) then _DevouringPlague = Shad_Ability.DevouringPlagueRank9;
	elseif IsSpellKnown(Shad_Ability.DevouringPlagueRank8) then _DevouringPlague = Shad_Ability.DevouringPlagueRank8;
	elseif IsSpellKnown(Shad_Ability.DevouringPlagueRank7) then _DevouringPlague = Shad_Ability.DevouringPlagueRank7;
	elseif IsSpellKnown(Shad_Ability.DevouringPlagueRank6) then _DevouringPlague = Shad_Ability.DevouringPlagueRank6;
	elseif IsSpellKnown(Shad_Ability.DevouringPlagueRank5) then _DevouringPlague = Shad_Ability.DevouringPlagueRank5;
	elseif IsSpellKnown(Shad_Ability.DevouringPlagueRank4) then _DevouringPlague = Shad_Ability.DevouringPlagueRank4;
	elseif IsSpellKnown(Shad_Ability.DevouringPlagueRank3) then _DevouringPlague = Shad_Ability.DevouringPlagueRank3;
	elseif IsSpellKnown(Shad_Ability.DevouringPlagueRank2) then _DevouringPlague = Shad_Ability.DevouringPlagueRank2; end
	
	
	if IsSpellKnown(Shad_Ability.MindBlastRank13) then _MindBlast = Shad_Ability.MindBlastRank13;
	elseif IsSpellKnown(Shad_Ability.MindBlastRank12) then _MindBlast = Shad_Ability.MindBlastRank12;
	elseif IsSpellKnown(Shad_Ability.MindBlastRank11) then _MindBlast = Shad_Ability.MindBlastRank11;
	elseif IsSpellKnown(Shad_Ability.MindBlastRank10) then _MindBlast = Shad_Ability.MindBlastRank10;
	elseif IsSpellKnown(Shad_Ability.MindBlastRank9) then _MindBlast = Shad_Ability.MindBlastRank9;
	elseif IsSpellKnown(Shad_Ability.MindBlastRank8) then _MindBlast = Shad_Ability.MindBlastRank8;
	elseif IsSpellKnown(Shad_Ability.MindBlastRank7) then _MindBlast = Shad_Ability.MindBlastRank7;
	elseif IsSpellKnown(Shad_Ability.MindBlastRank6) then _MindBlast = Shad_Ability.MindBlastRank6;
	elseif IsSpellKnown(Shad_Ability.MindBlastRank5) then _MindBlast = Shad_Ability.MindBlastRank5;
	elseif IsSpellKnown(Shad_Ability.MindBlastRank4) then _MindBlast = Shad_Ability.MindBlastRank4;
	elseif IsSpellKnown(Shad_Ability.MindBlastRank3) then _MindBlast = Shad_Ability.MindBlastRank3;
	elseif IsSpellKnown(Shad_Ability.MindBlastRank2) then _MindBlast = Shad_Ability.MindBlastRank2; end
	
	if IsSpellKnown(Shad_Ability.MindFlayRank9) then _MindFlay = Shad_Ability.MindFlayRank9;
	elseif IsSpellKnown(Shad_Ability.MindFlayRank8) then _MindFlay = Shad_Ability.MindFlayRank8;
	elseif IsSpellKnown(Shad_Ability.MindFlayRank7) then _MindFlay = Shad_Ability.MindFlayRank7;
	elseif IsSpellKnown(Shad_Ability.MindFlayRank6) then _MindFlay = Shad_Ability.MindFlayRank6;
	elseif IsSpellKnown(Shad_Ability.MindFlayRank5) then _MindFlay = Shad_Ability.MindFlayRank5;
	elseif IsSpellKnown(Shad_Ability.MindFlayRank4) then _MindFlay = Shad_Ability.MindFlayRank4;
	elseif IsSpellKnown(Shad_Ability.MindFlayRank3) then _MindFlay = Shad_Ability.MindFlayRank3;
	elseif IsSpellKnown(Shad_Ability.MindFlayRank2) then _MindFlay = Shad_Ability.MindFlayRank2; end

	if IsSpellKnown(Shad_Ability.MindSearRank2) then _MindSear = Shad_Ability.MindSearRank2; end
	
	if IsSpellKnown(Shad_Ability.MindVisionRank2) then _MindVision = Shad_Ability.MindVisionRank2; end

	if IsSpellKnown(Shad_Ability.PrayerofShadowProtectionRank3) then _PrayerofShadowProtection = Shad_Ability.PrayerofShadowProtectionRank3;
	elseif IsSpellKnown(Shad_Ability.PrayerofShadowProtectionRank2) then _PrayerofShadowProtection = Shad_Ability.PrayerofShadowProtectionRank2; end
	
	if IsSpellKnown(Shad_Ability.PsychicScreamRank4) then _PsychicScream  = Shad_Ability.PsychicScreamRank4;
	elseif IsSpellKnown(Shad_Ability.PsychicScreamRank3) then _PsychicScream  = Shad_Ability.PsychicScreamRank3;
	elseif IsSpellKnown(Shad_Ability.PsychicScreamRank2) then _PsychicScream  = Shad_Ability.PsychicScreamRank2; end

	if IsSpellKnown(Shad_Ability.ShadowProtectionRank5) then _ShadowProtection = Shad_Ability.ShadowProtectionRank5;
	elseif IsSpellKnown(Shad_Ability.ShadowProtectionRank4) then _ShadowProtection = Shad_Ability.ShadowProtectionRank4;
	elseif IsSpellKnown(Shad_Ability.ShadowProtectionRank3) then _ShadowProtection = Shad_Ability.ShadowProtectionRank3;
	elseif IsSpellKnown(Shad_Ability.ShadowProtectionRank2) then _ShadowProtection = Shad_Ability.ShadowProtectionRank2; end

	if IsSpellKnown(Shad_Ability.ShadowWordDeathRank4) then _ShadowWordDeath = Shad_Ability.ShadowWordDeathRank4;
	elseif IsSpellKnown(Shad_Ability.ShadowWordDeathRank3) then _ShadowWordDeath = Shad_Ability.ShadowWordDeathRank3;
	elseif IsSpellKnown(Shad_Ability.ShadowWordDeathRank2) then _ShadowWordDeath = Shad_Ability.ShadowWordDeathRank2; end
	
	if IsSpellKnown(Shad_Ability.ShadowWordPainRank12) then _ShadowWordPain = Shad_Ability.ShadowWordPainRank12;
	elseif IsSpellKnown(Shad_Ability.ShadowWordPainRank11) then _ShadowWordPain = Shad_Ability.ShadowWordPainRank11;
	elseif IsSpellKnown(Shad_Ability.ShadowWordPainRank10) then _ShadowWordPain = Shad_Ability.ShadowWordPainRank10;
	elseif IsSpellKnown(Shad_Ability.ShadowWordPainRank9) then _ShadowWordPain = Shad_Ability.ShadowWordPainRank9;
	elseif IsSpellKnown(Shad_Ability.ShadowWordPainRank8) then _ShadowWordPain = Shad_Ability.ShadowWordPainRank8;
	elseif IsSpellKnown(Shad_Ability.ShadowWordPainRank7) then _ShadowWordPain = Shad_Ability.ShadowWordPainRank7;
	elseif IsSpellKnown(Shad_Ability.ShadowWordPainRank6) then _ShadowWordPain = Shad_Ability.ShadowWordPainRank6;
	elseif IsSpellKnown(Shad_Ability.ShadowWordPainRank5) then _ShadowWordPain = Shad_Ability.ShadowWordPainRank5;
	elseif IsSpellKnown(Shad_Ability.ShadowWordPainRank4) then _ShadowWordPain = Shad_Ability.ShadowWordPainRank4;
	elseif IsSpellKnown(Shad_Ability.ShadowWordPainRank3) then _ShadowWordPain = Shad_Ability.ShadowWordPainRank3;
	elseif IsSpellKnown(Shad_Ability.ShadowWordPainRank2) then _ShadowWordPain = Shad_Ability.ShadowWordPainRank2; end

	if IsSpellKnown(Player_Buff.ShadowWeavingRank3) then _ShadowWeaving = Player_Buff.ShadowWeavingRank3;	
	elseif IsSpellKnown(Player_Buff.ShadowWeavingRank2) then _ShadowWeaving = Player_Buff.ShadowWeavingRank2; end
	
	if IsSpellKnown(Shad_Ability.VampiricTouchRank5) then _VampiricTouch = Shad_Ability.VampiricTouchRank5;
	elseif IsSpellKnown(Shad_Ability.VampiricTouchRank4) then _VampiricTouch = Shad_Ability.VampiricTouchRank4;
	elseif IsSpellKnown(Shad_Ability.VampiricTouchRank3) then _VampiricTouch = Shad_Ability.VampiricTouchRank3;
	elseif IsSpellKnown(Shad_Ability.VampiricTouchRank2) then _VampiricTouch = Shad_Ability.VampiricTouchRank2; end

--OptionIDs
	ids.optionMaxIds = {
	--Discipline
	DispelMagic = _DispelMagic,
	DivineSpirit = _DivineSpirit,
	FearWard = _FearWard,
	InnerFire = _InnerFire,
	InnerFocus = _InnerFocus,
	Levitate = _Levitate,
	ManaBurn = _ManaBurn,
	MassDispel = _MassDispel,
	PowerInfusion = _PowerInfusion,
	PowerWordFortitude = _PowerWordFortitude,
	PowerWordShield = _PowerWordShield,
	PrayerofFortitude = _PrayerofFortitude,
	PrayerofSpirit = _PrayerofSpirit,
	ShackleUndead = _ShackleUndead,
	--Holy
	AbolishDisease = _AbolishDisease,
	BindingHeal = _BindingHeal,
	BlessedHealing = _BlessedHealing,
	CureDisease = _CureDisease,
	DivineHymn = _DivineHymn,
	EmpoweredRenew = _EmpoweredRenew,
	FlashHeal = _FlashHeal,
	GreaterHeal = _GreaterHeal,
	Heal = _Heal,
	HolyFire = _HolyFire,
	HolyNova = _HolyNova,
	HymnofHope = _HymnofHope,
	LesserHeal = _LesserHeal,
	Lightwell = _Lightwell,
	PrayerofHealing = _PrayerofHealing,
	PrayerofMending = _PrayerofMending,
	Renew = _Renew,
	Resurrection = _Resurrection,
	Smite = _Smite,
	--Shadow
	DevouringPlague = _DevouringPlague,
	Fade = _Fade,
	MindBlast = _MindBlast,
	MindControl = _MindControl,
	MindFlay = _MindFlay,
	MindSear = _MindSear,
	MindSoothe = _MindSoothe,
	MindVision = _MindVision,
	PrayerofShadowProtection = _PrayerofShadowProtection,
	PsychicScream = _PsychicScream,
	ShadowProtection = _ShadowProtection,
	ShadowWordDeath = _ShadowWordDeath,
	ShadowWordPain = _ShadowWordPain,
	Shadowfiend = _Shadowfiend,
	Shadowform = _Shadowform,
	Silence = _Silence,
	VampiricEmbrace = _VampiricEmbrace,
	VampiricTouch = _VampiricTouch,
	ShadowWeaving = _ShadowWeaving,
	}
end
ConROC:UpdateSpellID()

function ConROC:EnableRotationModule()
	self.Description = "Priest";
	self.NextSpell = ConROC.Priest.Damage;

	self:RegisterEvent('PLAYER_TARGET_CHANGED');
	self:RegisterEvent('UNIT_SPELLCAST_SUCCEEDED');
	self:RegisterEvent("PLAYER_TALENT_UPDATE");
	self.lastSpellId = 0;
	
	ConROC:SpellmenuClass();
end
function ConROC:PLAYER_TARGET_CHANGED()
	newTarget = true;
end
function ConROC:PLAYER_TALENT_UPDATE()
	ConROC:SpecUpdate();
    ConROC:closeSpellmenu();
end

function ConROC.Priest.Damage(_, timeShift, currentSpell, gcd)
ConROC:UpdateSpellID()
--Character
	local plvl		= UnitLevel('player');
	
--Racials

--Resources
	local mana		= UnitPower('player', Enum.PowerType.Mana);
	local manaMax		= UnitPowerMax('player', Enum.PowerType.Mana);
	local manaPercent	= math.max(0, mana) / math.max(1, manaMax) * 100;
	
--Abilities		
	local iFocusRDY			= ConROC:AbilityReady(_InnerFocus, timeShift);	
	local leviRDY			= ConROC:AbilityReady(_Levitate, timeShift);	
	local mDispelRDY		= ConROC:AbilityReady(_MassDispel, timeShift); --new
	local mBurnRDY			= ConROC:AbilityReady(_ManaBurn, timeShift);	
	local pInfusRDY			= ConROC:AbilityReady(_PowerInfusion, timeShift);
	local sUndeadRDY		= ConROC:AbilityReady(_ShackleUndead, timeShift);
		local sUndeadDEBUFF	= ConROC:TargetDebuff(_ShackleUndead, timeShift);
		
	local fHealRDY			= ConROC:AbilityReady(_FlashHeal, timeShift);
	local lHealRDY			= ConROC:AbilityReady(_LesserHeal, timeShift);
	local healRDY			= ConROC:AbilityReady(_Heal, timeShift);
	local gHealRDY			= ConROC:AbilityReady(_GreaterHeal, timeShift);
	local hFireRDY			= ConROC:AbilityReady(_HolyFire, timeShift);		
		local hFireDebuff	= ConROC:TargetDebuff(_HolyFire, timeShift);	
	local hNovaRDY			= ConROC:AbilityReady(_HolyNova, timeShift);			
	local lWellRDY			= ConROC:AbilityReady(_Lightwell, timeShift);		
	local pofHealRDY		= ConROC:AbilityReady(_PrayerofHealing, timeShift);
	local renewRDY			= ConROC:AbilityReady(_Renew, timeShift);
		local renewBUFF		= ConROC:UnitAura(_Renew, timeShift, 'target', 'HELPFUL');
	local resRDY			= ConROC:AbilityReady(_Resurrection, timeShift);		
	local smiteRDY			= ConROC:AbilityReady(_Smite, timeShift);

	local mBlastRDY			= ConROC:AbilityReady(_MindBlast, timeShift);
	local dPlagueRDY		= ConROC:AbilityReady(_DevouringPlague, timeShift);
		local dPlagueDEBUFF	= ConROC:TargetDebuff(_DevouringPlague, timeShift);
	local mControlRDY		= ConROC:AbilityReady(_MindControl, timeShift);
	local mFlayRDY			= ConROC:AbilityReady(_MindFlay, timeShift);
	local mSearRDY			= ConROC:AbilityReady(_MindSear, timeShift);
	local mSootheRDY		= ConROC:AbilityReady(_MindSoothe, timeShift);
	local mVisionRDY		= ConROC:AbilityReady(_MindVision, timeShift);
	local swpRDY			= ConROC:AbilityReady(_ShadowWordPain, timeShift);
		local swpDebuff		= ConROC:TargetDebuff(_ShadowWordPain, timeShift);
	local sFormRDY			= ConROC:AbilityReady(_Shadowform, timeShift);
		local sFormBUFF		= ConROC:Form(_Shadowform);
	local silRDY			= ConROC:AbilityReady(_Silence, timeShift);
	local vEmbraceRDY		= ConROC:AbilityReady(_VampiricEmbrace, timeShift);
		local vEmbraceBuff	= ConROC:Buff(_VampiricEmbrace, timeShift);
	local vTouchRDY			= ConROC:AbilityReady(_VampiricTouch, timeShift);
		local vTouchDebuff	= ConROC:TargetDebuff(_VampiricTouch, timeShift);

	local sWeavingBUFF, sWeavingCount	= ConROC:Buff(_ShadowWeaving, timeShift);
	
--Conditions	
	local isEnemy			= ConROC:TarHostile();
	local targetPh			= ConROC:PercentHealth('target');	
	local moving			= ConROC:PlayerSpeed();
	local incombat			= UnitAffectingCombat('player');	
	local Close				= CheckInteractDistance("target", 3);
	local hasWand			= HasWandEquipped();
	
--Indicators
	ConROC:AbilityRaidBuffs(_PowerWordFortitude, ConROC:CheckBox(ConROC_SM_Buff_PowerWordFortitude) and pwfRDY and not pwfBUFF);
	ConROC:AbilityRaidBuffs(_DivineSpirit, ConROC:CheckBox(ConROC_SM_Buff_DivineSpirit) and dSpiritRDY and not dSpiritBUFF);
	
	ConROC:AbilityBurst(_InnerFocus, iFocusRDY and mBlastRDY and isEnemy);
--Warnings	


--Rotations
	if plvl < 10 then

		if smiteRDY and ((ConROC.lastSpellId ~= _Smite or not incombat) or (incombat and swpDebuff)) then
			return _Smite;
		end

		if ConROC:CheckBox(ConROC_SM_Debuff_ShadowWordPain) and swpRDY and not swpDebuff then
			return _ShadowWordPain;
		end
		if smiteRDY then
			return _Smite;
		end
	end
	if sFormRDY and not sFormBUFF then
		return _Shadowform;
	end
	
	if isEnemy and sFormBUFF then
		if vTouchRDY and not vTouchDebuff then
			return _VampiricTouch
		end
		if dPlagueRDY and not dPlagueDEBUFF then
			return _DevouringPlague;
		end
		if mBlastRDY and currentSpell ~= _MindBlast and sWeavingCount < 5 then
			return _MindBlast;
		end
		if mFlayRDY and currentSpell ~= _MindFlay and sWeavingCount < 5 then
			return _MindFlay;
		end
		if ConROC:CheckBox(ConROC_SM_Debuff_ShadowWordPain) and swpRDY and not swpDebuff then
			return _ShadowWordPain;
		end

		if ConROC:CheckBox(ConROC_SM_Debuff_VampiricEmbrace) and vEmbraceRDY and not vEmbraceBuff then
			return _VampiricEmbrace;
		end

		if ConROC:CheckBox(ConROC_SM_Option_UseWand) and hasWand and (manaPercent <= 20 or targetPh <= 5) then
			return Caster.Shoot;
		end

		if mBlastRDY and currentSpell ~= _MindBlast then
			return _MindBlast;
		end
		if ConROC_AoEButton:IsVisible() and ConROC:CheckBox(ConROC_SM_Debuff_MindFlay) and mSearRDY then
			return _MindSear;
		end
		if ConROC:CheckBox(ConROC_SM_Debuff_MindFlay) and mFlayRDY then
			return _MindFlay;
		end
	end
	
	if isEnemy and not sFormBUFF then
		if not incombat then
			if mBlastRDY and currentSpell ~= _MindBlast then
				return _MindBlast;
			elseif ConROC:CheckBox(ConROC_SM_Debuff_HolyFire) and hFireRDY and not hFireDebuff and currentSpell ~= _HolyFire then
				return _HolyFire;
			elseif smiteRDY and currentSpell ~= _Smite then
				return _Smite;
			end
		end

		if ConROC:CheckBox(ConROC_SM_Debuff_VampiricEmbrace) and vEmbraceRDY and not vEmbraceDebuff then
			return _VampiricEmbrace;
		end
		
		if ConROC:CheckBox(ConROC_SM_Debuff_HolyFire) and hFireRDY and not hFireDebuff and currentSpell ~= _HolyFire then
			return _HolyFire;
		end

		if dPlagueRDY and not dPlagueDEBUFF then
			return _DevouringPlague;
		end

		if ConROC:CheckBox(ConROC_SM_Debuff_ShadowWordPain) and swpRDY and not swpDebuff then
			return _ShadowWordPain;
		end

		if ConROC:CheckBox(ConROC_SM_Option_UseWand) and hasWand and (manaPercent <= 20 or targetPh <= 5) then
			return Caster.Shoot;
		end

		if mBlastRDY and currentSpell ~= _MindBlast then
			return _MindBlast;
		end

		if ConROC:CheckBox(ConROC_SM_Debuff_MindFlay) and mFlayRDY then
			return _MindFlay;
		end	
		
		if smiteRDY then
			return _Smite;
		end
	end
	
	return nil;
end

function ConROC.Priest.Defense(_, timeShift, currentSpell, gcd)
--Character
	local plvl			= UnitLevel('player');
	
--Racials

--Resources
	local mana			= UnitPower('player', Enum.PowerType.Mana);
	local manaMax			= UnitPowerMax('player', Enum.PowerType.Mana);
	
--Abilities
	local dSpiritRDY		= ConROC:AbilityReady(_DivineSpirit, timeShift);
		local dSpiritBUFF	= ConROC:Buff(_DivineSpirit, timeShift);	
	local dMagicRDY			= ConROC:AbilityReady(_DispelMagic, timeShift);
	local iFireRDY			= ConROC:AbilityReady(_InnerFire, timeShift);
		local iFireBUFF		= ConROC:Buff(_InnerFire, timeShift);
	local pofsRDY			= ConROC:AbilityReady(_PrayerofSpirit, timeShift);	
		local pofsBUFF		= ConROC:Buff(_PrayerofSpirit, timeShift);	
	local pwfRDY			= ConROC:AbilityReady(_PowerWordFortitude, timeShift);	
		local pwfBUFF		= ConROC:Buff(_PowerWordFortitude, timeShift);
	local poffRDY			= ConROC:AbilityReady(_PrayerofFortitude, timeShift);	--new	
		local poffBUFF		= ConROC:Buff(_PrayerofFortitude, timeShift);	--new
	local pwsRDY			= ConROC:AbilityReady(_PowerWordShield, timeShift);
		local pwsBUFF		= ConROC:Buff(_PowerWordShield, timeShift);
		local wsDebuff		= ConROC:UnitAura(Player_Debuff.WeakendSoul, timeShift, 'player', 'HARMFUL');
		
	local aDiseaseRDY		= ConROC:AbilityReady(_AbolishDisease, timeShift);
	
	local fadeRDY			= ConROC:AbilityReady(_Fade, timeShift);		
	local psyScRDY			= ConROC:AbilityReady(_PsychicScream, timeShift);		
	local sProtRDY			= ConROC:AbilityReady(_ShadowProtection, timeShift);
		local sProtBUFF		= ConROC:Buff(_ShadowProtection, timeShift);		
	local pofsProtRDY			= ConROC:AbilityReady(_PrayerofShadowProtection, timeShift);
		local pofsProtBUFF		= ConROC:Buff(_PrayerofShadowProtection, timeShift);
	
	
--Conditions	
	local isEnemy			= ConROC:TarHostile();
	local playerPh			= ConROC:PercentHealth('player');
	local targetPh			= ConROC:PercentHealth('target');
	
--Rotations
	if dSpiritRDY and not (pofsBUFF or dSpiritBUFF) and UnitAffectingCombat("player") then
		return _DivineSpirit;
	end
	if pofsRDY and not (pofsBUFF or dSpiritBUFF) and UnitInParty("player") then
		return _PrayerofSpirit;
	end

	if pwfRDY and not (poffBUFF or pwfBUFF) and UnitAffectingCombat("player") then
		return _PowerWordFortitude;
	end
	if poffsRDY and not (poffBUFF or pwfBUFF) and UnitInParty("player") then
		return _PrayerofFortitude;
	end

	if iFireRDY and not iFireBUFF then
		return _InnerFire;
	end
	
	if ConROC:CheckBox(ConROC_SM_Buff_ShadowProtection) and sProtRDY and not (sProtBUFF or pofsProtBUFF) then
		return _ShadowProtection;
	end

	if ConROC:CheckBox(ConROC_SM_Buff_ShadowProtection) and pofsProtRDY and not (sProtBUFF or pofsProtBUFF) and UnitInParty("player") then
		return _PrayerofShadowProtection;
	end	
		
	if pwsRDY and not pwsBUFF and not wsDebuff then
		return _PowerWordShield;
	end

	return nil;
end