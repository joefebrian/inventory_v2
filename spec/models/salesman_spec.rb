require File.dirname(__FILE__) + '/../spec_helper'

describe Salesman do
  let(:salesman) { Factory(:salesman) }
  it "should be valid" do
    salesman.should be_valid
  end
end
