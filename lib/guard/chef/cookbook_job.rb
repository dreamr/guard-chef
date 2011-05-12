class CookbookJob
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
    puts "uploading changed cookbook. (#{target}) Please wait."
    if /upload complete/ =~ `#{base_cmd} && rake upload_cookbook[#{target}]`
      puts "cookbook (#{target}) uploaded."
      true
    else
      puts "cookbook (#{target}) could not be uploaded."
      false
    end
  end
end