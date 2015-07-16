if Meteor.isClient
  Template.organizationForm.events
    'submit form': (event) ->
      event.preventDefault()
      form = event.target
      fields = {
        name: form.name?.value
        description: form.description?.value
      }
      Meteor.call 'createOrganization', fields, (error, response) ->
        if error
          if error.error == "validation-error"
            toastr.error()
          else
            toastr.error("Error")
        else
          toastr.success("Success")

if Meteor.isServer
  Meteor.methods
    createOrganization: (fields) ->
      if this.userId
        organization = new Organization()
        organization.set(fields)
        organization.set('createdById', this.userId)
        if organization.validateAll()
          organization.save ->
            organization
        else
          organization.throwValidationException()
      else
        throw "Not logged in"
