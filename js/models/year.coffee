class App.Years
  constructor: () ->
    @years = []

  add: (year) ->
    @years.push(year)

class App.Year extends Backbone.Model
  constructor: (@dailyData, @year) ->
    @weeklyData = {}
    for days in @dailyData
      day = days.shift().split('-')
      currentDate = new Date(day[0], day[1]-1, day[2])
      if @weeklyData[currentDate.getWeek()]
        @weeklyData[currentDate.getWeek()] = @weeklyData[currentDate.getWeek()].sumWith(days)
      else
        @weeklyData[currentDate.getWeek()] = days
      #sum = days.reduce( ((pv, cv) -> parseInt(pv) + parseInt(cv)) , 0)

  getYear: ->
    @year

  getDaily: (idx) ->
    @dailyData[idx]

  getWeekly: (idx) ->
    @weeklyData[idx]
