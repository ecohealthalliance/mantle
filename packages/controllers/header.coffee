if Meteor.isClient
  Template.header.events
    'click a' : (e) ->
      if $('.navbar-toggle').is(':visible') and $('.navbar-collapse').hasClass('in') and !$(e.currentTarget).hasClass('dropdown-toggle')
        $('.navbar-collapse').collapse('toggle')
