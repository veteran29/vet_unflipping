## VET_Unflipping

Ever got in trouble because of Splendid physics? Fear no more!

This small utility addon allows players to perform Unflip on vehicles that are on their side or upside down.

[BI Forum Thread](https://forums.bohemia.net/forums/topic/222712-vet_unflipping/)

### Requirements
- [CBA_A3](https://steamcommunity.com/sharedfiles/filedetails/?id=450814997)
- Installed both on clients and server

### Settings

By default single infantry unit can unflip vehicles up to 3000 mass. Default value was balanced to allow unflipping of smaller vehicles by single unit.

If vehicle is heavier than can be lifted by single unit then multiple people can join unflipping process. Amount of people needed depends on weight of vehicle.

If you would like to configure the addon to behave somewhate more "realistic" you can tweak following values in CBA Settings in `VET_Unflipping` category:
- Unit mass limit - How much can be unflipped by single unit (default: 3000)
- Man limit - Maximum amount of people that can be needed to unflip vehicle (default: 7)
- Unflipping time - How long does it take to unflip vehicle (default: 5)
- Maximum unflip weight - Vehicles with weight above this limit will be not unflippable (default: 100000)
- Require toolkit (default: false)

### Vanilla / ACE Actions

If ACE3 is detected unflipping action will be available in ACE3 Interaction menu, otherwise vanilla interaction menu will be used.

![Interaction](https://i.imgur.com/1dUmm4G.png)


### Showcase

[![Unflipping video](https://img.youtube.com/vi/rQ9ON5PmYS0/0.jpg)](https://www.youtube.com/watch?v=rQ9ON5PmYS0 "VET_Unflipping")
