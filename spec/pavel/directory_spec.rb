require 'spec_helper'

RSpec.describe Pavel::Directory do
  describe ".source_exists?" do
    it "returns true if source directory is present" do
      expect(Pavel::Directory.source_exists?).to be true
    end
  end

  describe ".target_exists?" do
    it "returns true if target directory is present" do
      expect(Pavel::Directory.target_exists?).to be true
    end
  end
end
