require File.dirname(__FILE__) + '/../spec_helper'

describe PurchaseReturn do
  it "should be valid" do
    PurchaseReturn.new.should be_valid
  end
end
