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


@app.Albums = Albums
@app.Playlist = Playlist
