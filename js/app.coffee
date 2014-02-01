window.App =
  years: {}
  step: 3000

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
            App.eventer.on('current', (event) =>
              d = new Date(2011, 0, (1 + (event['current'] - 1) * 7))
              for serie in @series
                if event['current'] == 1
                  serie.setData([])
                serie.addPoint([parseInt(d.getTime()), event['chartData'][serie.name]])
            )
            App.eventer.on('sum', (sum) =>
              if sum
                @yAxis[0].options.max = 100000
              else
                @yAxis[0].options.max = 5000
              for serie in @series
                serie.setData([])
            )
      title: 'Évek'
      xAxis:
        categories: @categories()
        max: _.max(@categories())
        tickLength: 0
        type: 'datetime'
        tickInterval: 14 * 24 * 3600000
        labels:
          formatter: ->
            Highcharts.dateFormat('%b %d', @value)
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
          lineWidth: 4
      series: @series()
    )

  categories: ->
    (new Date(2011, 0, (1 + (i - 1) * 7))).getTime() for i in [1..52]

  series: ->
    colors =
      2011: '#2049FF'
      2012: '#00F000'
      2013: '#F1301D'
    for year in @years.years
      serie = {}
      serie.name = year.getYear()
      serie.color = colors[serie.name]
      serie.data = [] #year.getWeeklySumData()
      serie

  createBars: ->
    barsData = [
      region: 1
      top: 320
      left: 646
    ,
      region: 2
      top: 382
      left: 460
    ,
      region: 3
      top: 292
      left: 103
    ,
      region: 4
      top: 238
      left: 225
    ,
      region: 5
      top: 158
      left: 606
    ,
      region: 6
      top: 174
      left: 771
    ,
      region: 7
      top: 269
      left: 875
    ,
      region: 8
      top: 360
      left: 805
    ,
      region: 9
      top: 258
      left: 734
    ,
      region: 10
      top: 258
      left: 533
    ,
      region: 11
      top: 275
      left: 395
    ]
    for bar in barsData
      $('.map').append((new App.Bars(bar)).render().$el)

