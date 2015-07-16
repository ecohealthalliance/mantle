if Meteor.isClient
  Template.organizationForm.onCreated ->
    Session.set('organization', new Organization())

  Template.organizationForm.helpers
    organization: ->
      Session.get('organization')

    errorForName: ->
      organization = Session.get('organization')
      organization.getValidationErrors().name

  Template.organizationForm.events
    'submit form': (event) ->
      event.preventDefault()
      form = event.target
      fields = {
        name: form.name?.value
        description: form.description?.value
      }
      organization = Session.get('organization')
      organization.set(fields)

      Meteor.call 'createOrganization', organization, (error, response) =>
        if error
          organization.catchValidationException(error)
          toastr.error("Error")
        else
          toastr.success("Success")
        Session.set('organization', organization)

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
