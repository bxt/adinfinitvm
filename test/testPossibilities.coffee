expect = require('chai').expect

Possibilities = require('../src/model/solve/Possibilities')

describe 'Possibilities', ->

  describe '#@forSquare()', ->
    tests = [
      { id: 0x0, expected:     1 }
      { id: 0x1, expected:   278 }
      { id: 0x2, expected:   278 }
      { id: 0x3, expected:  4680 }
      { id: 0x4, expected:   278 }
      { id: 0x5, expected:  1056 }
      { id: 0x6, expected:  4680 }
      { id: 0x7, expected: 26752 }
      { id: 0x8, expected:   278 }
      { id: 0x9, expected:  4680 }
      { id: 0xA, expected:  1056 }
      { id: 0xB, expected: 26752 }
      { id: 0xC, expected:  4680 }
      { id: 0xD, expected: 26752 }
      { id: 0xE, expected: 26752 }
      { id: 0xF, expected: 32768 }
    ]

    tests.forEach ({id, expected}) ->
      it "for square with id #{id} returns id #{expected}", ->
        mockSquare = id: id
        possibilities = Possibilities.forSquare(mockSquare)
        expect(possibilities).to.be.ok.and.have.property('id', expected)
        expect(possibilities.id).to.equal(expected)

  describe '#@eliminiate()', ->
    parsePossibilities = (element) ->
      if toString.call(element) == "[object String]"
        Possibilities.forSquare(id: parseInt(element))
      else if toString.call(element) == "[object Number]"
        new Possibilities().addAll([element])
      else
        new Possibilities().addAll(element)

    tests = [
      { left: '2+', right: 0, result: [1,4,8]  }
      { left: '2+', right: 15, result: [2]  }
      { left: '13+', right: 0, result: [13]  }
      { left: '13+', right: 15, result: [7,11,14]  }
      { left: '13+', right: [1,2,4], result: [13]  }
      { left: [1,2,4], right: 0, result: [1,4]  }
      { left: [1,2,4], right: 1, result: [1,4]  }
      { left: [1,2,4], right: [1,4], result: [1,4]  }
      { left: 1, right: 15, result: []  }
      { left: [1,2,4], right: 15, result: [2]  }
      { left: '2+', right: '2+', result: [1,2,4,8]  }
    ]
    tests.forEach (test) ->
      left = parsePossibilities(test.left)
      right = parsePossibilities(test.right)
      it "turns #{left.toArray()} next to #{right.toArray()} to #{test.result}", ->
        left.eliminiate(right, 1)
        expect(left.toArray()).to.eql(test.result)
