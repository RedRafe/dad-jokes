local function set_localisation(source, name, locale)
  if data.raw[source] and data.raw[source][name] then
    data.raw[source][name].localised_name = locale
  end
end

set_localisation("item-with-entity-data", "spidertron", {"jokes.spidertron"})
