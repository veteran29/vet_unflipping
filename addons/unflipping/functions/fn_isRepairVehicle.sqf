/*
    vet_unflipping_fnc_isRepairVehicle

    File: fn_isRepairVehicle.sqf
    Date: 2019-06-18
    Last Update: 2019-06-18
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html

    Description:
        Checks if vehicle is an repair vehicle.

    Parameter(s):
        _vehicle - Vehicle to check [OBJECT, defaults to objNull]

    Returns:
        Is vehicle an repair vehicle [BOOL]
*/
params [
    ["_vehicle", objNull, [objNull]]
];

if (_vehicle isKindOf "CAManBase") exitWith {false};


if (isClass(configFile >> "CfgPatches" >> "ace_repair")) then {
    // Value can be integer or boolean
    private _value = _vehicle getVariable ["ACE_isRepairVehicle", getNumber (configFile >> "CfgVehicles" >> typeOf _vehicle >> "ace_repair_canRepair")];
    // return
    _value in [1, true]
} else {
    // return
    (getRepairCargo _vehicle) > 0
};
