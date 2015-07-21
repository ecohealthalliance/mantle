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

  it 'can have members', (test, waitFor) ->
    userId = 'snoopyId'
    memberProfile = new UserProfile()
    memberProfile.set(fullName: 'Snoopy', userId: userId)
    memberProfile.save()
    organization.set('name', 'Peanuts')
    # Checking for errors in the save callback can catch problems with the model.
    # mUnit only allows one async function per test, so this in not done for
    # memberProfile.save()
    organization.save(waitFor((err)->
      test.isNull(err)
      organization.addMember(userId)
      expect(
        organization.getMemberProfiles().map((x)-> x.fullName)
      ).to.include('Snoopy')
   ))
