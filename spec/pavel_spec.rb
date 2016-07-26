require 'spec_helper'

RSpec.describe Pavel do

  describe ".source" do
    describe :path do
      it "has a path defined" do
        expect(Pavel.source[:path]).not_to be_nil
        expect(Pavel.source[:path]).to be_a(String)
      end
    end

    describe :encoding do
      it "has an encoding defined" do
        expect(Pavel.source[:encoding]).not_to be_nil
        expect(Pavel.source[:encoding]).to be_a(String)
      end
    end
  end

  describe ".target" do
    describe :path do
      it "has a path defined" do
        expect(Pavel.target[:path]).not_to be_nil
        expect(Pavel.target[:path]).to be_a(String)
      end
    end

    describe :encoding do
      it "has an encoding defined" do
        expect(Pavel.target[:encoding]).not_to be_nil
        expect(Pavel.target[:encoding]).to be_a(String)
      end
    end
  end

end
