json.board do |json|
  json.dealer @board.dealer
  json.vulnerable @board.vulnerable
  json.contract @board.contract

  json.bids @board.bids.map(&:content)
  json.cards @board.cards.map(&:content)
end
