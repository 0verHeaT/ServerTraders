Serverside Traderdata
=============

Just a simple way to keep your trader configuration serverside.

##### Installation

Copy the trader_data.sqf to your server files

In the very bottom of your server_monitor.sqf put this line

  execVM "\z\addons\dayz_server\"+YOURPATH+"\trader_data.sqf";

Find your server_traders.sqf file in your mission, open it and copy the whole code to trader_data.sqf (At the top!)

Finally you have to change your fn_selfActions.sqf to acces the trader menu

Find the the trader part and change the whole block to

if (_isMan && !_isPZombie && (typeName(_cursorTarget getVariable ["TraderData",-1]) == "ARRAY")) then {
	if (s_player_parts_crtl < 0) then {
		_humanity = player getVariable ["humanity",0];
		_traderMenu = _cursorTarget getVariable ["TraderData",-1];
		_low_high = "low";
		_humanity_logic = false;
		if((_traderMenu select 2) == "friendly") then {
			_humanity_logic = (_humanity < -5000);
		};
		if((_traderMenu select 2) == "hostile") then {
			_low_high = "high";
			_humanity_logic = (_humanity > -5000);
		};
		if((_traderMenu select 2) == "hero") then {
			_humanity_logic = (_humanity < 5000);
		};
		if(_humanity_logic) then {
			_cancel = player addAction [format[localize "STR_EPOCH_ACTIONS_HUMANITY",_low_high], "\z\addons\dayz_code\actions\trade_cancel.sqf",["na"], 0, true, false, "",""];
			s_player_parts set [count s_player_parts,_cancel];
		} else {
			{
				_buy = player addAction [format["Trade %1 %2 for %3 %4",(_x select 3),(_x select 5),(_x select 2),(_x select 6)], "\z\addons\dayz_code\actions\trade_items_wo_db.sqf",[(_x select 0),(_x select 1),(_x select 2),(_x select 3),(_x select 4),(_x select 5),(_x select 6)], (_x select 7), true, true, "",""];
				s_player_parts set [count s_player_parts,_buy];	
			} count (_traderMenu select 1);
			_buy = player addAction [localize "STR_EPOCH_PLAYER_289", "\z\addons\dayz_code\actions\show_dialog.sqf",(_traderMenu select 0), 999, true, false, "",""];
			s_player_parts set [count s_player_parts,_buy];
		};
		s_player_parts_crtl = 1;	
	};
} else {
	{player removeAction _x} count s_player_parts;s_player_parts = [];
	s_player_parts_crtl = -1;
};
