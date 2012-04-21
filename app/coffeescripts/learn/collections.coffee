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

@app.Albums   = Albums
@app.Playlist = Playlist

class Player extends Backbone.Model
  defaults:
    currentAlbumIndex: 0
    currentTrackIndex: 0
    state: 'stop'
  initialize: ->
    @playlist = new app.Playlist
  reset: ->
    @set currentAlbumIndex: 0
    @set currentTrackIndex: 0
    @set state: 'stop'
  play: ->
    @set state:'play'
    @trigger('change:currentTrackIndex')
    @logCurrentAlbumAndTrack()
  pause: ->
    @set state: 'pause'
  isPlaying: ->
    @get('state') == 'play'
  isStopped: ->
    !@isPlaying()
  currentAlbum: ->
    @playlist.at(@get('currentAlbumIndex'))
  currentTrackUrl: ->
    album = @currentAlbum()
    if (album)
      album.trackUrlAtIndex(@get('currentTrackIndex'))
    else
      null
  nextTrack: ->
    currentTrackIndex = @get('currentTrackIndex')
    currentAlbumIndex = @get('currentAlbumIndex')
    if (@currentAlbum().isLastTrack(currentTrackIndex))
      if (@playlist.isLastAlbum(currentAlbumIndex))
        @set 'currentAlbumIndex': 0
        @set 'currentTrackIndex': 0
      else
        @set 'currentAlbumIndex': currentAlbumIndex + 1
        @set 'currentTrackIndex': 0
    else
      @set 'currentTrackIndex': currentTrackIndex + 1
    @logCurrentAlbumAndTrack()
  prevTrack: ->
    currentTrackIndex = @get('currentTrackIndex')
    currentAlbumIndex = @get('currentAlbumIndex')
    lastModelIndex = 0
    if (@currentAlbum().isFirstTrack(currentTrackIndex))
      if (@playlist.isFirstAlbum(currentAlbumIndex))
        lastModelIndex = @playlist.models.length - 1
        @set 'currentAlbumIndex': lastModelIndex
      else
        @set 'currentAlbumIndex': currentAlbumIndex - 1
      lastTrackIndex = @currentAlbum().get('tracks').length - 1
      @set 'currentTrackIndex': lastTrackIndex
    else
      @set 'currentTrackIndex': currentTrackIndex - 1
    @logCurrentAlbumAndTrack()
  logCurrentAlbumAndTrack: ->
    console.log("Player " +
    @get('currentAlbumIndex') + ':' +
    @get('currentTrackIndex'), @)

@app.Player   = Player

@app.library = new Albums()
@app.player  = new Player()
