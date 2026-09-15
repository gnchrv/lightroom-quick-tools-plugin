--- Develop slider nudge shared by every menu command

-- The task scheduler, the only legal way to run slow SDK calls
local LrTasks = import 'LrTasks'

-- Runs an async task with a context that failure handlers can attach to
local LrFunctionContext = import 'LrFunctionContext'

-- Message boxes, used for every error this command can hit
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
    Blacks     = { min = -100, max = 100 },
    Texture    = { min = -100, max = 100 },
    Clarity    = { min = -100, max = 100 },
    Dehaze     = { min = -100, max = 100 },
    Vibrance   = { min = -100, max = 100 },
    Saturation = { min = -100, max = 100 }
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

    -- The steps this slider overrides, if any. Either table may be missing, as steps.lua is edited by hand
    local overrides = (STEPS.overrides or {})[setting] or {}

    -- How far this command moves the slider, before the direction is applied
    local amount = overrides[step] or (STEPS.default or {})[step]

    -- Bail out loudly if steps.lua has no positive number for this step, naming the menu command the user picked. A negative number would silently flip the direction
    if type(amount) ~= 'number' or amount <= 0 then
        local command = table.concat({
            setting,
            ': ',
            direction > 0 and 'Increase' or 'Decrease',
            COMMAND_SUFFIXES[step] or ''
        })
        LrDialogs.showError('Can’t run “' .. command .. '”: add a positive number for “' .. tostring(step) .. '” to steps.lua')
        return
    end

    -- The signed change to apply
    local delta = amount * direction

    -- Everything below runs off the main thread
    LrFunctionContext.postAsyncTaskWithContext('adjustSetting', function(context)

        -- Show any error thrown below in a dialog, as a plain async task swallows it and the command just does nothing
        LrDialogs.attachErrorDialogToFunctionContext(context)

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

            -- Wait until the switch lands, as it is not instant and the SDK gives no callback, but give up after about two seconds
            for _ = 1, 40 do
                if LrApplicationView.getCurrentModuleName() == 'develop' then break end
                LrTasks.sleep(0.05)
            end
        end

        -- Get the current value, 0 if Lightroom returns nothing
        local current = LrDevelopController.getValue(setting) or 0

        -- Apply the delta and clamp it into Lightroom’s range
        local target = math.max(range.min, math.min(range.max, current + delta))

        -- Write the new value, wrapped in a tracking session. A bare setValue behaves like a slider mid-drag, so Lightroom waits for the value to settle before it records a history step and undo does nothing for a second or two. Bracketing the write looks to Lightroom like a short drag that ends at once, which should make it record the step sooner
        LrDevelopController.startTracking(setting)
        LrDevelopController.setValue(setting, target)
        LrDevelopController.stopTracking()
    end)
end

-- Return the module that is the function itself
return adjustSetting
