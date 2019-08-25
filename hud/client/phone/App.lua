local super = Class("App", Container, function()
    static.getInstance = function()
        return LuaObject.getSingleton(static)
    end
end).getSuperclass()

function App:init()
    super.init(self)
    self.fontDefault = dxCreateFont("gfx/phone/windows.TTF")
    return self
end

function App:unloadMe()
    self:setVisible(false)
    Toolkit.getInstance():remove(self)
    self:dispose()
end
function App:loadApp(app)
    if app then
       Phone.getInstance():loadApp(app)
    end
end
