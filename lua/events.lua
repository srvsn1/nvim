vim.api.nvim_create_augroup("PersonalEventGroup", { clear = true })

-- Event groups - each represents a plugin/feature with Pre/Post events
local Event = {
    Oil = "Oil",
    Mini = "Mini",
    Telescope = "Telescope",
    Git = "Git"
}

-- Helper functions to generate Pre/Post event names
local function getPreEvent(eventGroup)
    return "PreLoad-" .. eventGroup
end

local function getPostEvent(eventGroup)
    return "PostLoad-" .. eventGroup
end

-- Low-level event registration
local function RegisterEvent(event, callback)
    vim.api.nvim_create_autocmd("User", {
        group = "PersonalEventGroup",
        pattern = event,
        callback = callback,
    })
end

-- High-level event registration for Pre/Post
local function RegisterPreEvent(eventGroup, callback)
    RegisterEvent(getPreEvent(eventGroup), callback)
end

local function RegisterPostEvent(eventGroup, callback)
    RegisterEvent(getPostEvent(eventGroup), callback)
end

local function TriggerEvent(event)
    vim.api.nvim_exec_autocmds("User", { pattern = event })
end

-- Wrap a handler with Pre/Post events for an event group
local function WrapEvent(eventGroup, handler)
    TriggerEvent(getPreEvent(eventGroup))
    handler()
    TriggerEvent(getPostEvent(eventGroup))
end

local function ScheduledWrapEvent(eventGroup, handler)
    vim.schedule(function()
        WrapEvent(eventGroup, handler)
    end)
end

return {
    Event = Event,
    RegisterEvent = RegisterEvent,
    RegisterPreEvent = RegisterPreEvent,
    RegisterPostEvent = RegisterPostEvent,
    TriggerEvent = TriggerEvent,
    WrapEvent = WrapEvent,
    ScheduledWrapEvent = ScheduledWrapEvent,
}
