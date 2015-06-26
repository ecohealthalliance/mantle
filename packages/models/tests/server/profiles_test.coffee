describe 'User profile', ->
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
