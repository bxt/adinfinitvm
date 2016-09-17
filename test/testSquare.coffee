expect = require('chai').expect

Square = require('../src/model/Square')

describe 'Square', ->

  describe '#checkMatch()', ->
    tests =
      0: [
        { one: 0x0, two: 0x1, expected: true }
        { one: 0x0, two: 0x2, expected: true }
        { one: 0x0, two: 0x4, expected: false }
        { one: 0x0, two: 0x8, expected: true }
        { one: 0x7, two: 0x1, expected: false }
        { one: 0xB, two: 0x2, expected: false }
        { one: 0xD, two: 0x1, expected: false }
        { one: 0xE, two: 0x2, expected: true }
        { one: 0xF, two: 0x1, expected: false }
        { one: 0xF, two: 0x2, expected: false }
        { one: 0xF, two: 0x4, expected: true }
        { one: 0xF, two: 0x8, expected: false }
        { one: 0x5, two: 0x5, expected: true }
        { one: 0x5, two: 0xA, expected: false }
      ]
      1: [
        { one: 0x0, two: 0x1, expected: true }
        { one: 0x0, two: 0x2, expected: true }
        { one: 0x0, two: 0x4, expected: true }
        { one: 0x0, two: 0x8, expected: false }
        { one: 0x7, two: 0x1, expected: false }
        { one: 0xB, two: 0x2, expected: false }
        { one: 0xD, two: 0x1, expected: true }
        { one: 0xE, two: 0x2, expected: false }
        { one: 0xF, two: 0x1, expected: false }
        { one: 0xF, two: 0x2, expected: false }
        { one: 0xF, two: 0x4, expected: false }
        { one: 0xF, two: 0x8, expected: true }
        { one: 0x5, two: 0x5, expected: true }
        { one: 0x5, two: 0xA, expected: false }
      ]
      2: [
        { one: 0x0, two: 0x1, expected: false }
        { one: 0x0, two: 0x2, expected: true }
        { one: 0x0, two: 0x4, expected: true }
        { one: 0x0, two: 0x8, expected: true }
        { one: 0x7, two: 0x1, expected: true }
        { one: 0xB, two: 0x2, expected: true }
        { one: 0xD, two: 0x1, expected: true }
        { one: 0xE, two: 0x2, expected: false }
        { one: 0xF, two: 0x1, expected: true }
        { one: 0xF, two: 0x2, expected: false }
        { one: 0xF, two: 0x4, expected: false }
        { one: 0xF, two: 0x8, expected: false }
        { one: 0x5, two: 0x5, expected: true }
        { one: 0x5, two: 0xA, expected: false }
      ]
      3: [
        { one: 0x0, two: 0x1, expected: true }
        { one: 0x0, two: 0x2, expected: false }
        { one: 0x0, two: 0x4, expected: true }
        { one: 0x0, two: 0x8, expected: true }
        { one: 0x7, two: 0x1, expected: true }
        { one: 0xB, two: 0x2, expected: true }
        { one: 0xD, two: 0x1, expected: false }
        { one: 0xE, two: 0x2, expected: true }
        { one: 0xF, two: 0x1, expected: false }
        { one: 0xF, two: 0x2, expected: true }
        { one: 0xF, two: 0x4, expected: false }
        { one: 0xF, two: 0x8, expected: false }
        { one: 0x5, two: 0x5, expected: true }
        { one: 0x5, two: 0xA, expected: false }
      ]
    for quad, subtests of tests
      do (quad, subtests) ->
        context "when quad is #{quad}", ->
          subtests.forEach (test) ->
            it "#{test.expected} for square with id #{test.one} adjacent to id #{test.two}", ->
              actual = new Square(test.one).checkMatch(new Square(test.two), quad)
              expect(actual).to.equal(test.expected)
