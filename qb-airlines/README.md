Made by Lionh34rt#4305
Discord: https://discord.gg/AWyTUEnGeN
Tebex: https://lionh34rt.tebex.io/

# Description
**AAAA** 

# Dependencies
* [QBCore Framework](https://github.com/qbcore-framework)
* [qb-target by BerkieBb](https://github.com/BerkieBb/qb-target)
* [nh-context by NeroHiro](https://github.com/nerohiro/nh-context)

# Installation
* **Add the job to your shared.lua**
* **Install nh-context by NeroHiro**

# Jobs for qb-core/shared.lua
```lua
["airlines"] = {
    label = "Airlines", 
    defaultDuty = true,
    grades = {
        ['0'] = {
            name = "Recruit",
            payment = 150
        },
        ['1'] = {
            name = "Jump Master",
            payment = 400
        },
        ['2'] = {
            name = "Pilot",
            payment = 450
        },
        ['3'] = {
            name = "CEO",
            isboss = true,
            payment = 500
        },
    },
},
```
# Config for ms-peds
```
{
    model = `ig_pilot`,
    coords = vector4(-1249.1, -3400.25, 13.94, 62.38),
    gender = 'male'
},
{
    model = `ig_pilot`,
    coords = vector4(1725.6, 3300.79, 41.22, 277.31),
    gender = 'male'
}
    ```