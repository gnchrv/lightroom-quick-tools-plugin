# Adobe Lightroom Classic Plugin: Quick Tools

![Lua](https://img.shields.io/badge/Lua-5.1-blue) ![Lightroom SDK](https://img.shields.io/badge/Lightroom%20SDK-10.0-informational) ![Lightroom](https://img.shields.io/badge/Lightroom-6%2B-lightgrey) ![License](https://img.shields.io/badge/License-MIT-green)

> A Lightroom Classic plugin that nudges Develop sliders from the menu, so the steps can be put on keyboard shortcuts.

Lightroom has no direct shortcuts for Contrast, Highlights, Shadows, Whites, Blacks and some other controls. This plugin adds a menu command for each direction of those sliders. Menu items can be assigned shortcuts via macOS System Settings, and then the sliders move by a fixed step from the keyboard.

<img width="1230" height="893" alt="image" src="https://github.com/user-attachments/assets/953726f8-dd63-4634-ab8d-9e3ae4974e8b" />


## Installation

Copy the `QuickTools.lrdevplugin` folder anywhere, then add it in Lightroom under `File → Plug-in Manager → Add`.

## How it works

Every command calls `AdjustSetting.lua`. It takes the photo under the cursor, switches to Develop if you are elsewhere, reads the current slider value, adds the step and clamps the result to the slider range. The write goes into the photo's history, so undo works as usual.

The step is half a stop for Exposure and 5 units for the rest. To change it, edit the number in the corresponding command file, for example `IncreaseShadows.lua`.

## Usage

`File → Plug-in Extras`, then the command you need.

## Assigning shortcuts on macOS

Lightroom cannot bind plugin commands to keys, but macOS can. Go to `System Settings → Keyboard → Keyboard Shortcuts → App Shortcuts`, add an entry for Lightroom Classic and type the menu title of the command.

**The title needs three leading spaces**. Lightroom puts plugin commands under a header with the plugin name and indents them, so the command is `   Increase Whites`, not `Increase Whites`. Without the spaces the shortcut will not work.

The spaces are easy to lose in the System Settings field. As an alternative, the shortcut can be set from the Terminal to ensure the spaces are preserved:

```sh
defaults write com.adobe.LightroomClassicCC7 NSUserKeyEquivalents -dict-add "   Increase Whites" '"^]"'
```

`@` is Command, `^` is Control, `~` is Option, `$` is Shift. The value is quoted twice, otherwise `defaults` reads `^]` as a plist of its own.

Restart Lightroom afterwards. macOS applies these shortcuts while an app loads its menus, so a running Lightroom ignores them.
