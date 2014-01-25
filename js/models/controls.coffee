class App.Controls extends Backbone.View
  tagName: 'div'
  className: 'controls'

  initialize: (o) ->


  render: ->
    str = """
          <input type='button' class='prev' value='&lt;&lt;' />
          <input type='button' class='play' value='&gt;' />
          <input type='button' class='stop' value='[ ]' />
          <input type='button' class='next' value='&gt;&gt;' />
          <span class="current"></span>
          """
    @$el.html(str)
    @

  events:
    'click .play': 'play'
    'click .stop': 'stop'
    'click .next': 'next'
    'click .prev': 'prev'

  play: ->

  stop: ->

  next: ->

  prev: ->
