window.App =
  years: {}

  eventer: _.extend({}, Backbone.Events)

  init: () ->
    $.ajax('data.json').done( (response) =>
      @years = new App.Years()
      for year, lines of response
        @years.add(new App.Year(lines, year))

      @createPlayer()
      @createChart()
      @createBars()
    )

  createPlayer: ->

  createChart: ->

  createBars: ->
    barsData = [
      region: 1
      top: 300
      left: 698
    ,
      region: 2
      top: 358
      left: 446
    ,
      region: 3
      top: 259
      left: 84
    ,
      region: 4
      top: 214
      left: 244
    ,
      region: 5
      top: 168
      left: 570
    ,
      region: 6
      top: 170
      left: 801
    ,
      region: 7
      top: 262
      left: 866
    ,
      region: 8
      top: 306
      left: 921
    ,
      region: 9
      top: 244
      left: 780
    ,
      region: 10
      top: 250
      left: 573
    ,
      region: 11
      top: 261
      left: 384
    ]
    for bar in barsData
      $('.map').append((new App.Bars(bar)).render().$el)

