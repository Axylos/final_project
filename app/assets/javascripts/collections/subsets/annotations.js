GlossolApp.Subsets.Annotations = Backbone.Subset.extend({

  initialize: function(models, options) {
    this.sourceDoc = options.sourceDoc;
  },

  url: function() {
    return "api/documents/" + this.sourceDoc.id + "/annotations"
  },

  model: GlossolApp.Models.Document

});