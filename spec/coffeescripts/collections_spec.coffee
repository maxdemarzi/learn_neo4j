app = window.app ? {}

albumData = [{
  "title":  "Album A"
  "artist": "Artist A"
  "tracks": [{"title": "Track A", "url": "/music/Album A Track A.mp3" },{ "title": "Track B", "url": "/music/Album A Track B.mp3" }]
  },{
  "title": "Album B"
  "artist": "Artist B"
  "tracks": [{"title": "Track A", "url": "/music/Album B Track A.mp3" },{ "title": "Track B", "url": "/music/Album B Track B.mp3" }]
}]

describe "Playlist", ->
  beforeEach ->
    @playlist = new app.Playlist
    @playlist.add(albumData[0])

  it "has models", ->
    expect(@playlist.models.length).toEqual(1)  

  it "identifies first album as first", ->
    expect(@playlist.isFirstAlbum(0)).toBeTruthy()

  it "rejects non-first album as first", ->
    expect(@playlist.isFirstAlbum(1)).toBeFalsy()

  it "identifies last album as last", ->
    @playlist.add(albumData[1])
    expect(@playlist.isLastAlbum(1)).toBeTruthy()

  it "rejects non-last album as last", ->
    @playlist.add(albumData[1]) 
    expect(@playlist.isLastAlbum(0)).toBeFalsy()

describe "Player", ->
  describe "with no items", ->
    beforeEach ->
      @player = new app.Player
    it "starts with album 0", ->
      expect(@player.get('currentAlbumIndex')).toEqual(0)
    it "starts with track 0", ->
      expect(@player.get('currentTrackIndex')).toEqual(0)
