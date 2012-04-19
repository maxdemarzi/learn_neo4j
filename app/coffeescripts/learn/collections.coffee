# COLLECTIONS

@app = window.app ? {}

class Albums extends Backbone.Collection
  model: window.app.Album
  url: '/api/albums'

class Playlist extends Albums
  isFirstAlbum: (index) ->
    index == 0
  isLastAlbum: (index) ->
    index == (@models.length - 1)

class Player extends Backbone.Model
  defaults:
    currentAlbumIndex: 0
    currentTrackIndex: 0
    state: 'stop'
  initialize: ->
    @playlist = new Playlist
  reset: ->
    @set currentAlbumIndex:0
    @set currentTrackIndex:0
    @set state:'stop'
  play: ->
    @set state:'play'
    @trigger('change:currentTrackIndex')
    @logCurrentAlbumAndTrack()
  pause: ->
    @set state:'pause'
  isPlaying: ->
    state == 'play'
  isStopped: ->
    !isPlaying
  currentAlbum: ->
    playlist.at(@get('currentAlbumIndex'))
  currentTrackUrl: ->
    album = currentAlbum()
    if (album)
      album.trackUrlAtIndex(@get('currentTrackIndex'))
    else
      null

@app.Albums   = Albums
@app.Playlist = Playlist
@app.Player   = Player

@app.library = new Albums()
@app.player  = new Player()
