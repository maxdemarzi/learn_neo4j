describe 'Math:', ->
  describe 'fib()', ->
    it 'should calculate the numbers correctly up to fib(16)', ->
      fib = [0, 1, 1, 2, 3, 5, 8, 13, 21, 34, 55, 89, 144, 233, 377, 610, 987]
      expect(Math.fib(i)).toEqual fib[i] for i in [0..16]

  describe 'uuid()', ->
    it 'should have the proper UUID format', ->
      expect(Math.uuid()).toMatch /[A-Z0-9]{8}-[A-Z0-9]{4}-[A-Z0-9]{4}-[A-Z0-9]{4}-[A-Z0-9]{13}/

    it 'should have always the numer 4 at position 14', ->
      expect(Math.uuid()).toMatch /[A-Z0-9]{8}-[A-Z0-9]{4}-4[A-Z0-9]{3}-[A-Z0-9]{4}-[A-Z0-9]{13}/
      expect(Math.uuid()).toMatch /[A-Z0-9]{8}-[A-Z0-9]{4}-4[A-Z0-9]{3}-[A-Z0-9]{4}-[A-Z0-9]{13}/
      expect(Math.uuid()).toMatch /[A-Z0-9]{8}-[A-Z0-9]{4}-4[A-Z0-9]{3}-[A-Z0-9]{4}-[A-Z0-9]{13}/

    it 'should generate a unique uuid for 1000 generated uuids at least', ->
      uuids = []
      counter = 0

      while counter < 1000
        uuids.push Math.uuid()
        counter++

      expect(uuids.length).toEqual _.uniq(uuids).length