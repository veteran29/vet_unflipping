/*
    vet_unflipping_addUnflipActionLocal

    File: fn_addUnflipAction.sqf
    Date: 2019-04-01
    Last Update: 2019-06-18
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html

    Description:
        Adds Vanilla unflip action to vehicle.

    Parameter(s):
        _object - vehicle to add unflip action to [OBJECT, defaults to objNull]

    Returns:
        NOTHING
*/
params [
    ["_object", objNull, [objNull]]
];

private _action = [
    "Unflip",
    {
        [{
            params ["_target"];
            _target call vet_unflipping_fnc_unflipAction;
        }, _this] call CBA_fnc_directCall;
    },
    [],
    -10,
    false,
    true,
    "",
    "
    [_this, _target] call vet_unflipping_fnc_canUnflipLocal
    ", // _target, _this, _originalTarget
    8
];

private _actionId = _object addAction _action;

_object setUserActionText [
    _actionId ,
    localize "STR_vet_unflipping_act",
    "<img size='2' image='\a3\3den\data\attributes\loiterdirection\cw_ca.paa'/>"
];

nil
