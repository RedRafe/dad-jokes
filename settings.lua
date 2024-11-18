data:extend({
  {
    type = 'bool-setting',
    name = 'dj-nsfw',
    order = 'dj-a',
    setting_type = 'runtime-global',
    default_value = false
  },
  {
    type = 'int-setting',
    name = 'dj-cooldown',
    order = 'dj-c',
    setting_type = 'runtime-global',
    default_value = 10,
    minimum_value = 0,
    maximum_value = 60 * 1000
  },
  {
    type = 'int-setting',
    name = 'dj-buildup',
    order = 'dj-b',
    setting_type = 'runtime-global',
    default_value = 5,
    minimum_value = 1,
    maximum_value = 60 * 1000
  }
})