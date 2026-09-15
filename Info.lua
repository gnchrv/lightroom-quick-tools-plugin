--- Plugin manifest
-- Lightroom reads this file when the plugin loads and builds the menu from it. It loads the file with no `require`, so everything here is plain data

return {

    -- The SDK version
    LrSdkVersion = 10.0,

    -- The oldest Lightroom supporting it
    LrSdkMinimumVersion = 6.0,

    -- An ID and the plugin name
    LrToolkitIdentifier = 'io.goncharov.quicktools',
    LrPluginName = 'Quick Tools',

    -- The plugin version shown in the Plug-in Manager
    VERSION = { major = 1, minor = 2, revision = 0, build = 0 },

    -- Menu entries added to the system menu in the File → Plug-in Extras
    -- Each entry points at its command file in `commands/<slider>/`
    LrExportMenuItems = {
        {
            title = 'Exposure: Increase a Bit',
            file = 'commands/exposure/increase-a-bit.lua'
        },
        {
            title = 'Exposure: Increase',
            file = 'commands/exposure/increase.lua'
        },
        {
            title = 'Exposure: Increase a Lot',
            file = 'commands/exposure/increase-a-lot.lua'
        },
        {
            title = 'Exposure: Decrease a Bit',
            file = 'commands/exposure/decrease-a-bit.lua'
        },
        {
            title = 'Exposure: Decrease',
            file = 'commands/exposure/decrease.lua'
        },
        {
            title = 'Exposure: Decrease a Lot',
            file = 'commands/exposure/decrease-a-lot.lua'
        },
        {
            title = 'Contrast: Increase a Bit',
            file = 'commands/contrast/increase-a-bit.lua'
        },
        {
            title = 'Contrast: Increase',
            file = 'commands/contrast/increase.lua'
        },
        {
            title = 'Contrast: Increase a Lot',
            file = 'commands/contrast/increase-a-lot.lua'
        },
        {
            title = 'Contrast: Decrease a Bit',
            file = 'commands/contrast/decrease-a-bit.lua'
        },
        {
            title = 'Contrast: Decrease',
            file = 'commands/contrast/decrease.lua'
        },
        {
            title = 'Contrast: Decrease a Lot',
            file = 'commands/contrast/decrease-a-lot.lua'
        },
        {
            title = 'Highlights: Increase a Bit',
            file = 'commands/highlights/increase-a-bit.lua'
        },
        {
            title = 'Highlights: Increase',
            file = 'commands/highlights/increase.lua'
        },
        {
            title = 'Highlights: Increase a Lot',
            file = 'commands/highlights/increase-a-lot.lua'
        },
        {
            title = 'Highlights: Decrease a Bit',
            file = 'commands/highlights/decrease-a-bit.lua'
        },
        {
            title = 'Highlights: Decrease',
            file = 'commands/highlights/decrease.lua'
        },
        {
            title = 'Highlights: Decrease a Lot',
            file = 'commands/highlights/decrease-a-lot.lua'
        },
        {
            title = 'Shadows: Increase a Bit',
            file = 'commands/shadows/increase-a-bit.lua'
        },
        {
            title = 'Shadows: Increase',
            file = 'commands/shadows/increase.lua'
        },
        {
            title = 'Shadows: Increase a Lot',
            file = 'commands/shadows/increase-a-lot.lua'
        },
        {
            title = 'Shadows: Decrease a Bit',
            file = 'commands/shadows/decrease-a-bit.lua'
        },
        {
            title = 'Shadows: Decrease',
            file = 'commands/shadows/decrease.lua'
        },
        {
            title = 'Shadows: Decrease a Lot',
            file = 'commands/shadows/decrease-a-lot.lua'
        },
        {
            title = 'Whites: Increase a Bit',
            file = 'commands/whites/increase-a-bit.lua'
        },
        {
            title = 'Whites: Increase',
            file = 'commands/whites/increase.lua'
        },
        {
            title = 'Whites: Increase a Lot',
            file = 'commands/whites/increase-a-lot.lua'
        },
        {
            title = 'Whites: Decrease a Bit',
            file = 'commands/whites/decrease-a-bit.lua'
        },
        {
            title = 'Whites: Decrease',
            file = 'commands/whites/decrease.lua'
        },
        {
            title = 'Whites: Decrease a Lot',
            file = 'commands/whites/decrease-a-lot.lua'
        },
        {
            title = 'Blacks: Increase a Bit',
            file = 'commands/blacks/increase-a-bit.lua'
        },
        {
            title = 'Blacks: Increase',
            file = 'commands/blacks/increase.lua'
        },
        {
            title = 'Blacks: Increase a Lot',
            file = 'commands/blacks/increase-a-lot.lua'
        },
        {
            title = 'Blacks: Decrease a Bit',
            file = 'commands/blacks/decrease-a-bit.lua'
        },
        {
            title = 'Blacks: Decrease',
            file = 'commands/blacks/decrease.lua'
        },
        {
            title = 'Blacks: Decrease a Lot',
            file = 'commands/blacks/decrease-a-lot.lua'
        },
        {
            title = 'Texture: Increase a Bit',
            file = 'commands/texture/increase-a-bit.lua'
        },
        {
            title = 'Texture: Increase',
            file = 'commands/texture/increase.lua'
        },
        {
            title = 'Texture: Increase a Lot',
            file = 'commands/texture/increase-a-lot.lua'
        },
        {
            title = 'Texture: Decrease a Bit',
            file = 'commands/texture/decrease-a-bit.lua'
        },
        {
            title = 'Texture: Decrease',
            file = 'commands/texture/decrease.lua'
        },
        {
            title = 'Texture: Decrease a Lot',
            file = 'commands/texture/decrease-a-lot.lua'
        },
        {
            title = 'Clarity: Increase a Bit',
            file = 'commands/clarity/increase-a-bit.lua'
        },
        {
            title = 'Clarity: Increase',
            file = 'commands/clarity/increase.lua'
        },
        {
            title = 'Clarity: Increase a Lot',
            file = 'commands/clarity/increase-a-lot.lua'
        },
        {
            title = 'Clarity: Decrease a Bit',
            file = 'commands/clarity/decrease-a-bit.lua'
        },
        {
            title = 'Clarity: Decrease',
            file = 'commands/clarity/decrease.lua'
        },
        {
            title = 'Clarity: Decrease a Lot',
            file = 'commands/clarity/decrease-a-lot.lua'
        },
        {
            title = 'Dehaze: Increase a Bit',
            file = 'commands/dehaze/increase-a-bit.lua'
        },
        {
            title = 'Dehaze: Increase',
            file = 'commands/dehaze/increase.lua'
        },
        {
            title = 'Dehaze: Increase a Lot',
            file = 'commands/dehaze/increase-a-lot.lua'
        },
        {
            title = 'Dehaze: Decrease a Bit',
            file = 'commands/dehaze/decrease-a-bit.lua'
        },
        {
            title = 'Dehaze: Decrease',
            file = 'commands/dehaze/decrease.lua'
        },
        {
            title = 'Dehaze: Decrease a Lot',
            file = 'commands/dehaze/decrease-a-lot.lua'
        },
        {
            title = 'Vibrance: Increase a Bit',
            file = 'commands/vibrance/increase-a-bit.lua'
        },
        {
            title = 'Vibrance: Increase',
            file = 'commands/vibrance/increase.lua'
        },
        {
            title = 'Vibrance: Increase a Lot',
            file = 'commands/vibrance/increase-a-lot.lua'
        },
        {
            title = 'Vibrance: Decrease a Bit',
            file = 'commands/vibrance/decrease-a-bit.lua'
        },
        {
            title = 'Vibrance: Decrease',
            file = 'commands/vibrance/decrease.lua'
        },
        {
            title = 'Vibrance: Decrease a Lot',
            file = 'commands/vibrance/decrease-a-lot.lua'
        },
        {
            title = 'Saturation: Increase a Bit',
            file = 'commands/saturation/increase-a-bit.lua'
        },
        {
            title = 'Saturation: Increase',
            file = 'commands/saturation/increase.lua'
        },
        {
            title = 'Saturation: Increase a Lot',
            file = 'commands/saturation/increase-a-lot.lua'
        },
        {
            title = 'Saturation: Decrease a Bit',
            file = 'commands/saturation/decrease-a-bit.lua'
        },
        {
            title = 'Saturation: Decrease',
            file = 'commands/saturation/decrease.lua'
        },
        {
            title = 'Saturation: Decrease a Lot',
            file = 'commands/saturation/decrease-a-lot.lua'
        }
    }
}
