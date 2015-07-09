Datasets = new Mongo.Collection("datasets")

Dataset = Astro.Class
  name: 'Dataset'
  collection: Datasets
  transform: true
  fields:
    name: 'string'
    file: 'string'
    createdById: 'string'