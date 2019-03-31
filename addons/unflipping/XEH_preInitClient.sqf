#include "initSettings.sqf"


["vet_unflipping_unflip_start_client", {
    diag_log text "[VET_Unflipping] Starting action";
    _this call vet_unflipping_fnc_unflipAction;
}] call CBA_fnc_addEventHandler;

// Force player to wait for unflipping time
["vet_unflipping_unflip_ready", {
    params ["_time"];
    diag_log text "[VET_Unflipping] Unflip ready";
    // Spawn new unclosable progressbar for unflip action time
    [{
        // TODO animation
        [
            localize "STR_vet_unflipping_unflip_doing",
            _this,
            {true},
            {},
            {},
            [],
            true, // block mouse
            true, // block keys
            false // allow close (esc)
        ] call CBA_fnc_progressBar;
    }, _time] call CBA_fnc_execNextFrame;
}] call CBA_fnc_addEventHandler;

// Add ACE3 or Vanilla actions to vehicles
if (isClass(configFile >> "CfgPatches" >> "ace_main")) then {

    private _unflipAction = ["vet_unflipping_unflip", localize "STR_vet_unfliping_act", "\a3\3den\data\attributes\loiterdirection\cw_ca.paa",
        {
            _target call vet_unflipping_fnc_unflipAction;
        },
        {
            [_player, _target, []] call ACE_common_fnc_canInteractWith
            && !canMove _target
            && {alive _target}
            && {!(_target isKindOf "Boxloader_Pallet_base")}
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
