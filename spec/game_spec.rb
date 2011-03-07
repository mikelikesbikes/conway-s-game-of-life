require 'game'

describe Game do
  describe "initialization" do
    context "with no live cells" do
      subject { Game.new }
      it { should be_empty }
      it { subject.live_cell_count.should == 0 }
    end
    context "with live cells" do
      subject { Game.new(:live_cells => [[0,0]]) }
      it { should_not be_empty }
      it { subject.live_cell_count.should == 1 }
    end
  end

  describe "turn!" do
    let(:rules_engine) { 
      mock("StandardRules").tap do |mock|
        mock.should_receive(:process).with(live_cells).and_return([])
      end
    }
    let(:live_cells) { [[0,0]] }
    subject { Game.new(:live_cells => live_cells, :rules_engine => rules_engine) }
    it "should process the rules" do 
      subject.turn!
    end
  end
  describe "interesting patterns" do
    subject { Game.new(:live_cells => cells) }
    context "an oscillator" do
      let(:cells) { [[0,0],[0,1],[0,2]] }
      before { 2.times do subject.turn! end }
      it "should be back to the original after an extra turn" do
        cells.each do |cell|
          subject.is_alive?(*cell).should be_true
        end
      end
    end

    context "a simple glider" do
      let(:cells) { [[0,1],[1,2],[2,0],[2,1],[2,2]] }
      before { 5*4.times do subject.turn! end }
      it { should_not be_empty }
      it { subject.live_cell_count.should == 5 }
    end

    context "diehard pattern" do
      let(:cells) { [
        [0,1],[1,1],[1,2],
        [5,2],[6,2],[7,2],
        [6,0]
      ]}
      it "is still going after 129 turns" do
        129.times { subject.turn! }
        subject.should_not be_empty
      end
      it "stops after 130 turns" do
        130.times { subject.turn! }
        subject.should be_empty
      end
    end
  end
end
