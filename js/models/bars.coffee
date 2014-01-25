class App.Bars extends Backbone.View
  tagName: 'div'
  className: 'bars'

  initialize: (o) ->
    @region = o.region
    @bottom = o.bottom
    @left = o.left
    App.eventer.on("bars-#{@region}", (event) => @update(event))

  render: () ->
    cont = ''
    for year in [2011, 2012, 2013]
      cont += "<div data-year='#{year}'></div>"
    css =
      left: @left
      bottom: @bottom
      height: 10
    @$el.html(cont).css(css).data('region', @region)
    @

  update: (values) ->
    @$el.css(
      height: Math.max.apply(null, _.values(values)) + 10
    )
    for year, value of values
      @$el.find("div[data-year='#{year}']").css
        height: value
