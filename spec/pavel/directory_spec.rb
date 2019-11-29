require 'spec_helper'

module Pavel
  RSpec.describe Directory do
    describe ".temp" do
      it "returns the 'temp' directory" do
        expect(Directory.temp).to be_a(Directory)
        expect(Directory.temp.path).to eql(Pavel[:temp][:path])
      end
    end

    describe ".source" do
      it "returns the 'source' directory" do
        expect(Directory.source).to be_a(Directory)
        expect(Directory.source.path).to eql(Pavel[:source][:path])
      end
    end

    describe ".target" do
      it "returns the 'target' directory" do
        expect(Directory.target).to be_a(Directory)
        expect(Directory.target.path).to eql(Pavel[:target][:path])
      end
    end

    describe "#exist?" do
      it "returns true if the directory exists" do
        expect(Directory.source.exist?).to be true
        expect(Directory.target.exist?).to be true
        expect(Directory.temp.exist?).to be true
      end
    end

  end
end
