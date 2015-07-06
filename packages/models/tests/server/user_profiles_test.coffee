describe 'UserProfile attributes', ->
  profile = null

  beforeEach ->
    profile = new UserProfile()

  it 'includes fullName', ->
    profile.set('fullName', 'Full Name')
    profile.save
    expect(profile.fullName).to.eq('Full Name')

  it 'includes jobTitle', ->
    profile.set('jobTitle', 'Job Title Here')
    profile.save
    expect(profile.jobTitle).to.eq('Job Title Here')

  it 'includes bio', ->
    profile.set('bio', 'This is my bio')
    profile.save
    expect(profile.bio).to.eq('This is my bio')

  it 'includes emailHidden', ->
    profile.set('emailHidden', true)
    profile.save
    expect(profile.emailHidden).to.eq(true)

  it 'includes userId', ->
    profile.set('userId', "someMongoId")
    profile.save
    expect(profile.userId).to.eq("someMongoId")

  it 'includes emailAddress', ->
    profile.set('emailAddress', "test@example.com")
    profile.save
    expect(profile.emailAddress).to.eq("test@example.com")

describe 'UserProfile#update', ->
  profile = null

  beforeEach ->
    profile = new UserProfile()
    profile.set(bio: "First bio", userId: 'testUserId')
    profile.save

  it 'updates fields on the profile', ->
    profile.update({bio: "Second bio"})
    expect(profile.bio).to.eq("Second bio")

  it 'does not update fields that are not on the profile', ->
    profile.update({somethingElse: "Fake information"})
    expect(profile.somethingElse).to.not.be.ok

  it 'does not update userId', ->
    profile.update({userId: "securityRisk"})
    expect(profile.userId).to.eq('testUserId')
