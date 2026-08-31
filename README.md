# Quick Tools

![Lua](https://img.shields.io/badge/Lua-5.1-blue) ![Lightroom SDK](https://img.shields.io/badge/Lightroom%20SDK-10.0-informational) ![Lightroom](https://img.shields.io/badge/Lightroom-6%2B-lightgrey) ![License](https://img.shields.io/badge/License-MIT-green)

> A Lightroom Classic plugin that nudges Develop sliders from the menu, so the steps can be put on keyboard shortcuts.

Lightroom has no direct shortcuts for Contrast, Highlights, Shadows, Whites, Blacks and some other controls. This plugin adds a menu command for each direction of those sliders. Menu items can be assigned shortcuts via macOS System Settings, and then the sliders move by a fixed step from the keyboard.

## Installation

Copy the `QuickTools.lrdevplugin` folder anywhere, then add it in Lightroom under `File → Plug-in Manager → Add`.

## How it works

Every command calls `AdjustSetting.lua`. It takes the photo under the cursor, switches to Develop if you are elsewhere, reads the current slider value, adds the step and clamps the result to the slider range. The write goes into the photo's history, so undo works as usual.

The step is half a stop for Exposure and 5 units for the rest. To change it, edit the number in the corresponding command file, for example `IncreaseShadows.lua`.

## Usage

`File → Plug-in Extras`, then the command you need. To use a shortcut on macOS, add the command title under `System Settings → Keyboard → Keyboard Shortcuts → App Shortcuts` for Lightroom Classic.
