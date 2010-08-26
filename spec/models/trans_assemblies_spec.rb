require File.dirname(__FILE__) + '/../spec_helper'

describe TransAssemblies do
  it "should be valid" do
    TransAssemblies.new.should be_valid
  end
end
