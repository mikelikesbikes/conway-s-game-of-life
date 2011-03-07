require 'standard_rules'

describe StandardRules do
  describe "process" do
    subject { StandardRules.process(cells) }
    context "with no live cells" do
      let(:cells) { [] }
      it { should be_empty }
    end
    context "death by under-population" do
      let(:cells) { [[0,0]] }
      it { should be_empty }
    end
    context "staying alive by 2 live neighbors" do
      let(:cells) { [[0,0],[0,1],[0,2]] }
      it { should_not be_empty }
      it { should include([0, 1]) }
    end
    context "staying alive by 3 live neighbors" do
      let(:cells) { [[0,1],[1,0],[1,1],[1,2]] }
      it { should_not be_empty }
      it { should include([1, 1]) }
    end
    context "death by over-population" do
      let(:cells) { [[0,1],[1,0],[1,1],[1,2],[0,2]] }
      it { should_not be_empty }
      it { should_not include([1, 1]) }
    end
    context "coming to life by reproduction" do
      let(:cells) { [[0,0],[1,0],[1,1]] }
      it { should_not be_empty }
      it { should include([0, 1]) }
    end
  end
end
