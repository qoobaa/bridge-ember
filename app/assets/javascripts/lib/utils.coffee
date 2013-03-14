@Bridge.Utils =
  sortCards: (cards, trump) =>
    sorted = []
    suits = (cards.map (card) -> card[0]).uniq()
    Bridge.Utils.sortCardSuits(suits, trump).forEach (suit) ->
      cardsInSuit = cards.filter (card) -> card[0] == suit
      Bridge.Utils.sortCardValues(cardsInSuit.map (card) -> card[1]).forEach (value) ->
        sorted.push(suit + value)
    sorted

  sortCardValues: (values) ->
    sortedValues = ["A", "K", "Q", "J", "T", "9", "8", "7", "6", "5", "4", "3", "2"]
    values.sort (a, b) ->
      sortedValues.indexOf(a) - sortedValues.indexOf(b)

  sortCardSuits: (suits, trump) ->
    black = ["S", "C"].filter (s) -> s in suits
    red   = ["H", "D"].filter (s) -> s in suits
    if black.contains(trump)
      black.splice(black.indexOf(trump), 1).concat(red.splice(0, 1)).concat(black.splice(0, 1)).concat(red.splice(0, 1))
    else if red.contains(trump)
      red.splice(red.indexOf(trump), 1).concat(black.splice(0, 1)).concat(red.splice(0, 1)).concat(black.splice(0, 1))
    else if black.length >= red.length
      black.splice(0, 1).concat(red.splice(0, 1)).concat(black.splice(0, 1)).concat(red.splice(0, 1))
    else
      red.splice(0, 1).concat(black.splice(0, 1)).concat(red.splice(0, 1)).concat(black.splice(0, 1))
