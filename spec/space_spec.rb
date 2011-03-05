require 'space'

describe Space do
  describe "neighbors for [1,1]" do
    let(:cell) { [1,1] }
    subject { Space.neighbors(*cell) }
    [
      [0,0],
      [0,1],
      [0,2],
      [1,0],
      [1,2],
      [2,0],
      [2,1],
      [2,2]
    ].each do |neighbor|
      it "should include #{neighbor.inspect}" do
        subject.should include(neighbor)
      end
    end
  end

  describe "live_neighbors for [1,1]" do
    let(:cell) { [1,1] }
    subject { Space.live_neighbors(live_cells, *cell) }
    context "with no live cells that are neighbors" do
      let(:live_cells) { [] }
      it { should == 0 } 
    end
    context "with 1 live cell that is a neighbor" do
      let(:live_cells) { [[0,0]] }
      it { should == 1 }
    end 
    context "with 2 live cells that are neighbors" do
      let(:live_cells) { [[0,0], [1,0]] }
      it { should == 2 }
    end
    context "with 3 live cells, only 2 that are neighbors" do
      let(:live_cells) { [[0,0], [1,0], [100,100]] }
      it { should == 2 }
    end
    context "with 8 live cells that are neighbors" do
      let(:live_cells) { [[0,0],[0,1],[0,2],[1,0],[1,2],[2,0],[2,1],[2,2]] }
      it { should == 8 }
    end
  end
end
