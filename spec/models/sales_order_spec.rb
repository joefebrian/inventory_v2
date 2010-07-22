require File.dirname(__FILE__) + '/../spec_helper'

describe SalesOrder do
  it "should be valid" do
    SalesOrder.new.should be_valid
  end
end
