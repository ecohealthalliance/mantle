describe 'Organization attributes', ->
  organization = null

  beforeEach ->
    organization = new Organization()

  it 'includes name', ->
    organization.set('name', 'Organization Name')
    organization.save
    expect(organization.name).to.eq('Organization Name')

  it 'includes description', ->
    organization.set('description', 'Description')
    organization.save
    expect(organization.description).to.eq('Description')

  it 'includes createdById', ->
    organization.set('createdById', 'fakeid')
    organization.save
    expect(organization.createdById).to.eq('fakeid')

  it 'includes members', (test, waitFor) ->
    organization.set('name', 'Peanuts')
    organization.set('members', ['Snoopy'])
    onSave = (err)->
      test.isNull(err)
    organization.save(waitFor(onSave))
    expect(organization.members).to.include('Snoopy')
