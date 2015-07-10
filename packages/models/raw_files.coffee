RawFiles = new FS.Collection "rawFiles",
  stores: [new FS.Store.GridFS("rawFiles")]

RawFiles.allow
  insert: (userId, doc) -> 
    userId is doc.owner
  update: (userId, doc) ->
    userId is doc.owner
  download: (userId, doc) -> 
    userId is doc.owner