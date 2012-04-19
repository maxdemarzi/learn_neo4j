# MODELS

class Album extends Backbone.Model
  isFirstTrack: (index) ->
    index == 0
  isLastTrack: (index)->
    index >= this.get('tracks').length - 1
  trackUrlAtIndex: (index) ->
    if this.get('tracks').length >= index
      this.get('tracks')[index].url
    else
      null

@app = window.app ? {}
@app.Album = Album