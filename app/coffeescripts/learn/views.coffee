# VIEWS

jQuery ->
  class AlbumView extends Backbone.View
    template: _.template($('#album-template').html())
    tag: 'li'
    className: 'album'
    initialize: ->
    render: =>
      $(@el).html @template @model.toJSON()
      @

  class PlaylistAlbumView extends AlbumView
    events: 
      'click .queue.remove' : 'removeFromPlaylist'
    initialize: ->
      @player = @options.player
      @player.bind 'change:state', @updateState
      @player.bind 'change:currentTrackIndex', @updateTrack()
      @model.bind 'remove', @remove
    render: =>
      $(@el).html @template @model.toJSON()
      @updateTrack()
      @
    updateState: ->
      isAlbumCurrent = (@player.currentAlbum() == @model)
      $(@el).toggleClass 'current', isAlbumCurrent
    updateTrack: ->
      isAlbumCurrent = (@player.currentAlbum() == @model)
      if (isAlbumCurrent)
        currentTrackIndex = @player.get('currentTrackIndex')
        $('li').each ->
          $(@el).toggleClass 'current' , index == currentTrackIndex
      @updateState()
    removeFromPlaylist: ->
      @options.playlist.remove @model
      @player.reset()

  class LibraryAlbumView extends AlbumView
    events:
      'click .queue.add' : 'select'
    select: ->
      @collection.trigger 'select', @model

  class PlaylistView extends Backbone.View
    tag: 'section'
    className: 'playlist'
    template: _.template($('#playlist-template').html())
    events:
      'click .play': 'play'
      'click .pause': 'pause'
      'click .next': 'nextTrack'
      'click .prev': 'prevTrack'
    initialize: ->
      @createAudio()
      @collection.bind 'reset', @render
      @collection.bind 'add', @renderAlbum
      @player = @options.player
      @player.bind 'change:state', @updateState
      @player.bind 'change:currentTrackIndex', @updateTrack

      @library = @options.library
      @library.bind 'select', @queueAlbum
    createAudio: ->
      @audio = new Audio()
    render: =>
      $(@el).html @template @player.toJSON()
      @collection.each @renderAlbum
      @updateState()
      @
    renderAlbum: (album) ->
      view = new PlaylistAlbumView({
        model: album
        player: this.player
        playlist: this.collection
      })
      $('ul').append(view.render().el)
    updateState: ->
      @updateTrack()
      console.log(@player)
      console.log("hello")
      $('button.play').toggle @player.isStopped()
      $('button.pause').toggle @player.isPlaying()
    updateTrack: ->
      @audio.src = @player.currentTrackUrl()
      if (@player.get('state') == 'play')
        @audio.play()
      else
        @audio.pause()
    queueAlbum: (album) ->
      @collection.add(album)
    play: ->
      @player.play()
    pause: ->
      @player.pause()
    nextTrack: ->
      @player.nextTrack()
    prevTrack: ->
      @player.prevTrack()

  class LibraryView extends Backbone.View
    tagName: 'section'
    className: 'library'
    template: _.template($('#library-template').html())
    initialize: ->
      @collection.bind 'reset', @render
    render: =>
      collection = @collection
      $(@el).html @template
      $albums = $('.albums')
      @collection.each (album) ->
        view = new LibraryAlbumView({
          model: album
          collection: collection
        })
        $albums.append view.render().el
      @

  @app = window.app ? {}
  @app.AlbumView = AlbumView
  @app.PlaylistAlbumView = PlaylistAlbumView
  @app.LibraryAlbumView = LibraryAlbumView
  @app.PlaylistView = PlaylistView
  @app.LibraryView = LibraryView

