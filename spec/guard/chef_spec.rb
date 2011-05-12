# encoding: utf-8
require 'spec_helper'

describe Guard::Chef do
  subject { @chef_guard = Guard::Chef.new }
  
  before(:each) do
    @base_dir = ::File.expand_path('../../../spec/support/chef-repo/',  __FILE__)
  end
  
  describe "private methods" do
    describe "updated?(path)" do
      it "should return false if perform fails" do
        subject.stub(:perform).and_return(nil)
        silence_stream(STDOUT) do
          subject.send(:updated?, "cookbooks/something/metadata.rb").should be(false)
        end
      end
      
      it "should return true if perform succeeds" do
        subject.stub(:perform) {
          CookbookJob.new(@base_dir, "test")
        }
        silence_stream(STDOUT) do
          subject.send(:updated?, "cookbooks/test/metadata.rb").should be(true)
        end
      end
    end
    
    describe "perform(path)" do
      it "should return nil if the path does not match a type" do
        silence_stream(STDOUT) do
          subject.send(:perform, "badpath/test/metadata.rb").should be(nil)
        end
      end
      
      it "should return a job object if it matches a type" do
        silence_stream(STDOUT) do
          subject.send(:perform, "cookbooks/test/metadata.rb").target.should ==
            CookbookJob.new(@base_dir, "test").target
        end
      end
    end
  end

  context 'start' do
    # noop
  end

  context 'reload' do
    # noop
  end

  context 'run_all' do
    # noop
  end

  context 'run_on_change' do
    it "should return true if updated?" do
      subject.stub(:updated?) { true }
      subject.send(:run_on_change, ["some/resource/path"]).should be(true)
    end
    
    it "should return false unless updated?" do
      subject.stub(:updated?) { false }
      subject.send(:run_on_change, ["some/resource/path"]).should be(false)
    end
    
  end

end