package ueLua;

#if LUA_ALLOWED
import llua.Lua;
import llua.LuaL;
import llua.State;
import llua.Convert;
#end
import flixel.util.FlxColor;
import flixel.addons.display.FlxBackdrop;
import flixel.addons.display.FlxGridOverlay;
import flixel.FlxSprite;
import ClientPrefs;
import flixel.FlxObject;
import flixel.group.FlxGroup.FlxTypedGroup;
import animateatlas.AtlasFrameMaker;

using StringTools;

class MenuLua
{
	public static var Function_Stop:Dynamic = 1;
	public static var Function_Continue:Dynamic = 0;
	public static var Function_StopLua:Dynamic = 2;

	#if LUA_ALLOWED
	public var lua:State = null;
	#end
	public var scriptName:String = '';
	public var closed:Bool = false;

	public function new(script:String)
	{
		#if LUA_ALLOWED
		lua = LuaL.newstate();
		LuaL.openlibs(lua);
		Lua.init_callbacks(lua);

		try
		{
			var result:Dynamic = LuaL.dofile(lua, script);
			var resultStr:String = Lua.tostring(lua, result);
			if (resultStr != null && result != 0)
			{
				trace('Error on lua script! ' + resultStr);
				#if windows
				lime.app.Application.current.window.alert(resultStr, 'Error on lua script!');
				#else
				luaTrace('Error loading lua script: "$script"\n' + resultStr, true, false, FlxColor.RED);
				#end
				lua = null;
				return;
			}
		}
		catch (e:Dynamic)
		{
			trace(e);
			return;
		}
		scriptName = script;
		trace('Lua file loaded succesfully:' + script);

		Lua_helper.add_callback(lua, "addMenuGridBG", function(tag:String, cellWidth:Int, cellHeight:Int, width:Int, height:Int, xVel:Int, yVel:Int)
		{
			var backdrop = new FlxBackdrop(FlxGridOverlay.createGrid(cellWidth, cellHeight, width, height, true, 0x33FFFFFF, 0x0));
			backdrop.velocity.set(xVel, yVel);
			MusicBeatState.instance.add(backdrop);
			MusicBeatState.instance.menuvariables.set(tag, backdrop);
		});
		Lua_helper.add_callback(lua, "addMenuBackdrop", function(tag:String, image:String, xVel:Int, yVel:Int)
		{
			var backDrop = new FlxBackdrop(Paths.image(image));
			backDrop.velocity.set(xVel, yVel);
			MusicBeatState.instance.add(backDrop);
			MusicBeatState.instance.menuvariables.set(tag, backDrop);
		});
		Lua_helper.add_callback(lua, "removeMenuBackdrop", function(tag:String)
		{
			MusicBeatState.instance.menuvariables[tag].destroy();
			MusicBeatState.instance.menuvariables.remove(tag);
			MusicBeatState.instance.remove(MusicBeatState.instance.menuvariables.get(tag));
		});
		Lua_helper.add_callback(lua, "makeMenuSprite", function(tag:String, image:String, x:Float, y:Float)
		{
			tag = tag.replace('.', '');
			resetSpriteTag(tag);
			var leSprite:ModchartSprite = new ModchartSprite(x, y);
			if (image != null && image.length > 0)
			{
				leSprite.loadGraphic(Paths.image(image));
			}
			leSprite.antialiasing = ClientPrefs.data.globalAntialiasing;
			MusicBeatState.instance.menuSprites.set(tag, leSprite);
			leSprite.active = true;
		});
		Lua_helper.add_callback(lua, "makeAnimatedMenuSprite", function(tag:String, image:String, x:Float, y:Float, ?spriteType:String = "sparrow")
		{
			tag = tag.replace('.', '');
			resetSpriteTag(tag);
			var leSprite:ModchartSprite = new ModchartSprite(x, y);

			loadFrames(leSprite, image, spriteType);
			leSprite.antialiasing = ClientPrefs.data.globalAntialiasing;
			MusicBeatState.instance.menuSprites.set(tag, leSprite);
		});

		Lua_helper.add_callback(lua, "makeMenuGraphic", function(obj:String, width:Int, height:Int, color:String)
		{
			var colorNum:Int = Std.parseInt(color);
			if (!color.startsWith('0x'))
				colorNum = Std.parseInt('0xff' + color);

			var spr:FlxSprite = MusicBeatState.instance.getLuaObject(obj, false);
			if (spr != null)
			{
				MusicBeatState.instance.getLuaObject(obj, false).makeGraphic(width, height, colorNum);
				return;
			}

			var object:FlxSprite = Reflect.getProperty(getInstance(), obj);
			if (object != null)
			{
				object.makeGraphic(width, height, colorNum);
			}
		});
		Lua_helper.add_callback(lua, "addMenuAnimationByPrefix", function(obj:String, name:String, prefix:String, framerate:Int = 24, loop:Bool = true)
		{
			if (MusicBeatState.instance.getLuaObject(obj, false) != null)
			{
				var cock:FlxSprite = MusicBeatState.instance.getLuaObject(obj, false);
				cock.animation.addByPrefix(name, prefix, framerate, loop);
				if (cock.animation.curAnim == null)
				{
					cock.animation.play(name, true);
				}
				return;
			}

			var cock:FlxSprite = Reflect.getProperty(getInstance(), obj);
			if (cock != null)
			{
				cock.animation.addByPrefix(name, prefix, framerate, loop);
				if (cock.animation.curAnim == null)
				{
					cock.animation.play(name, true);
				}
			}
		});

		Lua_helper.add_callback(lua, "addMenuAnimationByIndices", function(obj:String, name:String, prefix:String, indices:String, framerate:Int = 24)
		{
			return addAnimByIndices(obj, name, prefix, indices, framerate, false);
		});
		Lua_helper.add_callback(lua, "addMenuAnimationByIndicesLoop", function(obj:String, name:String, prefix:String, indices:String, framerate:Int = 24)
		{
			return addAnimByIndices(obj, name, prefix, indices, framerate, true);
		});

		Lua_helper.add_callback(lua, "playMenuAnim", function(obj:String, name:String, forced:Bool = false, ?reverse:Bool = false, ?startFrame:Int = 0)
		{
			if (MusicBeatState.instance.getLuaObject(obj, false) != null)
			{
				var luaObj:FlxSprite = MusicBeatState.instance.getLuaObject(obj, false);
				if (luaObj.animation.getByName(name) != null)
				{
					luaObj.animation.play(name, forced, reverse, startFrame);
					if (Std.isOfType(luaObj, ModchartSprite))
					{
						// convert luaObj to ModchartSprite
						var obj:Dynamic = luaObj;
						var luaObj:ModchartSprite = obj;

						var daOffset = luaObj.animOffsets.get(name);
						if (luaObj.animOffsets.exists(name))
						{
							luaObj.offset.set(daOffset[0], daOffset[1]);
						}
					}
				}
				return true;
			}

			var spr:FlxSprite = Reflect.getProperty(getInstance(), obj);
			if (spr != null)
			{
				if (spr.animation.getByName(name) != null)
				{
					spr.animation.play(name, forced, reverse, startFrame);
				}
				return true;
			}
			return false;
		});
		Lua_helper.add_callback(lua, "addMenuOffset", function(obj:String, anim:String, x:Float, y:Float)
		{
			if (MusicBeatState.instance.menuSprites.exists(obj))
			{
				MusicBeatState.instance.menuSprites.get(obj).animOffsets.set(anim, [x, y]);
				return true;
			}
			return true;
		});

		Lua_helper.add_callback(lua, "setMenuScrollFactor", function(obj:String, scrollX:Float, scrollY:Float)
		{
			if (MusicBeatState.instance.getLuaObject(obj, false) != null)
			{
				MusicBeatState.instance.getLuaObject(obj, false).scrollFactor.set(scrollX, scrollY);
				return;
			}

			var object:FlxObject = Reflect.getProperty(getInstance(), obj);
			if (object != null)
			{
				object.scrollFactor.set(scrollX, scrollY);
			}
		});
		Lua_helper.add_callback(lua, "addMenuSprite", function(tag:String, front:Bool = false)
		{
			if (MusicBeatState.instance.menuSprites.exists(tag))
			{
				var shit:ModchartSprite = MusicBeatState.instance.menuSprites.get(tag);
				if (!shit.wasAdded)
				{
					if (front)
					{
						getInstance().add(shit);
					}
					else
					{
						MusicBeatState.instance.insert(0, shit);
					}
					shit.wasAdded = true;
					// trace('added a thing: ' + tag);
				}
			}
		});
		Lua_helper.add_callback(lua, "setMenuGraphicSize", function(obj:String, x:Int, y:Int = 0, updateHitbox:Bool = true)
		{
			if (MusicBeatState.instance.getLuaObject(obj) != null)
			{
				var shit:FlxSprite = MusicBeatState.instance.getLuaObject(obj);
				shit.setGraphicSize(x, y);
				if (updateHitbox)
					shit.updateHitbox();
				return;
			}

			var killMe:Array<String> = obj.split('.');
			var poop:FlxSprite = getObjectDirectly(killMe[0]);
			if (killMe.length > 1)
			{
				poop = getVarInArray(getPropertyLoopThingWhatever(killMe), killMe[killMe.length - 1]);
			}

			if (poop != null)
			{
				poop.setGraphicSize(x, y);
				if (updateHitbox)
					poop.updateHitbox();
				return;
			}
			luaTrace('setGraphicSize: Couldnt find object: ' + obj, false, false, FlxColor.RED);
		});
		Lua_helper.add_callback(lua, "scaleMenuObject", function(obj:String, x:Float, y:Float, updateHitbox:Bool = true)
		{
			if (MusicBeatState.instance.getLuaObject(obj) != null)
			{
				var shit:FlxSprite = MusicBeatState.instance.getLuaObject(obj);
				shit.scale.set(x, y);
				if (updateHitbox)
					shit.updateHitbox();
				return;
			}

			var killMe:Array<String> = obj.split('.');
			var poop:FlxSprite = getObjectDirectly(killMe[0]);
			if (killMe.length > 1)
			{
				poop = getVarInArray(getPropertyLoopThingWhatever(killMe), killMe[killMe.length - 1]);
			}

			if (poop != null)
			{
				poop.scale.set(x, y);
				if (updateHitbox)
					poop.updateHitbox();
				return;
			}
			luaTrace('scaleObject: Couldnt find object: ' + obj, false, false, FlxColor.RED);
		});
		Lua_helper.add_callback(lua, "updateMenuHitbox", function(obj:String)
		{
			if (MusicBeatState.instance.getLuaObject(obj) != null)
			{
				var shit:FlxSprite = MusicBeatState.instance.getLuaObject(obj);
				shit.updateHitbox();
				return;
			}

			var poop:FlxSprite = Reflect.getProperty(getInstance(), obj);
			if (poop != null)
			{
				poop.updateHitbox();
				return;
			}
			luaTrace('updateHitbox: Couldnt find object: ' + obj, false, false, FlxColor.RED);
		});
		Lua_helper.add_callback(lua, "updateMenuHitboxFromGroup", function(group:String, index:Int)
		{
			if (Std.isOfType(Reflect.getProperty(getInstance(), group), FlxTypedGroup))
			{
				Reflect.getProperty(getInstance(), group).members[index].updateHitbox();
				return;
			}
			Reflect.getProperty(getInstance(), group)[index].updateHitbox();
		});

		Lua_helper.add_callback(lua, "removeMenuSprite", function(tag:String, destroy:Bool = true)
		{
			if (!MusicBeatState.instance.menuSprites.exists(tag))
			{
				return;
			}

			var pee:ModchartSprite = MusicBeatState.instance.menuSprites.get(tag);
			if (destroy)
			{
				pee.kill();
			}

			if (pee.wasAdded)
			{
				getInstance().remove(pee, true);
				pee.wasAdded = false;
			}

			if (destroy)
			{
				pee.destroy();
				MusicBeatState.instance.menuSprites.remove(tag);
			}
		});

		Lua_helper.add_callback(lua, "screenCenterMenu", function(obj:String, pos:String = 'xy')
		{
			var instance:Dynamic = MusicBeatState.instance; // Too lazy to redo this one.
			var spr:FlxSprite = instance.getLuaObject(obj);

			if (spr == null)
			{
				var killMe:Array<String> = obj.split('.');
				spr = getObjectDirectly(killMe[0]);
				if (killMe.length > 1)
				{
					spr = getVarInArray(getPropertyLoopThingWhatever(killMe), killMe[killMe.length - 1]);
				}
			}

			if (spr != null)
			{
				switch (pos.trim().toLowerCase())
				{
					case 'x':
						spr.screenCenter(X);
						return;
					case 'y':
						spr.screenCenter(Y);
						return;
					default:
						spr.screenCenter(XY);
						return;
				}
			}
			luaTrace("screenCenter: Object " + obj + " doesn't exist!", false, false, FlxColor.RED);
		});
		#end
	}

	function loadFrames(spr:FlxSprite, image:String, spriteType:String)
	{
		switch (spriteType.toLowerCase().trim())
		{
			case "texture" | "textureatlas" | "tex":
				spr.frames = AtlasFrameMaker.construct(image);

			case "texture_noaa" | "textureatlas_noaa" | "tex_noaa":
				spr.frames = AtlasFrameMaker.construct(image, null, true);

			case "packer" | "packeratlas" | "pac":
				spr.frames = Paths.getPackerAtlas(image);

			default:
				spr.frames = Paths.getSparrowAtlas(image);
		}
	}

	function resetSpriteTag(tag:String)
	{
		if (!MusicBeatState.instance.menuSprites.exists(tag))
		{
			return;
		}

		var pee:ModchartSprite = MusicBeatState.instance.menuSprites.get(tag);
		pee.kill();
		if (pee.wasAdded)
		{
			MusicBeatState.instance.remove(pee, true);
		}
		pee.destroy();
		MusicBeatState.instance.menuSprites.remove(tag);
	}

	static function addAnimByIndices(obj:String, name:String, prefix:String, indices:String, framerate:Int = 24, loop:Bool = false)
	{
		var strIndices:Array<String> = indices.trim().split(',');
		var die:Array<Int> = [];
		for (i in 0...strIndices.length)
		{
			die.push(Std.parseInt(strIndices[i]));
		}

		if (MusicBeatState.instance.getLuaObject(obj, false) != null)
		{
			var pussy:FlxSprite = MusicBeatState.instance.getLuaObject(obj, false);
			pussy.animation.addByIndices(name, prefix, die, '', framerate, loop);
			if (pussy.animation.curAnim == null)
			{
				pussy.animation.play(name, true);
			}
			return true;
		}

		var pussy:FlxSprite = Reflect.getProperty(getInstance(), obj);
		if (pussy != null)
		{
			pussy.animation.addByIndices(name, prefix, die, '', framerate, loop);
			if (pussy.animation.curAnim == null)
			{
				pussy.animation.play(name, true);
			}
			return true;
		}
		return false;
	}

	public static function getVarInArray(instance:Dynamic, variable:String):Any
	{
		var shit:Array<String> = variable.split('[');
		if (shit.length > 1)
		{
			var blah:Dynamic = null;
			if (MusicBeatState.instance.menuvariables.exists(shit[0]))
			{
				var retVal:Dynamic = MusicBeatState.instance.menuvariables.get(shit[0]);
				if (retVal != null)
					blah = retVal;
			}
			else
				blah = Reflect.getProperty(instance, shit[0]);

			for (i in 1...shit.length)
			{
				var leNum:Dynamic = shit[i].substr(0, shit[i].length - 1);
				blah = blah[leNum];
			}
			return blah;
		}

		if (MusicBeatState.instance.menuvariables.exists(variable))
		{
			var retVal:Dynamic = MusicBeatState.instance.menuvariables.get(variable);
			if (retVal != null)
				return retVal;
		}

		return Reflect.getProperty(instance, variable);
	}

	public static function getObjectDirectly(objectName:String, ?checkForTextsToo:Bool = true):Dynamic
	{
		var coverMeInPiss:Dynamic = MusicBeatState.instance.getLuaObject(objectName, checkForTextsToo);
		if (coverMeInPiss == null)
			coverMeInPiss = getVarInArray(getInstance(), objectName);

		return coverMeInPiss;
	}

	public static function getPropertyLoopThingWhatever(killMe:Array<String>, ?checkForTextsToo:Bool = true, ?getProperty:Bool = true):Dynamic
	{
		var coverMeInPiss:Dynamic = getObjectDirectly(killMe[0], checkForTextsToo);
		var end = killMe.length;
		if (getProperty)
			end = killMe.length - 1;

		for (i in 1...end)
		{
			coverMeInPiss = getVarInArray(coverMeInPiss, killMe[i]);
		}
		return coverMeInPiss;
	}

	public function luaTrace(text:String, ignoreCheck:Bool = false, deprecated:Bool = false, color:FlxColor = FlxColor.WHITE)
	{
		#if LUA_ALLOWED
		if (ignoreCheck || getBool('luaDebugMode'))
		{
			if (deprecated && !getBool('luaDeprecatedWarnings'))
			{
				return;
			}
			// MusicBeatState.instance.addTextToDebug(text, color);
			trace(text);
		}
		#end
	}

	#if LUA_ALLOWED
	public function getBool(variable:String)
	{
		var result:String = null;
		Lua.getglobal(lua, variable);
		result = Convert.fromLua(lua, -1);
		Lua.pop(lua, 1);

		if (result == null)
		{
			return false;
		}
		return (result == 'true');
	}
	#end

	public static inline function getInstance()
	{
		return MusicBeatState.instance;
	}

	function typeToString(type:Int):String
	{
		#if LUA_ALLOWED
		switch (type)
		{
			case Lua.LUA_TBOOLEAN:
				return "boolean";
			case Lua.LUA_TNUMBER:
				return "number";
			case Lua.LUA_TSTRING:
				return "string";
			case Lua.LUA_TTABLE:
				return "table";
			case Lua.LUA_TFUNCTION:
				return "function";
		}
		if (type <= Lua.LUA_TNIL)
			return "nil";
		#end
		return "unknown";
	}

	function getErrorMessage(status:Int):String
	{
		#if LUA_ALLOWED
		var v:String = Lua.tostring(lua, -1);
		Lua.pop(lua, 1);

		if (v != null)
			v = v.trim();
		if (v == null || v == "")
		{
			switch (status)
			{
				case Lua.LUA_ERRRUN:
					return "Runtime Error";
				case Lua.LUA_ERRMEM:
					return "Memory Allocation Error";
				case Lua.LUA_ERRERR:
					return "Critical Error";
			}
			return "Unknown Error";
		}

		return v;
		#end
		return null;
	}

	var lastCalledFunction:String = '';

	public function call(func:String, args:Array<Dynamic>):Dynamic
	{
		#if LUA_ALLOWED
		if (closed)
			return Function_Continue;

		lastCalledFunction = func;
		try
		{
			if (lua == null)
				return Function_Continue;

			Lua.getglobal(lua, func);
			var type:Int = Lua.type(lua, -1);

			if (type != Lua.LUA_TFUNCTION)
			{
				if (type > Lua.LUA_TNIL)
					luaTrace("ERROR (" + func + "): attempt to call a " + typeToString(type) + " value", false, false, FlxColor.RED);

				Lua.pop(lua, 1);
				return Function_Continue;
			}

			for (arg in args)
				Convert.toLua(lua, arg);
			var status:Int = Lua.pcall(lua, args.length, 1, 0);

			// Checks if it's not successful, then show a error.
			if (status != Lua.LUA_OK)
			{
				var error:String = getErrorMessage(status);
				luaTrace("ERROR (" + func + "): " + error, false, false, FlxColor.RED);
				return Function_Continue;
			}

			// If successful, pass and then return the result.
			var result:Dynamic = cast Convert.fromLua(lua, -1);
			if (result == null)
				result = Function_Continue;

			Lua.pop(lua, 1);
			return result;
		}
		catch (e:Dynamic)
		{
			trace(e);
		}
		#end
		return Function_Continue;
	}
}

class ModchartSprite extends FlxSprite
{
	public var wasAdded:Bool = false;
	public var animOffsets:Map<String, Array<Float>> = new Map<String, Array<Float>>();

	// public var isInFront:Bool = false;

	public function new(?x:Float = 0, ?y:Float = 0)
	{
		super(x, y);
		antialiasing = ClientPrefs.data.globalAntialiasing;
	}
}
