require File.dirname(__FILE__) + '/../spec_helper'

describe Currncy do
  it "should be valid" do
    Currncy.new.should be_valid
  end
end
