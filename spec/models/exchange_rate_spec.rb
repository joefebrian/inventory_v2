require File.dirname(__FILE__) + '/../spec_helper'

describe ExchangeRate do
  it "should be valid" do
    ExchangeRate.new.should be_valid
  end
end
