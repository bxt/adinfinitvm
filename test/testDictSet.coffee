expect = require('chai').expect

DictSet = require('../src/model/solve/DictSet')

describe 'DictSet', ->

  id = (x) -> x

  describe '#has()', ->
    it 'reports any added values', ->
      dictSet = new DictSet(id)
      dictSet.add(3)
      expect(dictSet.has(3)).to.be.ok
    it 'does not report other values', ->
      dictSet = new DictSet(id)
      expect(dictSet.has(3)).to.not.be.ok

  describe '#add()', ->
    it 'adds any values', ->
      dictSet = new DictSet(id)
      expect(dictSet.has(0)).to.not.be.ok
      expect(dictSet.has(3)).to.not.be.ok
      dictSet.add(3)
      expect(dictSet.has(0)).to.not.be.ok
      expect(dictSet.has(3)).to.be.ok
      dictSet.add(0)
      expect(dictSet.has(0)).to.be.ok
      expect(dictSet.has(3)).to.be.ok
    it 'does nothing when the value exists', ->
      dictSet = new DictSet(id)
      dictSet.add(3)
      dictSet.add(3)
      expect(dictSet.has(3)).to.be.ok
    context 'with a proper index', ->
      it 'adds any values', ->
        dictSet = new DictSet(({x, y}) -> y + x*5)
        dictSet.add({x: 1, y: 4})
        expect(dictSet.has({x: 1, y: 4})).to.be.ok
        expect(dictSet.has({x: 3, y: 2})).to.not.be.ok
        dictSet.add({x: 3, y: 2})
        expect(dictSet.has({x: 1, y: 4})).to.be.ok
        expect(dictSet.has({x: 3, y: 2})).to.be.ok
        expect(dictSet.has({x: 0, y: 1})).to.not.be.ok
        dictSet.add({x: 0, y: 1})
        expect(dictSet.has({x: 0, y: 1})).to.be.ok
      it 'does not distinguish values with the same index', ->
        dictSet = new DictSet(({x, y}) -> y + x*5)
        dictSet.add({x: 1, y: 4})
        expect(dictSet.has({x: 1, y: 4})).to.be.ok
        expect(dictSet.has({x: 0, y: 9})).to.be.ok
        dictSet.add({x: 0, y: 9})
        expect(dictSet.has({x: 1, y: 4})).to.be.ok
        expect(dictSet.has({x: 0, y: 9})).to.be.ok

  describe '#remove()', ->
    it 'removes the given value', ->
      dictSet = new DictSet(id)
      dictSet.add(5)
      dictSet.add(3)
      expect(dictSet.has(3)).to.be.ok
      dictSet.remove(3)
      expect(dictSet.has(3)).to.not.be.ok
      expect(dictSet.has(5)).to.be.ok
    it 'does nothing when the value does not exist', ->
      dictSet = new DictSet(id)
      dictSet.add(5)
      dictSet.remove(3)
      expect(dictSet.has(3)).to.not.be.ok
      expect(dictSet.has(5)).to.be.ok

  describe '#clear()', ->
    it 'removes any values added', ->
      dictSet = new DictSet(id)
      dictSet.add(5)
      dictSet.add(3)
      dictSet.clear()
      expect(dictSet.has(3)).to.not.be.ok
      expect(dictSet.has(5)).to.not.be.ok

  describe '#pop()', ->
    it 'returns a value from the set', ->
      dictSet = new DictSet(id)
      dictSet.add(5)
      dictSet.add(3)
      expect(dictSet.pop()).to.be.oneOf([3, 5]);
    it 'returns undefined from an empty set', ->
      dictSet = new DictSet(id)
      expect(dictSet.pop()).to.be.undefined;
    context 'with a proper index', ->
      it 'returns a value from the set', ->
        dictSet = new DictSet(({x, y}) -> y + x*5)
        testObjects = [
          {x: 1, y: 4}
          {x: 3, y: 2}
          {x: 0, y: 1}
        ]
        dictSet.addAll(testObjects)
        expect(dictSet.pop()).to.be.oneOf(testObjects);

  describe '#toArray()', ->
    it 'returns an array of values added', ->
      dictSet = new DictSet(id)
      dictSet.add(5)
      dictSet.add(3)
      array = dictSet.toArray()
      expect(array).to.eql([3, 5])

  describe '#addAll()', ->
