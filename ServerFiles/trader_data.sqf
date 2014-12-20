/********************/
// Paste HERE your server_traders.sqf
/********************/

waituntil {sleep 1; !isNil "sm_done"};

diag_log "Starting to set the Traderdata Variables.";

_array = [];
{
	private ["_x"];
	if ((typeOf _x) in _serverTraders) then {
		_array set [count _array,_x];
	};
} count (allMissionObjects "Man");

_i = 0;
{
	private ["_name","_data"];
	_i = _i + 1;
	_name = typeOf _x;
	private ["_data"];
	_data = call compile format ["menu_%1",_name];
	_x setVariable ["TraderData",_data,true];
} count _array;

diag_log format ["Successfully set %1 Traderdata variables,_i];

publicVariable "serverTraders";
