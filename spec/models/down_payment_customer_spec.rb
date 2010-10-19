require File.dirname(__FILE__) + '/../spec_helper'

describe DownPaymentCustomer do
  it "should be valid" do
    DownPaymentCustomer.new.should be_valid
  end
end
