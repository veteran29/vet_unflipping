/*
    vet_unflipping_fnc_debug

    File: fn_debug.sqf
    Date: 2019-04-01
    Last Update: 2019-04-09
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html

    Description:
        Show debug information

    Parameter(s):
        _enable - Enable debug mode [BOOL, defaults to false]

    Returns:
        NOTHING
*/
params [
    ["_enable", false, [true]]
];

if (_enable) then {

    private _fnc_show = {
        params ["_vehicle"];
        if (isNull _vehicle) exitWith {};

        private _upsideDown = (vectorUp _vehicle vectorDotProduct surfaceNormal getPos _vehicle) < -0.80;
        private _bank = _vehicle call BIS_fnc_getPitchBank select 1;

        private _flipLeft = _bank >= 0;
        // When upside down then left is right and right is left
        if (_upsideDown) then {
            _flipLeft = !_flipLeft;
        };

        private _canUnflip = !_upsideDown && 55 > abs _bank;
        if (_canUnflip) exitWith {};

        private _bbr = boundingBoxReal _vehicle;
        private _vehicleWidth = abs (_bbr#0#0 * 2);

        private _force = getMass _vehicle * ([1 + (_vehicleWidth/8), _vehicleWidth] select _upsideDown);

        private _bbr = boundingBoxReal _vehicle;
        private _forcePointX = _bbr select ([0, 1] select _flipLeft) select 0;
        private _forcePointZ = _bbr select ([1, 0] select _upsideDown) select 2;


        private _vectorStart = (_vehicle modelToWorld [
            _forcePointX + (_force / 1000 * ([-1, 1] select _flipLeft)),
            0,
            _forcePointZ //+ ([-1, 1] select _upsideDown)
        ]);
        private _vectorEnd = (_vehicle modelToWorld [_forcePointX, 0, _forcePointZ]);

        drawLine3D [_vectorStart, _vectorEnd, [1,1,0,1]];

        drawIcon3D [
            "\A3\ui_f\data\map\markers\military\dot_CA.paa",
            [1,1,1,0.5],
            _vectorStart,
            1,
            1,
            0,
            "FROM"
        ];

        drawIcon3D [
            "\A3\ui_f\data\map\markers\military\dot_CA.paa",
            [1,1,1,0.5],
            _vectorEnd,
            1,
            1,
            0,
            str (_vehicle vectorModelToWorld [[_force, -_force] select _flipLeft, 0, 0])
        ];
    };

    vet_unflipping_debugPFH = [_fnc_show, 0] call CBA_fnc_addPerFrameHandler;
} else {
    (missionNamespace getVariable ["vet_unflipping_debugPFH", -1]) call CBA_fnc_removePerFrameHandler;
};
