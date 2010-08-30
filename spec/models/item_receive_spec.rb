require File.dirname(__FILE__) + '/../spec_helper'

describe ItemReceive do
  it "should be valid" do
    ItemReceive.new.should be_valid
  end
end
