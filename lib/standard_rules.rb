require 'space'

class StandardRules
  def self.process(live_cells)
    stay_alive = live_cells.select do |cell|
      stay_alive?(Space.live_neighbors(live_cells, *cell))
    end
    become_alive = Space.dead_neighbors(live_cells).select do |cell|
      become_alive?(Space.live_neighbors(live_cells, *cell))
    end
    become_alive | stay_alive
  end

  private

  def self.stay_alive?(live_neighbors)
    live_neighbors >= 2 && live_neighbors <= 3
  end

  def self.become_alive?(live_neighbors)
    live_neighbors == 3
  end
end
