/*
    vet_unflipping_fnc_canUnflipLocal

    File: fn_canUnflipLocal.sqf
    Date: 2019-06-18
    Last Update: 2019-07-18
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html

    Description:
        Checks if unit can unflip the target.

    Parameter(s):
        _unit   - Unit to check             [OBJECT, defaults to objNull]
        _target - Vehicle that is unflipped [OBJECT, defaults to objNull]

    Returns:
        Target can be unflipped [BOOL]
*/
params [
    ["_unit", objNull, [objNull]],
    ["_target", objNull, [objNull]]
];

!canMove _target
&& {alive _target}
&& {(vehicle _unit) isEqualTo _unit}
&& {_unit call vet_unflipping_fnc_hasToolKitRequired}
&& {[_unit, _target] call vet_unflipping_fnc_isServiceVehicleNearRequired}
