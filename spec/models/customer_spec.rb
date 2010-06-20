require File.dirname(__FILE__) + '/../spec_helper'

describe Customer do
  it "should be valid" do
    Customer.new.should be_valid
  end
end
