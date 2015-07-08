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
      organization = new Organization()
      organization.set(fields)
      organization.set('createdById', this.userId)
      organization.save ->
        organization
