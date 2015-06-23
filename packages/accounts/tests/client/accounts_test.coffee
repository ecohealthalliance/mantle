describe("Account header", () ->

  beforeEach((test, waitFor) ->
    testSetup = waitFor(() ->
      $('.modal').modal('hide')
      test.view = Blaze.render(Template.accountsHeaderButtons, document.body)
    )

    Meteor.call("clearUsers", (response) ->
      testSetup()
    )
  )

  afterEach((test) ->  
    Meteor.call("clearUsers")
    $('.modal').modal('hide')
    Blaze.remove(test.view)
    test.view = null
  )

  it("displays sign in modal when user clicks Sign In", (test) ->
    test.isFalse($('.accounts-modal').is(":visible"))
    $('.sign-in').click()
    test.isTrue($('.accounts-modal').is(":visible"))
  )

  it("switches to sign up when a user clicks Sign Up", (test, waitFor) ->
    signUpVisible = waitFor(() ->
      try
        test.isFalse($('#at-signUp').is(":visible"))
        test.isTrue($('#at-field-password_again').is(":visible"))
      catch error
        test.exception error
    )

    test.isFalse($('.accounts-modal').is(":visible"))
    $('.sign-in').click()
    test.isTrue($('.accounts-modal').is(":visible"))
    test.isFalse($('#at-field-password_again').is(":visible"))
    test.isTrue($('#at-signUp').is(":visible"))
    $('#at-signUp').click()

    setTimeout(signUpVisible, 500)
  )

  it("allows user to sign in", (test, waitFor) ->
    currentUserId = ''

    checkLogin = waitFor(() ->
      try
        test.isTrue($('.sign-out').is(":visible"))
        test.equal(Meteor.userId(), currentUserId)
        test.isFalse($('.accounts-modal').is(":visible"))
      catch error
        test.exception error
    )

    Meteor.call("createTestUser", "signin@test.com", "password", (error, userId) ->
      currentUserId = userId

      $('.sign-in').click()

      $('#at-field-email').val("signin@test.com")
      $('#at-field-password').val('password')

      $('#at-btn').click()

      setTimeout(checkLogin, 500)
    )
  )
)
