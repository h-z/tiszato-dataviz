class App.Player
  constructor: ->
    @idx = 0
    App.eventer.on('play', (event) => @play(event))
    App.eventer.on('stop', (event) => @stop(event))
    App.eventer.on('next', (event) => @next(event))
    App.eventer.on('prev', (event) => @prev(event))


  show: ->
    data = App.years.getWeekly(@idx)
    for region in [0..10]
      e =
        2011: data[2011][region]
        2012: data[2012][region]
        2013: data[2013][region]
      App.eventer.trigger("bars-#{region + 1}",  e)
    App.eventer.trigger('current', @idx)
    chartData = App.years.getWeeklySum(@idx)
    for serie in App.chart.series
      if @idx == App.years.getMaxLength() - 1
        serie.setData([])
      else
        serie.addPoint(chartData[serie.name])
    @

  next: ->
    @idx = (@idx + 1) % App.years.getMaxLength()
    @show()

  prev: ->
    @idx = (@idx - 1) % App.years.getMaxLength()
    @show()

  play: =>
    @stop()
    @timer = setInterval(( => @next()), 1000)
    @show()

  stop: ->
    clearInterval(@timer)
