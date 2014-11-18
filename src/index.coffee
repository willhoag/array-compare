'use strict'

findIndex = require('mout/array/findIndex')
isObject = require('mout/lang/isObject')

arrayCompare = (a, b, id) ->

  missing = []
  found = []
  added = []

  # take objec with properites for arguements
  if isObject(a) then { a, b, id } = a

  bCopy = b.slice()

  # loop through a
  for aItem, aIndex in a

    search = {}

    # use id or item for search
    if id
      search[id] = aItem[id]
    else
      search = aItem

    # find item index
    bIndex = findIndex(b, search)

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
