require File.dirname(__FILE__) + '/../spec_helper'

describe CreditDebitNote do
  it "should be valid" do
    CreditDebitNote.new.should be_valid
  end
end
