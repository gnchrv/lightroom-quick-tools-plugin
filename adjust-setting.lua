--- Develop slider nudge shared by every menu command

-- The task scheduler, the only legal way to run slow SDK calls
local LrTasks = import 'LrTasks'

-- Message boxes, used here for the "no photo" error
local LrDialogs = import 'LrDialogs'

-- The entry point to the catalog
local LrApplication = import 'LrApplication'

-- Reads and switches the current module
local LrApplicationView = import 'LrApplicationView'

-- Reads and writes Develop sliders
local LrDevelopController = import 'LrDevelopController'

-- How far each step moves each slider, as set by the user in steps.lua
local STEPS = require 'steps'

-- The range of every slider this plugin touches. Exposure is measured in stops, the rest in Lightroom’s own -100 to 100 units
local RANGES = {
    Exposure   = { min = -5,   max = 5 },
    Contrast   = { min = -100, max = 100 },
    Highlights = { min = -100, max = 100 },
    Shadows    = { min = -100, max = 100 },
    Whites     = { min = -100, max = 100 },
    Blacks     = { min = -100, max = 100 }
}

-- How each step shows up at the end of a menu command title, so errors can name the command the user actually clicked
local COMMAND_SUFFIXES = {
    small  = ' a Bit',
    medium = '',
    large  = ' a Lot'
}

--- Nudges one Develop slider of the photo the user is on
-- Returns immediately: the change happens inside an async task, because catalog and Develop calls block and Lightroom kills the main thread if you block it
-- @tparam string setting the Develop parameter name, a key of RANGES
-- @tparam string step which of the three step sizes to use: 'small', 'medium' or 'large'
-- @tparam number direction 1 to raise the slider, -1 to lower it
-- @treturn nil
local function adjustSetting(setting, step, direction)

    -- The limits of the slider being nudged
    local range = RANGES[setting]

    -- Bail out loudly if the caller named a slider this plugin does not know
    if not range then
        LrDialogs.showError('Unknown Develop setting: ' .. tostring(setting))
        return
    end

    -- The steps this slider overrides, if any
    local overrides = STEPS.overrides[setting] or {}

    -- How far this command moves the slider, before the direction is applied
    local amount = overrides[step] or STEPS.default[step]

    -- Bail out loudly if steps.lua has no number for this step, naming the menu command the user picked rather than the step's internal name
    if type(amount) ~= 'number' then
        local command = table.concat({
            setting,
            ': ',
            direction > 0 and 'Increase' or 'Decrease',
            COMMAND_SUFFIXES[step] or ''
        })
        LrDialogs.showError('Can’t run “' .. command .. '”: add a number for “' .. tostring(step) .. '” to steps.lua')
        return
    end

    -- The signed change to apply
    local delta = amount * direction

    -- Everything below runs off the main thread
    LrTasks.startAsyncTask(function()

        -- Get the photo under the cursor in Library, or the one open in Develop
        local photo = LrApplication.activeCatalog():getTargetPhoto()

        -- If nothing is selected, show an error
        if not photo then
            LrDialogs.showError('Select a photo first')
            return
        end

        -- If the Develop module is not active, enable it
        if LrApplicationView.getCurrentModuleName() ~= 'develop' then
            LrApplicationView.switchToModule('develop')

            -- Wait a bit, as the switch is not instant and the SDK gives no callback
            LrTasks.sleep(0.3)
        end

        -- Get the current value, 0 if Lightroom returns nothing
        local current = LrDevelopController.getValue(setting) or 0

        -- Apply the delta and clamp it into Lightroom’s range
        local target = math.max(range.min, math.min(range.max, current + delta))

        -- Write the new value. It will land in the photo’s history
        LrDevelopController.setValue(setting, target)
    end)
end

-- Return the module that is the function itself
return adjustSetting
