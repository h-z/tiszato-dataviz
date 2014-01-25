class App.Years
  constructor: () ->
    @years = []
    @max = 0

  add: (year) ->
    @years.push(year)
    @max = Math.max(year.getLength(), @max)
    @

  getMaxLength: ->
    @max

  getWeekly: (idx) ->
    _.object(@years.map( (y) ->
      [y.getYear(), y.getWeekly(idx)]
    ))

  getWeeklySum: (idx) ->
    _.object(@years.map( (y) ->
      [y.getYear(), y.getWeeklySum(idx)]
    ))
