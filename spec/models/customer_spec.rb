require File.dirname(__FILE__) + '/../spec_helper'

describe Customer do
  let(:customer) { Factory(:customer) }
  it "should be valid" do
    customer.should be_valid
  end
end
