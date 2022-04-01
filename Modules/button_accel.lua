--------------------------------------------------------------------------------
-- Acceleration for encoders V.2.0, by Kuikueg
-- This module provides an easy to handle way to accelerate input in encoders
-- Put it in your FWL modules folder and then, in your script, just two lines per
-- knob will do the trick.
-- Example: let's say your encoder uses numbers 35 and 36, for down and up, 
-- respectively, and you want to accelerate "sim/autopilot/heading_deg_mag_pilot".
-- Simply add to your script:
--
-- hd = AccelButton(36, 35, "sim/autopilot/heading_deg_mag_pilot", 3, 20, 3, 1, 0, 0.5)
-- do_every_frame("hd.operate()")
--
-- and you're done
--------------------------------------------------------------------------------
DataRef("kui_sim_time", "sim/time/zulu_time_sec", "readonly", 0)

function queue(a, max_size)
    local meta = {
        max_size = max_size,
        __call = function(self, filter)
            local res = {}
            local count = 1
            for i = 1, max_size do
                if self[i] ~= nil and self[i] > filter then
                    res[count] = self[i]
                    count = count + 1
                end
            end
            return queue(res, max_size)
        end
    }
    setmetatable(a, meta)
    return a
end

--------------------------------------------------------------------------------
-- button_up. button_down: numbers of the hardware buttons
-- dtref: dataref to be handled
-- threshold: how many clicks before acceleration kicks in
-- max_accel: maximum increment units per click
-- multiplier: the bigger this number, the bigger the acceleration. default 3
-- increment: size of an increment unit, you almost always want 1
-- index: index of the dataref table; defaults to 0
-- time: how long in the past the clicks are being counted
--------------------------------------------------------------------------------
function AccelButton(button_up, button_down, dtref, threshold, max_accel, multiplier, increment, index, time)

    local self = {
        button_up = button_up,
        button_down = button_down,
        threshold = threshold or 3,
        max_accel = max_accel or 20,
        increment = increment or 1,
        time = time or 0.5,
        multiplier = multiplier or 3,
        index = index or 0,
    }

    self.q_up = queue({}, 50)
    self.q_down = queue({}, 50)

    local datname = string.gsub(dtref, "/", "_") .. "_" .. self.index

    DataRef(datname, dtref, "writable", self.index)

    function self.accel(raw)
        quotient = math.floor(raw / self.threshold)
        if quotient > 1 then return math.min((raw - self.threshold)*self.multiplier, self.max_accel) end
        return 1
    end

    function self.operate()
        if button(self.button_up) and not last_button(self.button_up) then
            self.q_up[#self.q_up + 1] = kui_sim_time
            self.q_up = self.q_up(kui_sim_time - self.time)
            _G[datname] = _G[datname] + self.accel(#self.q_up)
        end
        if button(self.button_down) and not last_button(self.button_down) then
            self.q_down[#self.q_down + 1] = kui_sim_time
            self.q_down = self.q_down(kui_sim_time - self.time)
            _G[datname] = _G[datname] - self.accel(#self.q_down)
        end
    end
    return self
end
