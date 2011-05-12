# encoding: utf-8
require 'spec_helper'

describe CookbookJob do
  subject { @job = CookbookJob.new("base/path", "test") }
  
  describe "update" do
    it "should be true if it receives the 'upload complete' message" do
      subject.should_receive(:`).
        with("cd base/path && rake upload_cookbook[test]").
        and_return( "upload complete" )
        
      silence_stream(STDOUT) do
        subject.send(:update).should be(true)
      end
    end
  end
end