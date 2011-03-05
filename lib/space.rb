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
end
