describe 'Organization', ->
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

  it 'truncates description', ->
    organization.set('description', """Lorem ipsum dolor sit amet, consectetur adipiscing elit. Suspendisse leo risus, blandit non sem in, tempus tempor ex. Curabitur a mauris at orci sagittis scelerisque. Morbi ligula sapien, viverra ac condimentum vitae, maximus in massa. Aenean convallis est non odio feugiat condimentum. Morbi sollicitudin sit amet quam ac venenatis. Aenean id facilisis nisl. Interdum et malesuada fames ac ante ipsum primis in faucibus. Cras eu sem condimentum, congue turpis viverra, dictum elit. Nullam ornare nisi leo, ac aliquet ante pretium et. Proin volutpat tortor eu est blandit, sit amet ultricies nisl vulputate. Nullam malesuada aliquet orci, id vehicula quam dictum a. Nulla quis mollis leo. Donec dapibus justo nec enim ultricies auctor. Duis fringilla velit ut ex tempus, nec lobortis tellus pretium. Sed sit amet ligula ac odio efficitur convallis sed at massa.""")
    truncatedDescription = organization.truncateDescription()
    expect(truncatedDescription.split(' ')).length('50')

  it 'includes createdById', ->
    organization.set('createdById', 'fakeid')
    organization.save
    expect(organization.createdById).to.eq('fakeid')

  it 'requires name to be unique', ->
    existingOrg = new Organization()
    existingOrg.set('name', 'Organization Name')
    existingOrg.save ->
      organization.set('name', 'Organization Name')
      expect(organization.validate("name")).not.to.be.ok
      organization.set('name', 'Test')
      expect(organization.validate("name")).to.be.ok
