--- Exposure nudge shared by both menu commands

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

-- The darkest and lightest exposure values available in Lightroom. Measured in stops
local MIN_EXPOSURE = -5
local MAX_EXPOSURE = 5

--- Adds `delta` stops to the exposure of the photo the user is on
-- Returns immediately: the change happens inside an async task, because catalog and Develop calls block and Lightroom kills the main thread if you block it
-- @tparam number delta stops to add, negative to darken
-- @treturn nil
local function adjustExposure(delta)

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

        -- Get the current exposure in stops, 0 if Lightroom returns nothing
        local current = LrDevelopController.getValue('Exposure') or 0

        -- Apply the delta and clamp it into Lightroom’s range
        local target = math.max(MIN_EXPOSURE, math.min(MAX_EXPOSURE, current + delta))

        -- Write the new value. It will land in the photo’s history
        LrDevelopController.setValue('Exposure', target)
    end)
end

-- Return the module that is the function itself
return adjustExposure