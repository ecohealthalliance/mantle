share.UserProfileSchema = new SimpleSchema
  name:
    type: String
  phone:
    type: String
    optional: true
  organization:
    type: String
    optional: true
  'organizationStreet':
    type: String
    optional: true
    label: 'Street'
  'organizationStreet2':
    type: String
    optional: true
    label: 'Street2'
  'organizationCity':
    type: String
    optional: true
    label: 'City'
  'organizationStateOrProvince':
    type: String
    optional: true
    label: 'State or Province'
  'organizationCountry':
    type: String
    optional: true
    label: 'Country'
  'organizationPostalCode':
    type: String
    label: 'ZIP'
    optional: true
