require 'space'
require 'standard_rules'

class Game
  def initialize(options = {})
    @live_cells = options[:live_cells] || []
    @rules_engine = options[:rules_engine] || StandardRules
  end
  def empty?
    @live_cells.empty?
  end
  def turn!
    @live_cells = @rules_engine.process(@live_cells)
  end
  def is_alive?(*cell)
    @live_cells.include?(cell) 
  end
  def live_cell_count
    @live_cells.length
  end
end
