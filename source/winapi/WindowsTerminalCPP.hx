package winapi;

/**
 * This file is in charge of providing some Windows terminal functions 
 * 
 * Author: Slushi
 */

#if windows
@:cppFileCode('
#include <Windows.h>
#include <windowsx.h>
#include <cstdio>
#include <iostream>
#include <tchar.h>
#include <dwmapi.h>
#include <winuser.h>
#include <winternl.h>
#include <Shlobj.h>
#include <commctrl.h>
#include <string>

#define UNICODE

#pragma comment(lib, "Dwmapi")
#pragma comment(lib, "ntdll.lib")
#pragma comment(lib, "User32.lib")
#pragma comment(lib, "Shell32.lib")
#pragma comment(lib, "gdi32.lib")
')
class WindowsTerminalCPP
{
	@:functionCode('
        system("CLS");
        std::cout<< "" <<std::flush;
    ')
	public static function clearTerminal()
	{
	}

	@:functionCode('
        if (!AllocConsole())
            return;

        freopen("CONIN$", "r", stdin);
        freopen("CONOUT$", "w", stdout);
        freopen("CONOUT$", "w", stderr);

        HANDLE output = GetStdHandle(STD_OUTPUT_HANDLE);
        SetConsoleMode(output, ENABLE_PROCESSED_OUTPUT | ENABLE_VIRTUAL_TERMINAL_PROCESSING);
    ')
	public static function allocConsole()
	{
	}

	@:functionCode('
        HWND hChild = GetActiveWindow();
        ShowWindow(hChild, SW_HIDE);
    ')
	public static function hideMainWindow()
	{
	}

	@:functionCode('
        SetConsoleTitleA(text);
    ')
	public static function setConsoleTitle(text:String)
	{
	}

	@:functionCode('
        HWND window = GetConsoleWindow();
        HICON smallIcon = (HICON) LoadImage(NULL, path, IMAGE_ICON, 16, 16, LR_LOADFROMFILE);
        HICON icon = (HICON) LoadImage(NULL, path, IMAGE_ICON, 0, 0, LR_LOADFROMFILE | LR_DEFAULTSIZE);
        SendMessage(window, WM_SETICON, ICON_SMALL, (LPARAM)smallIcon);
        SendMessage(window, WM_SETICON, ICON_BIG, (LPARAM)icon);    
    ')
	public static function setConsoleWindowIcon(path:String)
	{
	}

	@:functionCode('
        HWND hwnd = GetConsoleWindow();
        int screenWidth = GetSystemMetrics(SM_CXSCREEN);
        int screenHeight = GetSystemMetrics(SM_CYSCREEN);
        
        RECT windowRect;
        GetWindowRect(hwnd, &windowRect);
        int windowWidth = windowRect.right - windowRect.left;
        int windowHeight = windowRect.bottom - windowRect.top;
        
        int centerX = (screenWidth - windowWidth) / 2;
        int centerY = (screenHeight - windowHeight) / 2;
        
        SetWindowPos(hwnd, NULL, centerX, centerY, 0, 0, SWP_NOSIZE | SWP_NOZORDER);
    ')
	public static function centerConsoleWindow()
	{
	}

	@:functionCode('
        HWND hwnd = GetConsoleWindow();
        LONG style = GetWindowLongPtrW(hwnd, GWL_STYLE);
        style &= ~(WS_THICKFRAME | WS_MAXIMIZEBOX); 
        SetWindowLongPtrW(hwnd, GWL_STYLE, style);    
    ')
	public static function disableResizeConsoleWindow()
	{
	}

	@:functionCode('
        HWND hwnd = GetConsoleWindow();
        HMENU hmenu = GetSystemMenu(hwnd, FALSE);
        EnableMenuItem(hmenu, SC_CLOSE, MF_GRAYED);
    ')
	public static function disableCloseConsoleWindow()
	{
	}

	@:functionCode('
        HWND hwnd = GetConsoleWindow();
        ShowWindow(hwnd, SW_MAXIMIZE);
    ')
	public static function maximizeConsoleWindow()
	{
	}

	@:functionCode('
        COORD pos = {x, y};
        HANDLE output = GetStdHandle(STD_OUTPUT_HANDLE);
        SetConsoleCursorPosition(output, pos);
    ')
	public static function setConsoleCursorPosition(x:Int, y:Int)
	{
	}

	@:functionCode('
        // Coño esta potente la IA eh?	
        HANDLE output = GetStdHandle(STD_OUTPUT_HANDLE);
        CONSOLE_SCREEN_BUFFER_INFO screenBufferInfo;
        GetConsoleScreenBufferInfo(output, &screenBufferInfo);
        return screenBufferInfo.dwCursorPosition.X;
    ')
	public static function getConsoleCursorPositionInX():Int
	{
		return 0;
	}

	@:functionCode('
        // Coño esta potente la IA eh?	
        HANDLE output = GetStdHandle(STD_OUTPUT_HANDLE);
        CONSOLE_SCREEN_BUFFER_INFO screenBufferInfo;
        GetConsoleScreenBufferInfo(output, &screenBufferInfo);
        return screenBufferInfo.dwCursorPosition.Y;
    ')
	public static function getConsoleCursorPositionInY():Int
	{
		return 0;
	}

	@:functionCode('
        HWND hwnd = GetConsoleWindow();
        SetWindowPos(hwnd, NULL, posX, NULL, 0, 0, SWP_NOSIZE | SWP_NOZORDER);
    ')
	public static function setConsoleWindowPositionX(posX:Int):Int
	{
		return 0;
	}

	@:functionCode('
        HWND hwnd = GetConsoleWindow();
        SetWindowPos(hwnd, NULL, NULL, posY, 0, 0, SWP_NOSIZE | SWP_NOZORDER);
    ')
	public static function setConsoleWindowPositionY(posY:Int):Int
	{
		return 0;
	}

	@:functionCode('
        HWND hwnd = GetConsoleWindow();
		RECT rect;

		GetWindowRect(hwnd, &rect);

		int x = rect.left;

		return x;
	')
	public static function returnConsoleWindowWidth():Int
	{
		return 0;
	}

	@:functionCode('
        HWND hwnd = GetConsoleWindow();
		RECT rect;

		GetWindowRect(hwnd, &rect);

		int y = rect.top;

		return y;
	')
	public static function returnConsoleWindowHeight():Int
	{
		return 0;
	}

	@:functionCode('
        HWND hChild = GetConsoleWindow();
        ShowWindow(hChild, SW_HIDE);
    ')
	public static function hideConsoleWindow()
	{
	}
}
#else
#error "SL-Windows-API supports only Windows platform"
#end