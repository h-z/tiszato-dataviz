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
    m = Math.max.apply(null, _.values(values))
    @$el.css(
      height: @normalize(m)
      top: @top - @normalize(m)
    )
    for year, value of values
      @$el.find("div[data-year='#{year}']").css
        height: @normalize(value)
        marginTop: @normalize(m - value)


  normalize: (v) ->
    v * .4