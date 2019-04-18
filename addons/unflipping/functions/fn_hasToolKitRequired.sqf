/*
 * Checks if the toolkit is required, and whether or not the unit has that item if it is
 *
 */
params ["_unit"];

if !(vet_unflipping_require_toolkit) exitWith { true }; // if it's not needed, return true for conditional sake -- this isn't a great methodology, I know
if ("ToolKit" in (items _unit)) exitWith { true }; // has the toolkit, return true
false;