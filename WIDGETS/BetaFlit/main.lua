---- #########################################################################
---- #                                                                       #
---- # Copyright (C) OpenTX                                                  #
-----#                                                                       #
---- # License GPLv2: http://www.gnu.org/licenses/gpl-2.0.html               #
---- #                                                                       #
---- # This program is free software; you can redistribute it and/or modify  #
---- # it under the terms of the GNU General Public License version 2 as     #
---- # published by the Free Software Foundation.                            #
---- #                                                                       #
---- # This program is distributed in the hope that it will be useful        #
---- # but WITHOUT ANY WARRANTY; without even the implied warranty of        #
---- # MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the         #
---- # GNU General Public License for more details.                          #
---- #                                                                       #
---- #########################################################################

API_VERSION = 1.040
APP_NAME = "Betaflight"
SCRIPT_HOME = "/SCRIPTS/BF"
WIDGET_HOME = "/WIDGETS/BetaFlit"
local MENU_TIMESLICE = 100
local lastMenuEvent = 0

assert(loadScript(SCRIPT_HOME.."/protocols.lua"))()
radio = assert(loadScript(WIDGET_HOME.."/radios.lua"))()
assert(loadScript(radio.preLoad))()
assert(loadScript(SCRIPT_HOME.."/MSP/common.lua"))()
userEvent = assert(loadScript(WIDGET_HOME.."/events.lua"))()
local run_ui = assert(loadScript(WIDGET_HOME.."/ui.lua"))()

local options =
  {
    { "Color", COLOR, WHITE },
    { "Shadow", BOOL, 0 }
  }

local function create(zone, options)
	local widget = { zone=zone, options=options}
	return widget
end

local function update(widgetToUpdate, options)
	widgetToUpdate.options = options
end

function refresh(widget, event, page)
  if page == 0 then
    lcd.drawText(90, 100, APP_NAME, XXLSIZE + globalTextOptions)
    return;
  end
  if event ~= 0 then
  end
  if protocol == nil or event == userEvent.press.pageDown then -- received focus
    protocol = getProtocol()
    if protocol == nil then
      lcd.drawText(85, 110, "Trying to determine telemetry protocol", TEXT_COLOR + INVERS +BLINK)
      return
    end
    assert(loadScript(protocol.transport))()
    event = 0 -- this event is not needed any further
  elseif event == userEvent.longPress.exit then -- lost focus
    return protocol.exitFunc()
  end
  run_ui(event, page)
end

function members(thing)
  for key, value in pairs(thing) do
    print("Found member:" .. key)
  end
end

function dump(o)
   if type(o) == 'table' then
      local s = '{ '
      for k,v in pairs(o) do
         if type(k) ~= 'number' then k = '"'..k..'"' end
         s = s .. '['..k..'] = ' .. dump(v) .. ','
      end
      return s .. '} '
   else
      return tostring(o)
   end
end

print(APP_NAME, "widget loaded")
return { name=APP_NAME, options=options, create=create, update=update, refresh=refresh, pages=#(PageFiles) }
