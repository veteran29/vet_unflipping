/*
    vet_unflipping_fnc_unflipRequiredAmount

    File: fn_unflipRequiredAmount.sqf
    Date: 2019-03-14
    Last Update: 2019-04-01
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html

    Description:
        Returns amount of people needed to unflip vehicle.

    Parameter(s):
        _vehicle - Vehicle to calculate amount of people for

    Returns:
        Amount of people needed to unflip vehicle [NUMBER]
*/
params [
    ["_vehicle", objNull, [objNull]]
];

// Every 3t needs one man, max seven, min one
floor ((getMass _vehicle / vet_unflipping_unit_mass_limit) min vet_unflipping_unit_man_limit) max 1
