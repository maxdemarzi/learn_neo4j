app = window.app ? {}

describe "Util", ->

  describe "formats seconds as time", ->

    it "with less than 10 minutes", ->
      result = app.Util.formatSecondsAsTime 6*60
      expect(result).toEqual ':06'

    it "with less than an hour", ->
      result = app.Util.formatSecondsAsTime 45*60
      expect(result).toEqual ':45'

    it "with more than an hour", ->
      result = app.Util.formatSecondsAsTime 60*60
      expect(result).toEqual '1:00'

    it "with much more than an hour", ->
      result = app.Util.formatSecondsAsTime 75*60
      expect(result).toEqual '1:15'