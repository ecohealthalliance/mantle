Organizations = new Mongo.Collection('organizations')
Organization = Astro.Class
  name: 'Organization'
  collection: Organizations
  transform: true
  fields:
    name:
      type: 'string'
      validators: [
        Validators.unique(null, "There is already an organization with that name")
        Validators.string()
      ]
    description:
      type: 'string'
      validators: [
        Validators.string()
      ]
    createdById:
      type: 'string'
      validators: [
        Validators.string()
      ]

  methods:
    truncateDescription: ->
      splitDescription = @description?.split(' ')
      wordCount = 50
      if splitDescription.length > wordCount
        splitDescription.slice(0,wordCount).join(' ')+'...'
      else
        @description
