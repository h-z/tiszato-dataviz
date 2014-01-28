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

  getWeekly: (idx, sum) ->
    _.object(@years.map( (y) ->
      [y.getYear(), y.getWeekly(idx, sum)]
    ))

  getWeeklySum: (idx, sum) ->
    _.object(@years.map( (y) ->
      [y.getYear(), y.getWeeklySum(idx, sum)]
    ))
