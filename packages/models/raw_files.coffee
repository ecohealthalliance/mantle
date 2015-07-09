RawFiles = new FS.Collection "rawFiles",
  stores: [new FS.Store.GridFS("rawFiles")]

RawFiles.allow
  insert: -> true
  update: -> true
  download: -> true