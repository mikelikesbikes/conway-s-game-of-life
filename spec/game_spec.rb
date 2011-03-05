require 'game'

describe Game do
  describe "initialization" do
    context "with no live cells" do
      subject { Game.new }
      it { should be_empty }
      it { subject.live_cell_count.should == 0 }
    end
    context "with live cells" do
      subject { Game.new([0,0]) }
      it { should_not be_empty }
      it { subject.live_cell_count.should == 1 }
    end
  end

  describe "turn!" do
    before { subject.turn! }
    context "with no live cells" do
      subject { Game.new }
      it { should be_empty }
    end
    context "death by under-population" do
      subject { Game.new([0,0]) }
      it { should be_empty }
      it "[0, 0] should be dead" do
        subject.is_alive?(0,0).should be_false
      end
    end
    context "staying alive by 2 live neighbors" do
      let(:cells) { [[0,0],[0,1],[0,2]] }
      subject { Game.new(*cells) }
      it { should_not be_empty }
      it "[0, 1] should be alive" do
        subject.is_alive?(0,1).should be_true
      end
    end
    context "staying alive by 3 live neighbors" do
      let(:cells) { [[0,1],[1,0],[1,1],[1,2]] }
      subject { Game.new(*cells) }
      it { should_not be_empty }
      it "[1, 1] should be alive" do
        subject.is_alive?(1,1).should be_true
      end
    end
    context "death by over-population" do
      subject { Game.new([0,1],[1,0],[1,1],[1,2],[0,2]) }
      it { should_not be_empty }
      it "[1, 1] should be dead" do
        subject.is_alive?(1,1).should be_false
      end
    end
    context "coming to life by reproduction" do
      subject { Game.new([0,0],[1,0],[1,1]) }
      it { should_not be_empty }
      it "[0, 1] should be alive" do
        subject.is_alive?(0,1).should be_true
      end
    end
  end
  describe "interesting patterns" do
    subject { Game.new(*cells) }
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
