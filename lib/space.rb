require 'set'

class Space
  def self.neighbors(*coords)
    [
      [coords[0] - 1, coords[1] - 1],
      [coords[0] - 1, coords[1]],
      [coords[0] - 1, coords[1] + 1],
      [coords[0], coords[1] - 1],
      [coords[0], coords[1] + 1],
      [coords[0] + 1, coords[1] - 1],
      [coords[0] + 1, coords[1]],
      [coords[0] + 1, coords[1] + 1],
    ]
  end

  def self.live_neighbors(live_cells, *coords)
    neighbors(*coords).select{|cell| live_cells.include? cell}.length
  end

  def self.dead_neighbors(live_cells)
    live_cells.inject(Set.new) do |neighbors, cell| 
      neighbors | Space.neighbors(*cell)
    end - live_cells
  end
end
