--- Defines how far each command moves its slider

return {

    -- The default steps every slider uses unless it has an override below
    default = { small = 5, medium = 15, large = 30 },

    -- The sliders that differ from the default, each naming only the steps it changes
    overrides = {

        -- An override for Exposure, as it’s measured in stops, not Lightroom's −100 to 100 units
        Exposure = { small = 0.15, medium = 0.5, large = 1.5 }
    }
}
