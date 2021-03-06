GlossolApp.Views.NewAnnotationView = Backbone.CompositeView.extend({
  template: JST['doc/newAnnotation'],
  
  initialize: function(options) {
    var that = this;
    
    this.sel = options.sel
    this.sourceText = this.sel.toString();
    this.listenTo(this.model, "sync", function() {
      var docId = that.model.sourceId();
      GlossolApp.RootRouter.navigate("#/doc/show/" + docId);    
    });
    this.makeDoc();
  },
  
  makeDoc: function() {
    
    var newDocView = new GlossolApp.Views.NewDoc({model: this.model});
    this.addSubView('.new-doc', newDocView);
  },
  
   //  utility function
  _swapView: function(newSelector, newView) {
    if (this.currentView) {
      this.removeSubview(this.currentSelector, this.currentView);
    }
    this.addSubView(newSelector, newView);
    this.render();

    this.currentView = newView;
    this.currentSelector = newSelector
  }
});