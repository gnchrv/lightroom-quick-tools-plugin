--- Plugin manifest
-- Lightroom reads this file when the plugin loads and builds the menu from it

return {

    -- The SDK version
    LrSdkVersion = 10.0,

    -- The oldest Lightroom supporting it
    LrSdkMinimumVersion = 6.0,

    -- An ID and the plugin name
    LrToolkitIdentifier = 'io.goncharov.quicktools',
    LrPluginName = 'Quick Tools',

    -- The plugin version shown in the Plug-in Manager
    VERSION = { major = 1, minor = 0, revision = 0, build = 0 },

    -- Menu entries added to the system menu in the File → Plug-in Extras.
    -- Accompanied by the relevant files with actual commands
    LrExportMenuItems = {
        {
            title = 'Increase Exposure',
            file = 'IncreaseExposure.lua'
        },
        {
            title = 'Decrease Exposure',
            file = 'DecreaseExposure.lua'
        }
    }
}
