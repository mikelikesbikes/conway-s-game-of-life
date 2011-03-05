require 'space'

class Game
  def initialize(*live_cells)
    @live_cells = live_cells
  end
  def empty?
    @live_cells.empty?
  end
  def turn!
    @live_cells = process_rules(@live_cells)
  end
  def is_alive?(*cell)
    @live_cells.include?(cell) 
  end

  private

  def process_rules(live_cells)
    stay_alive = @live_cells.select do |cell|
      stay_alive?(Space.live_neighbors(@live_cells, *cell))
    end
    become_alive = dead_neighbors(@live_cells).select do |cell|
      become_alive?(Space.live_neighbors(@live_cells, *cell))
    end
    become_alive | stay_alive
  end

  def stay_alive?(live_neighbors)
    live_neighbors >= 2 && live_neighbors <= 3
  end
  def become_alive?(live_neighbors)
    live_neighbors == 3
  end
  def dead_neighbors(live_cells)
    live_cells.inject([]) do |neighbors, cell| 
      neighbors | Space.neighbors(*cell)
    end - live_cells
  end
end
