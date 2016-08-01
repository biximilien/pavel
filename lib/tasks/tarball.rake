directory "pavel/dist"

desc "compresses the distribution files in a tarball"
task "tarball" => "pavel/dist" do
  sh 'tar czvf pavel/pavel.tar.gz pavel/dist'
end
