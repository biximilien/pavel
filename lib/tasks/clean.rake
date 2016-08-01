namespace "clean" do
  directory "pavel/src"
  desc "removes all files from 'pavel/src' directory"
  task "src" => "pavel/src" do
    include Pavel::Linator
    clean_src_dir
  end

  directory "pavel/temp"
  desc "removes all files from 'pavel/temp' directory"
  task "temp" => "pavel/temp" do
    include Pavel::Linator
    clean_temp_dir
  end

  directory "pavel/dist"
  desc "removes all files from 'pavel/dist' directory"
  task "dist" => "pavel/dist" do
    include Pavel::Linator
    clean_target_dir
  end

  desc "removes all files from 'pavel/temp' and 'pavel/dist' directory"
  task "all" => [:dist, :temp]
end
