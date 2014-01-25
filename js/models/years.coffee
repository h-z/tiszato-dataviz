class App.Years
  constructor: () ->
    @years = []

  add: (year) ->
    @years.push(year)

  getWeekly: (idx) ->
    _.object(@years.map( (y) ->
      [y.getYear(), y.getWeekly(idx)]
    ))

  getWeeklySum: (idx) ->
    _.object(@years.map( (y) ->
      [y.getYear(), y.getWeeklySum(idx)]
    ))
