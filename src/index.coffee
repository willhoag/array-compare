'use strict'

isObject = require('mout/lang/isObject')
findIndex = require('mout/array/findIndex')

arrayCompare = (a, b, id) ->

  missing = []
  found = []
  added = []

  # take objec with properites for arguements
  if isObject(a) then { a, b, id } = a

  bCopy = b.slice()

  # loop through a
  for aItem, aIndex in a

    bIndex = -1

    # compare by key
    if id
      search = {}
      search[id] = aItem[id]
      bIndex = findIndex(bCopy, search)

    # compare by reference
    else
      bIndex = bCopy.indexOf(aItem)

    # if found
    if bIndex isnt -1

      found.push
        a: aItem
        b: bCopy.splice(bIndex, 1)[0]

    else
      missing.push
        a: aItem

  # add remaining items to added array
  for bCopyItem in bCopy
    added.push
      b: bCopyItem

  return {
    found: found
    missing: missing
    added: added
  }

module.exports = arrayCompare
