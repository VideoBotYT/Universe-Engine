function onCreatePost()
    addHaxeLibrary('Application', 'lime.app')
    addHaxeLibrary('Image', 'lime.graphics')
end

function onEvent(name, v1, v2)
	if name == 'Change window name and icon' then
        nameevent = v1
        icon = v2
        if nameevent ~= nil then
            setPropertyFromClass("openfl.Lib", "application.window.title", nameevent)
        end
        if icon ~= nil then
            runHaxeCode("Application.current.window.setIcon(Image.fromFile(Paths.modFolders('images/"..icon..".png')));")
        end
    end
end