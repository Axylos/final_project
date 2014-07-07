GlossolApp.Views.Search = Backbone.View.extend({
  template: JST['home/search'],
  
  events: {
    "click button": "execSearch"
  },
  
  render: function() {
    this.$el.html(this.template);
    return this;
  },
  
  execSearch: function() {
    var query = this.$('input').val();
    var ser = new GlossolApp.Models.Search({query: query})
    ser.fetch({
      success: function(model, res) {
        GlossolApp.PubSub.trigger("parseSearch", {
          model: model,
          res: res
        });
      },
      error: function(model, res) {
        console.log(res);
      }
    });
    alert("searching!");
  }
});