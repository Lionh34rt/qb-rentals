Made by Lionh34rt#4305
Discord: https://discord.gg/AWyTUEnGeN

# Description
**Simple vehicle rental spot with contextmenu and images** 

# Dependencies
* [QBCore Framework](https://github.com/qbcore-framework)
* [qb-target by BerkieBb](https://github.com/BerkieBb/qb-target)
* [nh-context by NeroHiro](https://github.com/nerohiro/nh-context)

# Installation
* **Add the item to your shared.lua**
* **Make changes to your inventory formatdate function in the UI**
* **Install nh-context by NeroHiro**

# Jobs for qb-core/shared.lua
```lua
["rentalpapers"]				 = {["name"] = "rentalpapers",           		["label"] = "Rental Documents",	 		["weight"] = 0, 		["type"] = "item", 		["image"] = "rentalpapers.png", 		["unique"] = true, 		["useable"] = true, 	["shouldClose"] = true,    ["combinable"] = nil,   ["description"] = "Proof that you rented this vehicle.."},
```

# qb-inventory/html/js/app.js at 'FormatItemInfo(itemData)'
```js
} else if (itemData.name == "rentalpapers") {
    $(".item-info-title").html('<p>'+itemData.label+'</p>')
    $(".item-info-description").html('<p>'+itemData.description+'</p><p>Name: '+itemData.info.name+'</p><p>Vehicle: '+itemData.info.veh+'</p><p>Plate: '+itemData.info.plate+'</p>');
```   

# Config for ms-peds
```
{
    model = `a_m_y_business_02`,
    coords = vector4(110.97, -1090.61, 29.3, 23.99),
    gender = 'male'
},
```