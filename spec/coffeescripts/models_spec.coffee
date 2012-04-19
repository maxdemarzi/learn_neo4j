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

describe "Album", ->
  beforeEach ->
    @album = new app.Album(albumData[0])

  it "creates from data", ->
    expect(@album.get('tracks').length).toEqual(2)

  describe "first track", -> 
    it "returns true for first track", ->
      expect(@album.isFirstTrack(0)).toBeTruthy()

    it "returns false for other tracks", ->
      expect(@album.isFirstTrack(12)).toBeFalsy()

  describe "last track", -> 
    it "returns true for first track", ->
      expect(@album.isLastTrack(1)).toBeTruthy()

    it "returns false for other tracks", ->
      expect(@album.isLastTrack(0)).toBeFalsy()

  describe "track url at index", -> 
    it "returns URL for existing track", ->
      expect(@album.trackUrlAtIndex(0)).toEqual('/music/Album A Track A.mp3')

    it "returns null for non-existing track", ->
      expect(@album.trackUrlAtIndex(5)).toBe(null)