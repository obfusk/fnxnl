desc 'Run specs'
task spec: %w{ spec:js spec:rb }

desc 'Run js specs'
task 'spec:js' do
  sh 'jasmine-node --coffee spec/js/'
end

desc 'Run rb specs'
task 'spec:rb' do
  sh 'rspec -c'
end

desc 'Run js specs verbosely'
task 'spec:js:verbose' do
  sh 'jasmine-node --coffee --verbose spec/js/'
end

desc 'Run rb specs verbosely'
task 'spec:rb:verbose' do
  sh 'rspec -cfd'
end

desc 'Run js specs verbosely, view w/ less'
task 'spec:js:less' do
  sh 'jasmine-node --coffee --verbose spec/js/ | less -R'
end

desc 'Run rb specs verbosely, view w/ less'
task 'spec:rb:less' do
  sh 'rspec -cfd --tty | less -R'
end

desc 'Generate docs'
task docs: %w{ docs:js docs:rb }

desc 'Generate js docs'
task 'docs:js' do
  sh 'docco -o doc/js lib/js/**.coffee'
end

desc 'Generate rb docs'
task 'docs:rb' do
  sh 'yardoc | cat'
end

desc 'List undocumented objects'
task 'docs:undoc' do
  sh 'yard stats --list-undoc'
end

desc 'Cleanup'
task :clean do
  js = Dir['lib/js/**.js'] * ' '
  sh "rm -rf .yardoc/ doc/ node_modules/ #{js} *.gem"
end

desc 'Update Pages'
task :pages do
  sh 'rake clean && rake docs:js'
  sh 'git checkout gh-pages'
  sh 'rake cpdocs'
  sh 'git add .'
  sh 'git status'
  puts 'press enter to continue ...'; $stdin.readline
  sh 'git commit -m ...'
  sh 'git checkout master'
end
