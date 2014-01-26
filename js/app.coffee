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
    new App.Player()
    $('body').append((new App.Controls()).render().$el)

  createChart: ->
    $('.chart').highcharts(
      chart:
        type: 'spline'
        events:
          load: ->
            App.chart = @
      title: 'Évek'
      xAxis:
        categories: @categories()
        max: 53
      yAxis:
        max: 5000
        title:
          text: 'Horgásznapok'
        plotLines: [
          values: 0
          width: 1
          color: '#808080'
        ]
      plotOptions:
        spline:
          marker:
            enabled: false
      series: @series()
    )

  categories: -> [1..54]

  series: ->
    colors =
      2011: '#0000ff'
      2012: '#00ff00'
      2013: '#ff0000'
    for year in @years.years
      serie = {}
      serie.name = year.getYear()
      serie.color = colors[serie.name]
      serie.data = [] #year.getWeeklySumData()
      serie


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

