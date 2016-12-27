
require( GetScriptDirectory().."/ability_item_usage_generic" )

----------------------------------------------------------------------------------------------------

castSR3Desire =0;

function CourierUsageThink()

	--print( "SF.AbilityUsageThink" );

	--ability_item_usage_generic.CourierUsageThink();
	local npcBot = GetBot();
    for i = 9, 15, 1 do
        local item = npcBot:GetItemInSlot(i);
        if((item ~= nil or npcBot:GetCourierValue() > 500) and IsCourierAvailable()) then
            --print("got item");
            npcBot:Action_CourierDeliver();
            return;
        end
    end

end

----------------------------------------------------------------------------------------------------

function AbilityUsageThink()

	local npcBot = GetBot();

	-- Check if we're already using an ability
	if ( npcBot:IsUsingAbility() ) then return end;
	
	abilitySR3 = npcBot:GetAbilityByName( "nevermore_shadowraze3" );
	castSR3Desire, castSR3Location = ConsiderShadowRaze3();
	print("castSR3Desire=" .. castSR3Desire);
	if(castSR3Desire > 0)
	then
		npcBot:Action_Chat( "Using Raze #3 because someone asked me to.", true );
		npcBot:Action_UseAbilityOnEntity( abilitySR3, castSR3Location );
		return;
	end

end

----------------------------------------------------------------------------------------------------

function ConsiderShadowRaze3()


	local npcBot = GetBot();
			
	print(npcBot:GetActiveMode())
	
	-- Make sure it's castable
	if ( not abilitySR3:IsFullyCastable() ) then 
	print("test none")
		return BOT_ACTION_DESIRE_NONE, 0;
	end;

	-- Get some of its values
	local nRadius = abilitySR3:GetSpecialValueInt( "shadowraze_radius" );
	local nCastRange = abilitySR3:GetCastRange();
	local nDamage = abilitySR3:GetAbilityDamage();
	
	-- If we're farming and can kill 1+ creeps with SR3
	if ( npcBot:GetActiveMode() == BOT_MODE_FARM ) then
		print("farm mode");
		local locationAoE = npcBot:FindAoELocation( true, false, npcBot:GetLocation(), nCastRange, nRadius, 0, nDamage );

		if ( locationAoE.count >= 2 ) then
			print("success");
			return BOT_ACTION_DESIRE_LOW, locationAoE.targetloc;
		end
	end
	
	return BOT_ACTION_DESIRE_NONE, 0;
end