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

  getYear: ->
    @year

  getDaily: (idx) ->
    @dailyData[idx]

  getWeekly: (idx, sum) ->
    if sum
      iv = @weeklyData[1]
      for i in [1..idx]
        iv = iv.sumWith(@weeklyData[i])
      iv
    else
      if @weeklyData[idx]
        @weeklyData[idx]
      else
        []

  getDailySum: (idx) ->
    @getDaily(idx).reduce( ((pv, cv) -> parseInt(pv) + parseInt(cv)) , 0)

  getWeeklySum: (idx, sum) ->
    @getWeekly(idx, sum).reduce( ((pv, cv) -> parseInt(pv) + parseInt(cv)) , 0)

  getWeeklySumData: ->
    for i of @weeklyData
      @getWeeklySum(i)


  getLength: ->
    _.values(@weeklyData).length