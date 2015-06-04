AutoForm.hooks
  "update-user-profile-form":
    onSubmit: (insertDoc) ->
      Meteor.users.update Meteor.userId(), {'$set': {'profile': insertDoc}}, (err) =>
        if err
          this.done new Error("failed to update profile")
        else
          this.done()
      return false #to prevent the form from being submitted by HTTP

Template.profile.onCreated ->
  @user = new ReactiveVar()
  @autorun =>
    if FlowRouter.getParam("id")
      @subscribe "userInfo", FlowRouter.getParam("id")
      @user.set Meteor.users.findOne(FlowRouter.getParam("id"))
    else
      @subscribe "userInfo", Meteor.userId()
      @user.set Meteor.users.findOne(Meteor.userId())

Template.profile.helpers
  user: -> Template.instance().user.get()
  userIdIsUnknown: ->
    FlowRouter.getParam("id") and !Template.instance().user.get()
  isCurrentUser: -> Template.instance().user.get()._id is Meteor.userId()
    
Template.editProfile.helpers
  profileSchema: -> share.UserProfileSchema
