class Game < ApplicationRecord
  belongs_to :first_server, class_name: 'Player', optional: true
  belongs_to :current_server, class_name: 'Player', optional: true
  has_and_belongs_to_many :players, inverse_of: :games
  has_many :points, dependent: :destroy, inverse_of: :game

  after_touch :update_status, :update_current_server, unless: :finished?

  accepts_nested_attributes_for :players, limit: 2

  enum status: { pending: 0, started: 1, deuce: 2, finished: 3 }

  def first_receiver
    return nil if first_server.nil?
    @first_receiver ||= opponent_for(first_server)
  end

  def first_server=(player)
    if players.include?(player)
      self.current_server = player
      return super(player)
    end

    server_not_a_player_error(:first_server)
  end

  def current_server=(player)
    return super(player) if players.include?(player)

    server_not_a_player_error(:current_server)
  end

  def total_points
    points.size
  end

  def score_for(player)
    points.score_for(player)
  end

  def opponent_for(player)
    players.to_a.delete_if { |opponent| opponent == player }.first
  end

  private

  def server_not_a_player_error(server)
    errors.add(server, :invalid, message: 'must be a player', strict: true)
  end

  def update_status
    update_column(:status, 1) if total_points == 1
    update_column(:status, 2) if to_deuce?
    update_column(:status, 3) if to_finished?
  end

  def update_current_server
    return if first_server.nil? || modified_total_points.zero?

    update_column(:current_server_id, current_server_id)
  end

  def modified_total_points
    modified_total_points = total_points
    modified_total_points -= 1 if modified_total_points.odd?
    modified_total_points / 2
  end

  def current_server_id
    if deuce?
      opponent_for(current_server)
    elsif modified_total_points.odd?
      first_receiver.id
    elsif modified_total_points.even?
      first_server.id
    end
  end

  def to_deuce?
    return false unless started?
    return true if score_arr.delete_if { |score| score >= 10 }.empty?
  end

  def score_arr
    [score_for(first_server), score_for(first_receiver)]
  end

  def to_finished?
    if score_arr.sum >= 20
      score_arr.max - score_arr.min == 2
    else
      score_arr.include?(11)
    end
  end
end
