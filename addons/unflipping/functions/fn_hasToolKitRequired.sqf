/*
    vet_unflipping_fnc_hasToolKitRequired

    File: fn_hasToolKitRequired.sqf
    Date: 2019-03-18
    Last Update: 2019-04-18
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html

    Description:
        Checks if the toolkit is required, and whether or not the unit has that item if it is

    Parameter(s):
        _unit - Unit to check [OBJECT, defaults to objNull]

    Returns:
        NOTHING
*/
params [
    ["_unit", objNull, [objNull]]
];

if !(vet_unflipping_require_toolkit) exitWith {true};

"ToolKit" in (items _unit)
