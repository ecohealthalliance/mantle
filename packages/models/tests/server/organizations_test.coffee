describe 'Organization', ->
  organization = null

  beforeEach ->
    UserProfiles.remove({})
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

  it 'can have members', (test, waitFor) ->
    memberProfile = new UserProfile()
    memberProfile.set(fullName: 'Snoopy')
    id = memberProfile.save()
    organization.save()
    organization.addMember(id)
    expect(
      organization.getMemberProfiles().map((x)-> x.fullName)
    ).to.include('Snoopy')

  it 'can have admins', (test, waitFor) ->
    memberProfile = new UserProfile()
    memberProfile.set(fullName: 'TestUser')
    memberProfile.save()
    organization.set('name', 'TestOrg')
    organization.save()
    organization.addAdmin(memberProfile._id)
    expect(
      organization.getAdminProfiles().map((x)-> x.fullName)
    ).to.include('TestUser')

    organization.removeAdmin(memberProfile._id)
    expect(
      organization.getAdminProfiles().map((x)-> x.fullName)
    ).not.to.include('TestUser')

  it 'automatically makes its creator an admin', (test, waitFor) ->
    userId = 'userId'
    memberProfile = new UserProfile()
    memberProfile.set(fullName: 'TestUser', userId: userId)
    memberProfile.save()
    organization.set({name: 'TestOrg', createdById: userId})
    organization.save()
    expect(
      organization.getMemberProfiles().map((x)-> x.fullName)
    ).to.include('TestUser')
    expect(
      organization.getAdminProfiles().map((x)-> x.fullName)
    ).to.include('TestUser')

  describe '#userIsAdmin', ->
    it 'returns true if the user is an admin of the organization', ->
      organization.save()
      profile = new UserProfile()
      profile.set({userId: 'userId', adminOfOrgs: [organization._id]})
      profile.save()
      expect(organization.userIsAdmin('userId')).to.be.ok

    it 'returns false if the user is not an admin of the organization', ->
      organization.save()
      profile = new UserProfile()
      profile.set({userId: 'userId'})
      profile.save()
      expect(organization.userIsAdmin('userId')).not.to.be.ok
