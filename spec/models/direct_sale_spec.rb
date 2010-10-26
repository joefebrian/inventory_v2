require File.dirname(__FILE__) + '/../spec_helper'

describe DirectSale do
  it "should be valid" do
    DirectSale.new.should be_valid
  end
end
