require 'rubygems'
require 'rake'
require 'rake/rdoctask'
require 'rake/gempackagetask'

spec = Gem::Specification.new do |s|
  s.name = 'to_erb'
  s.version = '0.0.1'
  s.author = 'Dario Seminara'
  s.email = 'robertodarioseminara@gmail.com'
  s.platform = Gem::Platform::RUBY
  s.summary = 'Haml to erb conversion tool'
  s.add_dependency "haml"
  s.add_dependency "ruby2ruby"
  s.add_dependency "ruby_parser"
  s.homepage = "http://github.com/tario/to_erb"
  s.executables = ["to_erb"]
  s.has_rdoc = true
  s.extra_rdoc_files = [ 'README' ]
  s.files = Dir.glob("{lib,bin}/**/*") +[ 'AUTHORS', 'README', 'Rakefile', 'CHANGELOG' ]
end

desc 'Generate RDoc'
Rake::RDocTask.new :rdoc do |rd|
  rd.rdoc_dir = 'doc'
  rd.rdoc_files.add 'lib', 'README'
  rd.main = 'README'
end

desc 'Build Gem'
Rake::GemPackageTask.new spec do |pkg|
  pkg.need_tar = true
end

desc 'Clean up'
task :clean => [ :clobber_rdoc, :clobber_package ]

desc 'Clean up'
task :clobber => [ :clean ]


