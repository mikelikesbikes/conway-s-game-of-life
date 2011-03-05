require 'game'

describe Game do
  describe "initialization" do
    context "with no live cells" do
      subject { Game.new }
      it { should be_empty }
    end
    context "with live cells" do
      subject { Game.new([0,0]) }
      it { should_not be_empty }
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
    context "an oscillator" do
      let(:cells) { [[0,0],[0,1],[0,2]] }
      subject { Game.new(*cells) }
      #before { 2.times do subject.turn! end }
      it "should be back to the original after an extra turn" do
        subject.turn!
        cells.each do |cell|
          subject.is_alive?(*cell).should be_true
        end
      end
    end
  end
end
