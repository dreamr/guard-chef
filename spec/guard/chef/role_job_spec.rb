# encoding: utf-8
require 'spec_helper'

describe RoleJob do
  subject { @job = RoleJob.new("base/path", "test") }
  
  describe "update" do
    it "should be true if it receives the 'Updated Role test!' message" do
      subject.should_receive(:`).
        with("cd base/path && rake role[test]").
        and_return( "Updated Role test!" )
        
      silence_stream(STDOUT) do
        subject.send(:update).should be(true)
      end
    end
  end
end