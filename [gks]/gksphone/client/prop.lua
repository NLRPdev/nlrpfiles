function changePhoneType(type)
	local phoneModel = "prop_phone_ing_03"
	if Config.PropActive then
		if type == "phone" then
			phoneModel = "patoche_props_phone2"
		elseif type == "pink_phone" then
			phoneModel = "patoche_props_phone3"
		elseif type == "gold_phone" then
			phoneModel = "patoche_props_phone1"
		end
	end
	return phoneModel
end
