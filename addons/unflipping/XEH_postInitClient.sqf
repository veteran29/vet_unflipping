#define PLAYER                  ([] call CBA_fnc_currentUnit)

["vet_unflipping_unflip_start_client", {
    diag_log text "[VET_Unflipping] Starting action";
    _this call vet_unflipping_fnc_unflipAction;
}] call CBA_fnc_addEventHandler;

// Force player to wait for unflipping time
["vet_unflipping_unflip_ready", {

    diag_log text "[VET_Unflipping] Unflip ready";

    // Spawn new progressbar for unflip action time
    [{
        // TODO animation
        [
            localize "STR_vet_unflipping_doing",
            // time
            _this#2,
            // condition
            {
                params ["_args", "", "_elapsedTime"];
                _args params ["_vehicle", "_requiredUnits"];

                // don't check before 1s elapsed to wait for publicVariable synchronization
                _elapsedTime < 1 ||
                {count (_vehicle getVariable ["vet_unflippingUnits", []]) >= _requiredUnits}
            },
            // onSuccess
            {},
            // onFailure
            {
                params ["_args", "", "", "", "_failureCode"];
                _args params ["_vehicle", "", ""];

                // user hit ESC
                if (_failureCode == 1) then {
                    ["vet_unflipping_unflip_stop", [_vehicle, PLAYER]] call CBA_fnc_serverEvent;

                // user did not hit ESC --> other reason for failure
                } else {
                    // if user is in unflippingUnits --> enter wait mode again
                    // if not --> server has completed unflipping and reset the array
                    if (PLAYER in (_vehicle getVariable ["vet_unflippingUnits", []])) then {
                        [_vehicle] call vet_unflipping_fnc_unflipAction;
                    };
                };
            },
            // args
            _this,
            true, // block mouse
            true, // block keys
            true // allow close (esc)
        ] call CBA_fnc_progressBar;
    }, _this] call CBA_fnc_execNextFrame;
}] call CBA_fnc_addEventHandler;

// Add ACE3 or Vanilla actions to vehicles
if (isClass(configFile >> "CfgPatches" >> "ace_main")) then {

    private _unflipAction = ["vet_unflipping_unflip", localize "STR_vet_unflipping_act", "\a3\3den\data\attributes\loiterdirection\cw_ca.paa",
        {
            _target call vet_unflipping_fnc_unflipAction;
        },
        {
            [_player, _target, []] call ACE_common_fnc_canInteractWith
            && {!(_target isKindOf "Boxloader_Pallet_base")}
            && {[_player, _target] call vet_unflipping_fnc_canUnflipLocal}
        }
    ] call ACE_interact_menu_fnc_createAction;
    ["LandVehicle", 0, ["ACE_MainActions"], _unflipAction, true] call ACE_interact_menu_fnc_addActionToClass;

} else {
    [
        "LandVehicle",
        "Init",
        {(_this#0) call vet_unflipping_fnc_addUnflipActionLocal},
        true,
        ["Boxloader_Pallet_base"],
        true
    ] call CBA_fnc_addClassEventHandler;
};
