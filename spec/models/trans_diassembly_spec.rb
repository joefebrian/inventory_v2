require File.dirname(__FILE__) + '/../spec_helper'

describe TransDiassembly do
  it "should be valid" do
    TransDiassembly.new.should be_valid
  end
end
