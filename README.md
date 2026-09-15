# Adobe Lightroom Classic Plugin: Quick Tools

![Lua](https://img.shields.io/badge/Lua-5.1-blue) ![Lightroom SDK](https://img.shields.io/badge/Lightroom%20SDK-10.0-informational) ![Lightroom](https://img.shields.io/badge/Lightroom-6%2B-lightgrey) ![License](https://img.shields.io/badge/License-MIT-green)

> A Lightroom Classic plugin that nudges Develop sliders from the menu, so the steps can be put on keyboard shortcuts.

Lightroom has no direct shortcuts for Temperature, Tint, Contrast, Highlights, Shadows, Whites, Blacks, Texture, Clarity, Dehaze, Vibrance, Saturation and some other controls. This plugin adds menu commands that move those sliders in either direction, by one of three step sizes: `Exposure: Increase a Bit`, `Exposure: Increase`, `Exposure: Increase a Lot` and the same downwards, for each of the thirteen sliders. Menu items can be assigned shortcuts via macOS System Settings, and then the sliders move from the keyboard.

<img width="1316" height="1075" alt="A screenshot showcasing available plugins commands" src="https://github.com/user-attachments/assets/85b21d3c-cb9a-4daf-98fd-277fac04230b" />


## Installation

Copy the `QuickTools.lrdevplugin` folder anywhere, then add it in Lightroom under `File → Plug-in Manager → Add`.

## Usage

`File → Plug-in Extras`, then the command you need.

## Assigning shortcuts on macOS

Go to `System Settings → Keyboard → Keyboard Shortcuts → App Shortcuts`, add an entry for Lightroom Classic and type the menu title of the command.

**The title needs three leading spaces**. Lightroom puts plugin commands under a header with the plugin name and indents them, so the command is `   Whites: Increase` (with three spaces before the letter `W`; may not be visible on GitHub), not `Whites: Increase`. Without the spaces the shortcut will not work.

The spaces are easy to lose in the System Settings field. As an alternative, the shortcut can be set from the Terminal to ensure the spaces are preserved:

```sh
defaults write com.adobe.LightroomClassicCC7 NSUserKeyEquivalents -dict-add "   Whites: Increase" '"^]"'
```

`@` is Command, `^` is Control, `~` is Option, `$` is Shift. The value is quoted twice, otherwise `defaults` reads `^]` as a plist of its own.

Restart Lightroom afterwards. macOS applies these shortcuts while an app loads its menus, so a running Lightroom ignores them.

## Plugin architecture

Every command calls `adjust-setting.lua` with a slider, a step size and a direction. It takes the photo under the cursor, switches to Develop if you are elsewhere, reads the current slider value, adds the step and clamps the result to the range Lightroom reports for that photo. The write goes into the photo's history, so undo works as usual.

## Adding commands

Lightroom hands a menu command's file no arguments, so every command needs a file of its own. Each slider has a folder in `commands/` with six files, named like `increase-a-lot.lua`, and each file is one call to `adjust-setting.lua`. The menu is listed by hand in `LrExportMenuItems` in `Info.lua`. Lightroom loads that file without `require`, so the list has to be plain data.

To add a slider:

1. Copy one of the folders in `commands/`, rename it after the new slider and change the slider name in its six files
2. Add six entries for them to `LrExportMenuItems` in `Info.lua`, in the order they should appear in the menu
3. Add the slider to `RANGES` in `adjust-setting.lua`, and override its steps in `steps.lua` if the defaults do not suit it
4. Restart Lightroom, since the menu is only read at launch

Nothing checks that a `file` path in `Info.lua` matches a real file, so a typo there shows up only when you click the command.

## Steps

The step sizes live in `steps.lua` and are yours to change:

```lua
return {
    default = { small = 5, medium = 15, large = 30 },
    overrides = {
        Exposure = { small = 0.15, medium = 0.5, large = 1.5 },
        Temperature = { small = 75, medium = 250, large = 600 }
    }
}
```

`small` is the `a Bit` command, `medium` the plain one and `large` the `a Lot` one. Every slider uses the `default` steps unless it has an entry under `overrides`. An override only needs the steps it changes, so `Shadows = { large = 50 }` keeps the default `small` and `medium`. Both directions of a slider use the same ones, so `Shadows: Increase` and `Shadows: Decrease` always move by the same amount. Exposure is measured in stops and Temperature in Kelvin on a raw file, Tint runs -150 to 150, and the rest use Lightroom's own -100 to 100 units. Reload the plugin in the Plug-in Manager after editing the file.
