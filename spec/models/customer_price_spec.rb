require File.dirname(__FILE__) + '/../spec_helper'

describe CustomerPrice do
  it "should be valid" do
    CustomerPrice.new.should be_valid
  end
end
