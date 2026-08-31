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

-- The range of every slider this plugin touches. Exposure is measured in stops, the rest in Lightroom’s own -100 to 100 units
local RANGES = {
    Exposure   = { min = -5,   max = 5 },
    Contrast   = { min = -100, max = 100 },
    Highlights = { min = -100, max = 100 },
    Shadows    = { min = -100, max = 100 },
    Whites     = { min = -100, max = 100 },
    Blacks     = { min = -100, max = 100 }
}

--- Adds `delta` to one Develop slider of the photo the user is on
-- Returns immediately: the change happens inside an async task, because catalog and Develop calls block and Lightroom kills the main thread if you block it
-- @tparam string setting the Develop parameter name, a key of RANGES
-- @tparam number delta amount to add, negative to go down
-- @treturn nil
local function adjustSetting(setting, delta)

    -- The limits of the slider being nudged
    local range = RANGES[setting]

    -- Bail out loudly if the caller named a slider this plugin does not know
    if not range then
        LrDialogs.showError('Unknown Develop setting: ' .. tostring(setting))
        return
    end

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
