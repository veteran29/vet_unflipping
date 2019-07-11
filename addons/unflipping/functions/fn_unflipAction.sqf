/*
    vet_unflipping_fnc_unflipAction

    File: fn_unflipAction.sqf
    Date: 2019-03-14
    Last Update: 2019-04-08
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html

    Description:
        Start vehicle unflip action.

    Parameter(s):
        _vehicle - Vehicle to start unflip action on [OBJECT, defaults to objNull]

    Returns:
        NOTHING
*/
params [
    ["_vehicle", objNull, [objNull]]
];

if (vet_unflipping_vehicle_mass_limit < getMass _vehicle) exitWith {
    [
        ["a3\3den\data\controlsgroups\tutorial\close_ca.paa", 1, [1,0,0]],
        [localize "STR_vet_unflipping_to_heavy"]
    ] call CBA_fnc_notify;
};

#define UNFLIPPING_UNITS        (_vehicle getVariable ["vet_unflippingUnits", []])
#define PLAYER                  ([] call CBA_fnc_currentUnit)

PLAYER playActionNow "PlayerStand";

private _neededUnits = _vehicle call vet_unflipping_fnc_unflipRequiredAmount;

// Inform server about unflipping start
if !(PLAYER in UNFLIPPING_UNITS) exitWith {
    ["vet_unflipping_unflip_start", [_vehicle, PLAYER]] call CBA_fnc_serverEvent;
};

// Notify
[
    ["\a3\3den\data\attributes\loiterdirection\cw_ca.paa"],
    [format [localize "STR_vet_unflipping_required", _neededUnits]]
] call CBA_fnc_notify;

// Exec next frame, othwerwise we will crash the client
[{
    [
        localize "STR_vet_unflipping_waiting",
        15,
        {
            _this#0 params ["_vehicle"];
            !(UNFLIPPING_UNITS isEqualTo [])
            && alive PLAYER
        },
        // onSuccess
        {
            _this#0 params ["_vehicle"];
            ["vet_unflipping_unflip_stop", [_vehicle, PLAYER]] call CBA_fnc_serverEvent;
            // Notify
            [
                ["\a3\3den\data\attributes\loiterdirection\cw_ca.paa"],
                [localize "STR_vet_unflipping_need_more"]
            ] call CBA_fnc_notify;
        },
        // onFailure
        {
            params ["_args", "", "", "", "_failureCode"];
            _args params ["_vehicle"];

            // don't stop unflipping if waiting progressBar was closed by new progressBar
            if (_failureCode != 3) then {
                ["vet_unflipping_unflip_stop", [_vehicle, PLAYER]] call CBA_fnc_serverEvent;
            };
        },
        _this
    ] call CBA_fnc_progressBar;
}, _this] call CBA_fnc_execNextFrame;

nil
