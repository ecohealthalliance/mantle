describe 'Dataset attributes', ->
  dataset = null

  beforeEach ->
    dataset = new Dataset

  it 'includes name', ->
    dataset.set('name', 'Dataset Name')
    dataset.save
    expect(dataset.name).to.eq('Dataset Name')

  it 'includes file', ->
    dataset.set('fileId', 'fileid')
    dataset.save
    expect(dataset.fileId).to.eq('fileid')

  it 'includes createdById', ->
    dataset.set('createdById', 'userid')
    dataset.save
    expect(dataset.createdById).to.eq('userid')