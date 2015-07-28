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
          toastr.error("Error")
        else
          toastr.success("Success")

if Meteor.isServer
  Meteor.methods
    createOrganization: (fields) ->
      if this.userId
        organization = new Organization()
        organization.set(fields)
        organization.set('createdById', @userId)
        organization.save()
      else
        throw "Not logged in"
