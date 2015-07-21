if Meteor.isClient
  Template.organizationForm.onCreated ->
    organization = new Organization()
    @organization = new ReactiveVar(organization)

  Template.organizationForm.helpers
    errorForName: ->
      Template.instance().organization.get().getValidationErrors().name
    errorClass: ->
      if Template.instance().organization.get().getValidationErrors().name
        'error'

  Template.organizationForm.events
    'submit form': (event, template) ->
      event.preventDefault()
      form = event.target
      fields = {
        name: form.name?.value
        description: form.description?.value
      }
      organization = template.organization.get()
      organization.set(fields)

      Meteor.call 'createOrganization', organization, (error, response) =>
        if error
          organization.catchValidationException(error)
          toastr.error("Error")
        else
          organization.validateAll()
          toastr.success("Success")

if Meteor.isServer
  Meteor.methods
    createOrganization: (organization) ->
      if this.userId
        organization.set('createdById', this.userId)
        if organization.validateAll()
          organization.save ->
            organization
        else
          organization.throwValidationException()
      else
        throw "Not logged in"
