require File.dirname(__FILE__) + '/../spec_helper'

describe TaxProfile do
  it "should be valid" do
    TaxProfile.new.should be_valid
  end
end
