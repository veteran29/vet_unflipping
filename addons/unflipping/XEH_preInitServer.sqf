#include "initSettings.sqf"


["vet_unflipping_unflip_start", {
    params ["_vehicle", "_player"];

    diag_log text format ["[VET_Unflipping] Player '%1', started unflipping '%2'", _player, _vehicle];

    private _unflippingUnits = _vehicle getVariable ["vet_unflippingUnits", []];
    _unflippingUnits pushBackUnique _player;
    _vehicle setVariable ["vet_unflippingUnits", _unflippingUnits, true];

    private _requiredUnits = _vehicle call vet_unflipping_fnc_unflipRequiredAmount;
    // Enough people, exit and unflip vehicle
    if (_requiredUnits <= count _unflippingUnits) exitWith {
        diag_log text format ["[VET_Unflipping] Vehicle '%1', enough people to unflip (%2)", _vehicle, _requiredUnits];

        // Schedule unflip
        [
            // condition
            {
                params ["_vehicle","_requiredUnits"];
                count (_vehicle getVariable ["vet_unflippingUnits", []]) < _requiredUnits
            },
            // statement (failure)
            {},
            // args
            [_vehicle,_requiredUnits],
            // timeout
            vet_unflipping_time,
            // onTimeout (success)
            {
                params ["_vehicle"];
                _vehicle call vet_unflipping_fnc_unflipVehicle;
                _vehicle setVariable ["vet_unflippingUnits", [], true];
            }
        ] call CBA_fnc_waitUntilAndExecute;

        // Inform clients that unflip is ready and force them into unflip action wait time
        ["vet_unflipping_unflip_ready", [_vehicle, _requiredUnits, vet_unflipping_time], _unflippingUnits] call CBA_fnc_targetEvent;
    };

    diag_log text format ["[VET_Unflipping] Vehicle '%1', not enough people to unflip (%2)", _vehicle, _requiredUnits];
    ["vet_unflipping_unflip_start_client", _vehicle, _player] call CBA_fnc_targetEvent;

}] call CBA_fnc_addEventHandler;

["vet_unflipping_unflip_stop", {
    params ["_vehicle", "_player"];
    diag_log text format ["[VET_Unflipping] Player '%1', stopped unflipping '%2'", _player, _vehicle];

    private _unflippingUnits = _vehicle getVariable ["vet_unflippingUnits", []];
    _vehicle setVariable ["vet_unflippingUnits", _unflippingUnits - [_player], true];
}] call CBA_fnc_addEventHandler;
