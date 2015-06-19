describe "Accounts", () ->
  view = null

  beforeEach (done) ->
    view = Blaze.render Template.accountsHeaderButtons, document.body
    Meteor.call "clearUsers", () -> done()

  afterEach () ->
    Blaze.remove view
    view = null
    Meteor.logout()

  describe "Sign in modal", () ->
    it "is hidden until the user clicks sign in", () ->
      expect($('.accounts-modal').is(":visible")).toBe(false)
      $('.sign-in').click()
      expect($('.accounts-modal').is(":visible")).toBe(true)

    it "allows the user to sign in", (done) ->
      Meteor.call "createTestUser", "signin@test.com", "password", (error, userId) ->
        expect(error).toBeFalsy()
      
        $('.sign-in').click()
      
        expect($('#at-field-email').is(":visible")).toBe(true)
        $('#at-field-email').val("signin@test.com")
        
        expect($('#at-field-password').is(":visible")).toBe(true)
        $('#at-field-password').val('password')
        
        $('#at-btn').click()

        checkLoggedIn = () ->
          expect($('.accounts-modal').is(":visible")).toBe(false)
          expect(Meteor.userId()).toBe(userId)
          done()

        setTimeout(checkLoggedIn, 500)