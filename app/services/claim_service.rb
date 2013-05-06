class ClaimService
  attr_reader :claim

  def initialize(claim = nil)
    @claim = claim
  end

  def create(attributes)
    @claim = Claim.create(attributes)
    if claim.persisted?
      board.table.users.each do |user|
        user.publish event: "claim/update", data: ClaimSerializer.new(claim)
        data = BoardSerializer.new(board, scope: user, scope_name: :current_user, only: claim.direction.downcase.to_sym)
        user.publish event: "board/update", data: data
      end
    end
    claim
  end

  def accept(direction)
    if result = claim.accept(direction)
      board.update!(result: board.score.result) if claim.accepted?

      board.table.create_board!

      board.table.users.each do |user|
        user.publish event: "claim/update", data: ClaimSerializer.new(claim)
        user.publish event: "board/update", data: BoardSerializer.new(board, scope: user, scope_name: :current_user, only: :result) if claim.accepted?
        # New board
        user.publish event: "table/update", data: TableSerializer.new(board.table, scope: user, scope_name: :current_user)
      end
    end
    result
  end

  def reject(direction)
    if result = claim.reject(direction)
      board.table.users.each do |user|
        user.publish event: "claim/update", data: ClaimSerializer.new(claim)
        user.publish event: "board/update", data: BoardSerializer.new(board, scope: user, scope_name: :current_user, only: claim.direction.downcase.to_sym)
      end
    end
    result
  end

  private

  def board
    @board ||= claim.board
  end
end
