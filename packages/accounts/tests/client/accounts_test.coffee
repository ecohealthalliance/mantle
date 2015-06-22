describe("Accounts", () ->

  beforeEach((test) ->
    $('.modal').modal('hide')
    Meteor.call("clearUsers")
    @view = Blaze.render(Template.accountsHeaderButtons, document.body)
  )

  afterEach((test) ->  
    Meteor.call("clearUsers")
    $('.modal').modal('hide')
    Blaze.remove(@view)
    @view = null
  )

  it("displays sign in modal when user clicks Sign In", (test) ->
    test.isFalse($('.accounts-modal').is(":visible"))
    $('.sign-in').click()
    test.isTrue($('.accounts-modal').is(":visible"))
  )

  it("allows user to sign in", (test, waitFor) ->

    checkLogin = waitFor((userId) ->
      try
        test.equal(Meteor.userId(), userId)
        test.isFalse($('.accounts-modal').is(":visible"))
      catch error
        test.exception error
    )

    Meteor.call("createTestUser", "signin@test.com", "password", (error, userId) ->
      $('.sign-in').click()

      $('#at-field-email').val("signin@test.com")
      $('#at-field-password').val('password')

      $('#at-btn').click()

      setTimeout(checkLogin(userId), 500)
    )
  )
)
