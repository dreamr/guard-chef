class DataBagJob
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
    puts "uploading changed databag. (#{target}) Please wait."
    if /Updated data_bag_item/ =~ `#{base_cmd} && rake databag:upload[#{target}]`
      puts "databag (#{target}) uploaded."
      true
    else
      puts "databag (#{target}) could not be uploaded."
      false
    end
  end
end