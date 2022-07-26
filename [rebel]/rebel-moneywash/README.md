Thank you for purchasing Rebel Moneywash!

Here are the instructions:

1. Insert the insert.sql in your database

-----------------------------------------------------------------------------------------------------

2. Go to qb-core/server/players.lua and add the following under this line "PlayerData.metadata = PlayerData.metadata or {}":

    PlayerData.metadata['moneywashrep'] = PlayerData.metadata['moneywashrep'] or 0

-----------------------------------------------------------------------------------------------------

3. Go to qb-core/shared/items.lua and add the following:

    ['wetbills'] 					 = {['name'] = 'wetbills', 			  	  		['label'] = 'Wet Bills', 				['weight'] = 1000, 		['type'] = 'item', 		['image'] = 'wetbills.png', 			['unique'] = true, 		['useable'] = false, 	['shouldClose'] = true,	   ['combinable'] = nil,   ['description'] = 'Money?'},

-----------------------------------------------------------------------------------------------------

4. Go to qb-inventory/html/js/app.js and add the following under the **FormatItemInfo Function**

    } else if (itemData.name == "wetbills") {
        $(".item-info-title").html("<p>" + itemData.label + "</p>");
        $(".item-info-description").html(
            "<p><strong>Worth: </strong><span>$" +
            itemData.info.worth +
            "</span></p>"
        );

-----------------------------------------------------------------------------------------------------
Lastly check out the config and change what you feel is neccesary. 

Now you are done! Enjoy the script and have fun. If you need any support please join our discord: https://discord.gg/YJ3YzNjWDy

Check out other scripts made by Rebel Scripts here: https://store.rebelscripts.net