class RoleJob
  def initialize(base_dir, target)
    @base_dir, @target = base_dir, target
  end
  
  def base_cmd
    "cd #{@base_dir}"
  end

  def target
    @target
  end

  def update
    puts "uploading changed role. (#{target}) Please wait."
    if /Updated Role #{target}!/ =~ `#{base_cmd} && rake role[#{target}]`
      puts "role (#{target}) uploaded."
      true
    else
      puts "role (#{target}) could not be uploaded."
      false
    end
  end
end