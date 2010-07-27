require File.dirname(__FILE__) + '/../spec_helper'

describe Currency do
  it "should be valid" do
    Currency.new.should be_valid
  end
end
