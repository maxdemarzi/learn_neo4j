# ROUTERS

jQuery ->

  class BackboneTunes extends Backbone.Router
    routes:
      '': 'home',
      'blank': 'blank'
    initialize: ->
      @playlistView = new window.app.PlaylistView({
        collection: window.app.player.playlist
        player: window.app.player
        library: window.app.library
      })
      @libraryView = new window.app.LibraryView({
        collection: window.app.library
      })
    home: ->
      $('#container').empty()
      $("#container").append(@playlistView.render().el)
      $("#container").append(@libraryView.render().el)
    blank: ->
      $('#container').empty()
      $('#container').text('blank')
      

  @app = window.app ? {}
  @app.BackboneTunes = BackboneTunes