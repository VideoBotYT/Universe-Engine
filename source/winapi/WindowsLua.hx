package winapi;

import winapi.WindowsAPI;
#if LUA_ALLOWED
import llua.Lua;
import llua.LuaL;
import llua.State;
import llua.Convert;
#end

using StringTools;

class WindowsLua
{
	public static function loadLua()
	{
		#if LUA_ALLOWED
		for (funkin in PlayState.instance.luaArray)
		{
            Lua_helper.add_callback(funkin.lua, "showMessageBox", function(message:String, caption:String, icon:MessageBoxIcon = MSG_WARNING){
                WindowsAPI.showMessageBox(caption, message, icon);
            });
            Lua_helper.add_callback(funkin.lua, "hideTaskbar", function(hide:Bool){
                WindowsAPI.hideTaskbar(hide);
            });
		}
		#end
	}
}
