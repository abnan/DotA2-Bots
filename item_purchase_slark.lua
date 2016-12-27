

local tableItemsToBuy = {
				"item_stout_shield",
				"item_tango",
				"item_flask",
				"item_branches",
				"item_slippers", 
				"item_circlet",
				"item_recipe_wraith_band",
				"item_ring_of_protection",
				"item_sobi_mask",
				"item_boots",
				"item_infused_raindrop",
				"item_claymore",
				"item_shadow_amulet",
			};


----------------------------------------------------------------------------------------------------

function ItemPurchaseThink()

	local npcBot = GetBot();

	if ( #tableItemsToBuy == 0 )
	then
		npcBot:SetNextItemPurchaseValue( 0 );
		return;
	end

	local sNextItem = tableItemsToBuy[1];

	npcBot:SetNextItemPurchaseValue( GetItemCost( sNextItem ) );

	if ( npcBot:GetGold() >= GetItemCost( sNextItem ) )
	then
		npcBot:Action_PurchaseItem( sNextItem );
		npcBot:Action_Chat( "I just bought " .. sNextItem .. " because someone asked me to.", true );
		table.remove( tableItemsToBuy, 1 );
	end

end

----------------------------------------------------------------------------------------------------
