/*
    vet_unflipping_fnc_isServiceVehicleNearRequired

    File: fn_isServiceVehicleNearRequired..sqf
    Date: 2019-06-18
    Last Update: 2019-07-18
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html

    Description:
        Checks if the service vehicle is required, and whether or not it is nearby.

    Parameter(s):
        _unit   - Unit to check             [OBJECT, defaults to objNull]
        _target - Vehicle that is unflipped [OBJECT, defaults to objNull]

    Returns:
        Function reached the end [BOOL]
*/
params [
    ["_unit", objNull, [objNull]],
    ["_target", objNull, [objNull]]
];

if !(vet_unflipping_require_serviceVehicle) exitWith {true};

private _nearObjects = nearestObjects [_target, ["Air", "LandVehicle", "Slingload_base_F"], 5 + sizeOf typeOf _target];

// return
_nearObjects findIf {alive _x && {_x call vet_unflipping_fnc_isRepairVehicle}} != -1
