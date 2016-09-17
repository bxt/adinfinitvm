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
      { id: 0xB, expected: [0, 1, 3] } # todo: 1 based!?
      { id: 0xF, expected: [0, 1, 2, 3] }
    ]

    tests.forEach (test) ->
      it "should set with id 0x#{test.id.toString(16)} to [#{test.expected}]", ->
        bitSet = new (BitSet(4))
        bitSet.setId(test.id)
        expect(bitSet.toArray()).to.eql(test.expected)

    it 'should reset the other values', ->
      bitSet = new (BitSet(4))
      bitSet.setId(0xF)
      expect(bitSet.toArray()).to.eql([0, 1, 2, 3])
      bitSet.setId(0x1)
      expect(bitSet.toArray()).to.eql([0])

  describe '#has()', ->
    it 'should report any added values', ->
      bitSet = new (BitSet(10))
      bitSet.add(3)
      expect(bitSet.has(3)).to.be.ok
    it 'should not report other values', ->
      bitSet = new (BitSet(10))
      expect(bitSet.has(3)).to.not.be.ok
    it 'should modulus higher values', ->
      bitSet = new (BitSet(10))
      bitSet.add(3)
      expect(bitSet.has(13)).to.be.ok

  describe '#add()', ->
    it 'should add any values', ->
      bitSet = new (BitSet(10))
      expect(bitSet.has(3)).to.not.be.ok
      bitSet.add(3)
      expect(bitSet.has(3)).to.be.ok
    it 'should modulus higher values', ->
      bitSet = new (BitSet(10))
      expect(bitSet.has(3)).to.not.be.ok
      bitSet.add(13)
      expect(bitSet.has(3)).to.be.ok

  describe '#remove()', ->
    it 'should remove the given value', ->
      bitSet = new (BitSet(10))
      bitSet.add(5)
      bitSet.add(3)
      expect(bitSet.has(3)).to.be.ok
      bitSet.remove(3)
      expect(bitSet.has(3)).to.not.be.ok
      expect(bitSet.has(5)).to.be.ok
    it 'should remove the corresponding lower value', ->
      bitSet = new (BitSet(10))
      bitSet.add(5)
      bitSet.add(3)
      expect(bitSet.has(3)).to.be.ok
      bitSet.remove(13)
      expect(bitSet.has(3)).to.not.be.ok
      expect(bitSet.has(5)).to.be.ok
    it 'should do nothing when the value does not exist', ->
      bitSet = new (BitSet(10))
      bitSet.add(5)
      expect(bitSet.length()).to.equal(1)
      bitSet.remove(3)
      expect(bitSet.has(3)).to.not.be.ok
      expect(bitSet.length()).to.equal(1)

  describe '#clear()', ->
    it 'should remove any values added', ->
      bitSet = new (BitSet(10))
      bitSet.add(5)
      bitSet.add(3)
      bitSet.clear()
      expect(bitSet.has(3)).to.not.be.ok
      expect(bitSet.length()).to.equal(0)

  describe '#map()', ->
    it 'should apply the provided callback to all added values', ->
      bitSet = new (BitSet(10))
      bitSet.add(5)
      bitSet.add(3)
      expect(bitSet.map((i)-> i*3)).to.eql([9, 15])

  describe '#toArray()', ->
    it 'should return an array of values added with add ordered by value', ->
      bitSet = new (BitSet(10))
      bitSet.add(5)
      bitSet.add(3)
      expect(bitSet.toArray()).to.eql([3, 5])

  describe '#filter()', ->

  describe '#length()', ->
    it 'should start at 0', ->
      bitSet = new (BitSet(10))
      expect(bitSet.length()).to.equal(0)
    it 'should increase by 1 for each unique value added', ->
      bitSet = new (BitSet(10))
      bitSet.add(5)
      expect(bitSet.length()).to.equal(1)
      bitSet.add(4)
      expect(bitSet.length()).to.equal(2)
      bitSet.add(3)
      expect(bitSet.length()).to.equal(3)
      bitSet.add(2)
      expect(bitSet.length()).to.equal(4)
    it 'should not change when adding equivalent values', ->
      bitSet = new (BitSet(10))
      bitSet.add(5)
      expect(bitSet.length()).to.equal(1)
      bitSet.add(5)
      expect(bitSet.length()).to.equal(1)
      bitSet.add(15)
      expect(bitSet.length()).to.equal(1)

  describe '#rotate()', ->
    it 'should increase each added value by 1', ->
      bitSet = new (BitSet(10))
      bitSet.add(5)
      bitSet.add(3)
      expect(bitSet.rotate().toArray()).to.eql([4, 6])
    it 'should overflow correctly', ->
      bitSet = new (BitSet(10))
      bitSet.add(5)
      bitSet.add(3)
      bitSet.add(1)
      expect(bitSet.rotate(7).toArray()).to.eql([0, 2, 8])

  describe '#clone()', ->
