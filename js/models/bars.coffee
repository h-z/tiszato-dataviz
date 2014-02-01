class App.Bars extends Backbone.View
  tagName: 'div'
  className: 'bars'

  initialize: (o) ->
    @region = o.region
    @bottom = o.bottom
    @top = o.top
    @left = o.left
    @norm = 200.0
    App.eventer.on("bars-#{@region}", (event) => @update(event))
    App.eventer.on("sum", (sum) => @norm = if sum then 200.0 else 10.0 )

  render: () ->
    cont = ''
    for year in [2011, 2012, 2013]
      cont += "<div data-year='#{year}'></div>"
    css =
      left: @left
      top: @top
      height: 10
    @$el.html(cont).css(css).data('region', @region)
    @

  update: (values) ->
    nv = {}
    for year, value of values
      nv[year] = parseInt(value / @norm)
    m = Math.max.apply(null, _.values(nv))
    @$el.css(
      height: m
      top: @top - m
    )
    for year, value of nv
      @$el.find("div[data-year='#{year}']").css
        height: value
        marginTop: m - value
