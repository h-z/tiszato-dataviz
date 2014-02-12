class App.Player
  constructor: ->
    @idx = 0
    @sumEnabled = false
    App.eventer.on('play', (event) => @play(event))
    App.eventer.on('stop', (event) => @stop(event))
    App.eventer.on('next', (event) => @next(event))
#    App.eventer.on('prev', (event) => @prev(event))
    App.eventer.on('sum', (event) => @sum(event))


  show: ->
    data = App.years.getWeekly(@idx, true)
    for region in [0..10]
      if 4 != region
        e =
          2011: data[2011][region]
          2012: data[2012][region]
          2013: data[2013][region]
      else
        e =
          2011: data[2011][4] + data[2011][5]
          2012: data[2012][4] + data[2012][5]
          2013: data[2013][4] + data[2013][5]

      App.eventer.trigger("bars-#{region + 1}",  e)
    App.eventer.trigger('current',
      current: @idx
      chartData: App.years.getWeeklySum(@idx, false)
    )
    @

  next: ->
    @idx++
    if @idx == App.years.getMaxLength() - 1
      #@idx = 1
      @stop()
    else
      @show()

#  prev: ->
#    @idx = (@idx - 1) % App.years.getMaxLength()
#    @show()

  play: =>
    @stop()
    @idx = 0
    @timer = setInterval(( => @next()), App.step)
    @

  stop: ->
    clearInterval(@timer)

  sum: (event) ->
    @sumEnabled = event
    @idx = 0