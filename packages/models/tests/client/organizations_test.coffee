describe 'Organization attributes', ->
  organization = null

  beforeEach ->
    organization = new Organization()

  it 'requires name, description, and createdById', ->
    expect(organization.validateAll()).not.to.be.ok
    expect(organization.validate("name")).not.to.be.ok
    expect(organization.validate("description")).not.to.be.ok
    expect(organization.validate("createdById")).not.to.be.ok
    organization.set({name: 'Test', description: 'Test test', createdById: 'fakeId'})
    expect(organization.validateAll()).to.be.ok
