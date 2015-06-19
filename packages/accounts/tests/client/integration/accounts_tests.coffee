describe "Accounts", () ->
  view = null

  beforeEach () ->
    view = Blaze.render Template.accountsHeaderButtons, document.body

  afterEach () ->
    Blaze.remove view
    view = null

  describe "Sign in modal", () ->
    it "is hidden until the user clicks sign in", () ->
      expect($('.accounts-modal').is(":visible")).toBe(false)
      $('.sign-in').click()
      expect($('.accounts-modal').is(":visible")).toBe(true)
