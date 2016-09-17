expect = require('chai').expect

BitSet = require('../src/model/BitSet')

describe 'BitSet', ->

  describe '#setId()', ->
    tests = [
      { id: 0x0, expected: [] }
      { id: 0x1, expected: [0] }
      { id: 0x2, expected: [1] }
      { id: 0x9, expected: [0, 3] }
      { id: 0xA, expected: [1, 3] }
      { id: 0xB, expected: [0, 1, 3] }
      { id: 0xF, expected: [0, 1, 2, 3] }
    ]

    tests.forEach ({id, expected}) ->
      it "yields [#{expected}] with id 0x#{id.toString(16)}", ->
        bitSet = new (BitSet(4))
        bitSet.setId(id)
        expect(bitSet.toArray()).to.eql(expected)

    it 'resets the other values', ->
      bitSet = new (BitSet(4))
      bitSet.setId(0xF)
      expect(bitSet.toArray()).to.eql([0, 1, 2, 3])
      bitSet.setId(0x1)
      expect(bitSet.toArray()).to.eql([0])

  describe '#has()', ->
    it 'reports any added values', ->
      bitSet = new (BitSet(10))
      bitSet.add(3)
      expect(bitSet.has(3)).to.be.ok
    it 'does not report other values', ->
      bitSet = new (BitSet(10))
      expect(bitSet.has(3)).to.not.be.ok
    it 'moduluses higher values', ->
      bitSet = new (BitSet(10))
      bitSet.add(3)
      expect(bitSet.has(13)).to.be.ok

  describe '#add()', ->
    it 'adds any values', ->
      bitSet = new (BitSet(10))
      expect(bitSet.has(0)).to.not.be.ok
      expect(bitSet.has(3)).to.not.be.ok
      bitSet.add(3)
      expect(bitSet.has(0)).to.not.be.ok
      expect(bitSet.has(3)).to.be.ok
      bitSet.add(0)
      expect(bitSet.has(0)).to.be.ok
      expect(bitSet.has(3)).to.be.ok
    it 'moduluses higher values', ->
      bitSet = new (BitSet(10))
      expect(bitSet.has(3)).to.not.be.ok
      bitSet.add(13)
      expect(bitSet.has(3)).to.be.ok
    it 'does nothing when the value exists', ->
      bitSet = new (BitSet(10))
      bitSet.add(3)
      beforeId = bitSet.id
      bitSet.add(3)
      expect(bitSet.id).to.equal(beforeId)

  describe '#remove()', ->
    it 'removes the given value', ->
      bitSet = new (BitSet(10))
      bitSet.add(5)
      bitSet.add(3)
      expect(bitSet.has(3)).to.be.ok
      bitSet.remove(3)
      expect(bitSet.has(3)).to.not.be.ok
      expect(bitSet.has(5)).to.be.ok
    it 'removes the corresponding lower value', ->
      bitSet = new (BitSet(10))
      bitSet.add(5)
      bitSet.add(3)
      expect(bitSet.has(3)).to.be.ok
      bitSet.remove(13)
      expect(bitSet.has(3)).to.not.be.ok
      expect(bitSet.has(5)).to.be.ok
    it 'does nothing when the value does not exist', ->
      bitSet = new (BitSet(10))
      bitSet.add(5)
      expect(bitSet.length()).to.equal(1)
      bitSet.remove(3)
      expect(bitSet.has(3)).to.not.be.ok
      expect(bitSet.length()).to.equal(1)

  describe '#clear()', ->
    it 'removes any values added', ->
      bitSet = new (BitSet(10))
      bitSet.add(5)
      bitSet.add(3)
      bitSet.clear()
      expect(bitSet.has(3)).to.not.be.ok
      expect(bitSet.length()).to.equal(0)

  describe '#map()', ->
    it 'applies the provided callback to all added values', ->
      bitSet = new (BitSet(10))
      bitSet.add(5)
      bitSet.add(3)
      expect(bitSet.map((i)-> i*3)).to.eql([9, 15])

  describe '#toArray()', ->
    it 'returns an array of values added with add ordered by value', ->
      bitSet = new (BitSet(10))
      bitSet.add(5)
      bitSet.add(3)
      expect(bitSet.toArray()).to.eql([3, 5])

  describe '#filter()', ->
    it 'keeps all elements when the callback is always true', ->
      bitSet = new (BitSet(6))().addAll([1,3,5])
      bitSet.filter (i) -> true
      expect(bitSet.toArray()).to.eql([1,3,5])
    it 'discards all elements when the callback is always false', ->
      bitSet = new (BitSet(6))().addAll([1,3,5])
      bitSet.filter (i) -> false
      expect(bitSet.toArray()).to.eql([])
    it 'filters out e.g. even values', ->
      bitSet = new (BitSet(6))().addAll([0,1,2,3,5])
      bitSet.filter (i) -> i % 2
      expect(bitSet.toArray()).to.eql([1,3,5])

  describe '#addAll()', ->

  describe '#length()', ->
    it 'starts at 0', ->
      bitSet = new (BitSet(10))
      expect(bitSet.length()).to.equal(0)
    it 'increases by 1 for each unique value added', ->
      bitSet = new (BitSet(10))
      bitSet.add(5)
      expect(bitSet.length()).to.equal(1)
      bitSet.add(4)
      expect(bitSet.length()).to.equal(2)
      bitSet.add(3)
      expect(bitSet.length()).to.equal(3)
      bitSet.add(2)
      expect(bitSet.length()).to.equal(4)
    it 'stays constant when adding equivalent values', ->
      bitSet = new (BitSet(10))
      bitSet.add(5)
      expect(bitSet.length()).to.equal(1)
      bitSet.add(5)
      expect(bitSet.length()).to.equal(1)
      bitSet.add(15)
      expect(bitSet.length()).to.equal(1)

  describe '#rotate()', ->
    it 'increases each added value by 1', ->
      bitSet = new (BitSet(10))
      bitSet.add(5)
      bitSet.add(3)
      expect(bitSet.rotate().toArray()).to.eql([4, 6])
    it 'overflows correctly', ->
      bitSet = new (BitSet(10))
      bitSet.add(5)
      bitSet.add(3)
      bitSet.add(1)
      expect(bitSet.rotate(7).toArray()).to.eql([0, 2, 8])

  describe '#clone()', ->
