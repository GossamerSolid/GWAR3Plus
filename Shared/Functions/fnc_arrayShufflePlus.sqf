/*
Author: Killzone_Kid
*/
private ["_arr","_cnt","_el1","_rnd","_indx","_el2"];
_arr = _this select 0;
_cnt = count _arr - 1;
_el1 = _arr select _cnt;
_arr resize _cnt;
_rnd = random diag_tickTime * _cnt;
for "_i" from 1 to (_this select 1) do {
	_indx = floor random _rnd % _cnt;
	_el2 = _arr select _indx;
	_arr set [_indx, _el1];
	_el1 = _el2;
};
_arr set [_cnt, _el1];
_arr 