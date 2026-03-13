local events = require('events')

-- Trigger lazy loading immediately when this module loads
events.ScheduledWrapEvent(events.Event.Oil, function()
    require('cfg.oil')
end)

events.ScheduledWrapEvent(events.Event.Mini, function()
    require('cfg.mini')
end)

events.ScheduledWrapEvent(events.Event.Telescope, function()
    require('cfg.telescope')
end)
