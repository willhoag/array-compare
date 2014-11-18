'use strict'

arrayCompare = require('../src/index')

describe 'array-compare', ->

  sandwiches = [
    { sandwich: 'turkey', good: 'yes' },
    { sandwich: 'pbj', good: 'yes' },
    { sandwich: 'turkey', good: 'no' },
    { sandwich: 'blt', good: 'yes' }
  ]

  data1 = null
  data2 = null

  describe 'with id param', ->

    beforeEach ->
      data1 = [ sandwiches[0], sandwiches[1] ]
      data2 = [ sandwiches[2], sandwiches[3] ]

    it 'should return items in an array of paired objects found', ->
      found = arrayCompare(data1, data2, 'sandwich').found
      expect( found[0].a ).to.equal( sandwiches[0] )
      expect( found[0].b ).to.equal( sandwiches[2] )

    it 'should return the items in an array of objects missing', ->
      missing = arrayCompare(data1, data2, 'sandwich').missing
      expect( missing[0].a ).to.equal( sandwiches[1] )
      expect( missing[0].b ).to.be.undefined

    it 'should return items in an array of paird objects added', ->
      added = arrayCompare(data1, data2, 'sandwich').added
      expect(added[0].a).to.be.undefined
      expect(added[0].b).to.equal(sandwiches[3])

  describe 'without id param', ->

    beforeEach ->
      data1 = [ sandwiches[0], sandwiches[1] ]
      data2 = [ sandwiches[0], sandwiches[2] ]

    it 'should return items in an array of paired objects found', ->
      found = arrayCompare(data1, data2).found
      expect(found[0].a).to.equal(sandwiches[0])
      expect(found[0].b).to.equal(sandwiches[0])

    it 'should return the items in an array of objects missing', ->
      missing = arrayCompare(data1, data2).missing
      expect(missing[0].a).to.equal(sandwiches[1])
      expect(missing[0].b).to.be.undefined

    it 'should return items in an array of paird objects added', ->
      added = arrayCompare(data1, data2).added
      expect(added[0].a).to.be.undefined
      expect(added[0].b).to.equal(sandwiches[2])
