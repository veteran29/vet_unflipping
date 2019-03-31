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
        [{
            _this call vet_unflipping_fnc_unflipVehicle;
            _this setVariable ["vet_unflippingUnits", [], true];
        }, _vehicle, vet_unflipping_time] call CBA_fnc_waitAndExecute;
        // Inform clients that unflip is ready and force them into unflip action wait time
        ["vet_unflipping_unflip_ready", vet_unflipping_time] call CBA_fnc_targetEvent;
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
