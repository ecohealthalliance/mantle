describe('Accounts', function () {
  describe('accountsHeaderButtons', function () {
    it('sets up the template', function () {
      expect(Template.accountsHeaderButtons).toBeDefined();
    });

    it('renders a sign-out link', function () {
      var templateHtmlString = Template.accountsHeaderButtons.renderFunction().value
      expect(templateHtmlString).toContain("sign-out");
    });
  });
});
