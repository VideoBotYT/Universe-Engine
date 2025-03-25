package winapi;

import sys.io.Process;

/**
 * This file only contains the functions that come from WindowsCPP.hx and WindowsTerminalCPP.hx, it should be 
 * the file to use when you require a Windows C++ function.
 * 
 * Author: Slushi
 */
#if windows
enum abstract MessageBoxIcon(Int) {
	var MSG_ERROR = 0x00000010;
	var MSG_QUESTION = 0x00000020;
	var MSG_WARNING = 0x00000030;
	var MSG_INFORMATION = 0x00000040;
}

class WindowsAPI {
	public static function obtainRAM():Int {
		return WindowsCPP.obtainRAM();
	}

	public static function screenCapture(path:String) {
		WindowsCPP.windowsScreenShot(path);
	}

	public static function showMessageBox(message:String, caption:String, icon:MessageBoxIcon = MSG_WARNING) {
		WindowsCPP.showMessageBox(caption, message, icon);
	}

	public static function getWindowsTransparent() {
		WindowsCPP.getWindowsTransparent();
	}

	public static function disableWindowTransparent() {
		WindowsCPP.disableWindowTransparent();
	}

	public static function setWindowVisible(mode:Bool) {
		WindowsCPP.setWindowVisible(mode);
	}

	public static function setWindowOppacity(a:Float) {
		WindowsCPP.setWindowAlpha(a);
	}

	public static function getWindowOppacity():Float {
		return WindowsCPP.getWindowAlpha();
	}

	public static function _setWindowLayered() {
		WindowsCPP._setWindowLayered();
	}

	public static function centerWindow() {
		WindowsCPP.centerWindow();
	}

	public static function setWindowBorderColor(r:Int, g:Int, b:Int) {
		WindowsCPP.setWindowBorderColor(r, g, b);
	}

	public static function hideTaskbar(hide:Bool) {
		WindowsCPP.hideTaskbar(hide);
	}

	public static function setWallpaper(path:String) {
		WindowsCPP.setWallpaper(path);
	}

	public static function hideDesktopIcons(hide:Bool) {
		WindowsCPP.hideDesktopIcons(hide);
	}

	public static function moveDesktopWindowsInX(x:Int) {
		WindowsCPP.moveDesktopWindowsInX(x);
	}

	public static function moveDesktopWindowsInY(y:Int) {
		WindowsCPP.moveDesktopWindowsInY(y);
	}

	public static function moveDesktopWindowsInXY(x:Int, y:Int) {
		WindowsCPP.moveDesktopWindowsInXY(x, y);
	}

	public static function getDesktopWindowsXPos():Int {
		return WindowsCPP.returnDesktopWindowsX();
	}

	public static function getDesktopWindowsYPos():Int {
		return WindowsCPP.returnDesktopWindowsY();
	}

	public static function setDesktopWindowsAlpha(alpha:Float) {
		WindowsCPP._setDesktopWindowsAlpha(alpha);
	}

	public static function setTaskBarAlpha(alpha:Float) {
		WindowsCPP._setTaskBarAlpha(alpha);
	}

	public static function setWindowLayeredMode(window:Int) {
		WindowsCPP._setWindowLayeredMode(window);
	}

	public static function getCursorPositionX() {
		return WindowsCPP.getCursorPositionX();
	}

	public static function getCursorPositionY() {
		return WindowsCPP.getCursorPositionY();
	}

	public static function reDefineMainWindowTitle(windowTitle:String) {
		WindowsCPP.reDefineMainWindowTitle(windowTitle);
	}

	// Windows Terminal Functions ////////////////////

	public static function clearTerminal() {
		WindowsTerminalCPP.clearTerminal();
	}

	public static function allocConsole() {
		WindowsTerminalCPP.allocConsole();
	}

	public static function hideMainWindow() {
		WindowsTerminalCPP.hideMainWindow();
	}

	public static function setConsoleTitle(title:String) {
		WindowsTerminalCPP.setConsoleTitle(title);
	}

	public static function setConsoleWindowIcon(path:String) {
		WindowsTerminalCPP.setConsoleWindowIcon(path);
	}

	public static function centerConsoleWindow() {
		WindowsTerminalCPP.centerConsoleWindow();
	}

	public static function disableResizeConsoleWindow() {
		WindowsTerminalCPP.disableResizeConsoleWindow();
	}

	public static function disableCloseConsoleWindow() {
		WindowsTerminalCPP.disableCloseConsoleWindow();
	}

	public static function maximizeConsoleWindow() {
		WindowsTerminalCPP.maximizeConsoleWindow();
	}

	public static function getConsoleWindowWidth():Int {
		return WindowsTerminalCPP.returnConsoleWindowWidth();
	}

	public static function getConsoleWindowHeight():Int {
		return WindowsTerminalCPP.returnConsoleWindowHeight();
	}

	public static function setConsoleCursorPosition(x:Int, y:Int) {
		WindowsTerminalCPP.setConsoleCursorPosition(x, y);
	}

	public static function getConsoleCursorPositionInX():Int {
		return WindowsTerminalCPP.getConsoleCursorPositionInX();
	}

	public static function getConsoleCursorPositionInY():Int {
		return WindowsTerminalCPP.getConsoleCursorPositionInY();
	}

	public static function setConsoleWindowPositionX(posX:Int) {
		WindowsTerminalCPP.setConsoleWindowPositionX(posX);
	}

	public static function setConsoleWindowPositionY(posY:Int) {
		WindowsTerminalCPP.setConsoleWindowPositionY(posY);
	}

	public static function hideConsoleWindow() {
		WindowsTerminalCPP.hideConsoleWindow();
	}

	/////////////////////////////////
	//@:noPrivateAccess {
		private static var _windowsWallpaperPath:String = null;
		private static var changedWallpaper:Bool = false;
	//}
	public static function changeWindowsWallpaper(path:String) {
		var allPath:String = Sys.getCwd() + path;
		allPath = allPath.split("\\").join("/");
		setWallpaper(allPath);
		changedWallpaper = true;
		trace("Wallpaper changed to: " + allPath);
	}

	/*public static function screenCapture(path:String) {
		var allPath:String = Sys.getCwd() + path;
		allPath = allPath.split("\\").join("/");
		screenCapture(allPath);
		trace("Screenshot saved to: " + allPath);
	}*/

	public static function saveCurrentWindowsWallpaper() {
		var path = '${Sys.getEnv("AppData")}\\Microsoft\\Windows\\Themes\\TranscodedWallpaper';

		if (path != null) {
			trace("Wallpaper Path: " + path);
			trace("Saving the path in a private variable...");
			_windowsWallpaperPath = path;
		} else {
			trace("Error! Could not save the wallpaper path!");
		}
	}

	public static function setOldWindowsWallpaper() {
		setWallpaper(_windowsWallpaperPath);
		trace("Wallpaper changed to: " + _windowsWallpaperPath);
	}

	public static function sendWindowsNotification(title:String, desc:String) {
		var powershellCommand = "powershell -Command \"& {$ErrorActionPreference = 'Stop';"
			+ "$title = '"
			+ desc
			+ "';"
			+ "[Windows.UI.Notifications.ToastNotificationManager, Windows.UI.Notifications, ContentType = WindowsRuntime] > $null;"
			+ "$template = [Windows.UI.Notifications.ToastNotificationManager]::GetTemplateContent([Windows.UI.Notifications.ToastTemplateType]::ToastText01);"
			+ "$toastXml = [xml] $template.GetXml();"
			+ "$toastXml.GetElementsByTagName('text').AppendChild($toastXml.CreateTextNode($title)) > $null;"
			+ "$xml = New-Object Windows.Data.Xml.Dom.XmlDocument;"
			+ "$xml.LoadXml($toastXml.OuterXml);"
			+ "$toast = [Windows.UI.Notifications.ToastNotification]::new($xml);"
			+ "$toast.Tag = 'Test1';"
			+ "$toast.Group = 'Test2';"
			+ "$notifier = [Windows.UI.Notifications.ToastNotificationManager]::CreateToastNotifier('"
			+ title
			+ "');"
			+ "$notifier.Show($toast);}\"";

		if (title != null && title != "" && desc != null && desc != "")
			new Process(powershellCommand);
	}

	public static function resetWindowsFuncs() {
		hideTaskbar(false);
		hideDesktopIcons(false);
		moveDesktopWindowsInXY(0, 0);
		setTaskBarAlpha(1);
		setDesktopWindowsAlpha(1);

		if (changedWallpaper) {
			setOldWindowsWallpaper();
			changedWallpaper = false;
		}
	}

	/*public static function setWindowBorderColor(rgb:Array<Int>) {
		setWindowBorderColor(rgb[0], rgb[1], rgb[2]);
	}*/
}
#else
#error "SL-Windows-API supports only Windows platform"
#end
