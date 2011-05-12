require 'guard'
require 'guard/guard'
require 'active_support/inflector'

Dir[File.expand_path('../chef/*_job.rb',  __FILE__)].each {|f| require f}

module Guard
  class Chef < Guard
    def initialize(watchers=[], options={})
      super
      @base_dir = ::File.expand_path('../../../',  __FILE__)
      # init stuff here, thx!
    end

    # =================
    # = Guard methods =
    # =================

    # If one of those methods raise an exception, the Guard::GuardName instance
    # will be removed from the active guards.

    # Called once when Guard starts
    # Please override initialize method to init stuff
    def start
      true
    end

    # Called on Ctrl-C signal (when Guard quits)
    def stop
      true
    end

    # Called on Ctrl-Z signal
    # This method should be mainly used for "reload" (really!) actions like reloading passenger/spork/bundler/...
    def reload
      true
    end

    # Called on Ctrl-/ signal
    # This method should be principally used for long action like running all specs/tests/...
    def run_all
      true
    end

    # Called on file(s) modifications
    def run_on_change(paths)
      paths.each do |path|
        unless updated?(path)
          return false
        end
      end
      true
    end
    
  private
  
    def updated?(path)
      target = perform(path)
      unless target.nil?
        target.update
        return true
      end
      false
    end
  
    def perform(path)
      begin
        matches = path.split("/")
        type, target = "#{matches[0].classify}Job", matches[1]
        type.constantize.new(@base_dir, target.gsub(".rb", ''))
      rescue Exception
        puts "#{type.classify} is not a valid watch type"
        nil
      end
    end
  end
end