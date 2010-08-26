require File.dirname(__FILE__) + '/../spec_helper'

describe TransAssembly do
  it "should be valid" do
    TransAssembly.new.should be_valid
  end
end
