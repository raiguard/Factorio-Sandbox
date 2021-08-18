local PLD = table.deepcopy(data.raw["active-defense-equipment"]["personal-laser-defense-equipment"])
PLD.name = "test-laser"
local energy_source = PLD.energy_source

local speed_from_cheat_once = 1 + 2.2
local ticks_per_shot = 60 * 5 * speed_from_cheat_once
energy_source.buffer_capacity = "100MJ"
energy_source.input_flow_limit = (60 / ticks_per_shot) .. "kW"
energy_source.output_flow_limit = "100MW"
energy_source.usage_priority = "tertiary"
PLD.attack_parameters = {
  type = "projectile",
  range = 20,
  cooldown = 1,
  ammo_type = {
    category = "melee",
    target_type = "position",
    energy_consumption = "1J",
    action = {
      type = "direct",
      action_delivery = {
        type = "instant",
        source_effects = {
          {
            type = "nested-result",
            affects_target = true,
            action = {
              type = "area",
              radius = 20,
              collision_mode = "distance-from-center",
              ignore_collision_condition = true,
              trigger_target_mask = { "test-trigger" },
              action_delivery = {
                type = "instant",
                target_effects = {
                  {
                    type = "script",
                    effect_id = "kr-tesla-coil-trigger",
                  },
                },
              },
            },
          },
        },
      },
    },
  },
}

local PLD_item = table.deepcopy(data.raw["item"]["personal-laser-defense-equipment"])
PLD_item.name = "test-laser"

data:extend{PLD, PLD_item, {type = "trigger-target-type", name = "test-trigger"}}

for _, assembler in pairs(data.raw["assembling-machine"]) do
    local mask = assembler.trigger_target_mask or {}
    assembler.trigger_target_mask = mask
    mask[#mask + 1] = "test-trigger"
end
