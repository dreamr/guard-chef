# encoding: utf-8
require 'spec_helper'

describe DataBagJob do
  subject { @job = DataBagJob.new("base/path", "test") }
  
  describe "update" do
    it "should be true if it receives the 'Updated data_bag_item' message" do
      subject.should_receive(:`).
        with("cd base/path && rake databag:upload[test]").
        and_return( "Updated data_bag_item" )
        
      silence_stream(STDOUT) do
        subject.send(:update).should be(true)
      end
    end
  end
end