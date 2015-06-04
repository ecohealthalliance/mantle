keyToLabel = (key)->
  label = key[0].toUpperCase()
  for c in key.substr(1)
    if c == c.toUpperCase()
      label += " " + c.toLowerCase()
    else
      label += c
  return label

for key, field of share.UserProfileSchema.schema()
  AccountsTemplates.addField
    _id: key
    type: 'text'
    # AutoForm.getLabelForField is not used because AutoForm is not defined
    # server side.
    displayName: keyToLabel(key)
    required: if field.optional then false else true
