#!/bin/luajit

local new_brightness_percentage = math.floor(io.popen("brightnessctl get"):read("n")/io.popen("brightnessctl max"):read("n") * 10) * 10 + 10

if new_brightness_percentage >= 0 and new_brightness_percentage <= 100 then
    os.execute("brightnessctl set " .. new_brightness_percentage .. "%")

    wob_dir = os.getenv("XDG_RUNTIME_DIR") .. "/wob.sock"

    wob_sock = io.open(wob_dir, "w")
    wob_sock:write(new_brightness_percentage .. "\n")
    wob_sock:flush()
    wob_sock:close()
end
