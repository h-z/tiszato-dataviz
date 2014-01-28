class App.Bars extends Backbone.View
  tagName: 'div'
  className: 'bars'

  initialize: (o) ->
    @region = o.region
    @bottom = o.bottom
    @top = o.top
    @left = o.left
    App.eventer.on("bars-#{@region}", (event) => @update(event))

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
      nv[year] = parseInt(value / 10.0)
    m = Math.max.apply(null, _.values(nv))
    @$el.css(
      height: m
      top: @top - m
    )
    for year, value of nv
      @$el.find("div[data-year='#{year}']").css
        height: value
        marginTop: m - value


  normalize: (v) ->
    v * .4