require File.dirname(__FILE__) + '/../spec_helper'

describe MaterialRequest do
  it "should be valid" do
    MaterialRequest.new.should be_valid
  end
end
