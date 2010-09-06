require File.dirname(__FILE__) + '/../spec_helper'

describe DeliveryOrder do
  it "should be valid" do
    DeliveryOrder.new.should be_valid
  end
end
