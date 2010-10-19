require File.dirname(__FILE__) + '/../spec_helper'

describe CustomerDownPayment do
  it "should be valid" do
    CustomerDownPayment.new.should be_valid
  end
end
