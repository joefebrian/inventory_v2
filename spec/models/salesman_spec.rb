require File.dirname(__FILE__) + '/../spec_helper'

describe Salesman do
  it "should be valid" do
    Salesman.new.should be_valid
  end
end
