source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

gem 'rails',                    '~> 5.1.4'
gem 'sqlite3'
gem 'puma',                     '~> 3.7'
gem 'sass-rails',               '~> 5.0'
gem 'uglifier',                 '>= 1.3.0'
gem 'coffee-rails',             '~> 4.2'
gem 'turbolinks',               '~> 5'
gem 'jbuilder',                 '~> 2.5'
gem 'jquery-rails',             '~> 4.3', '>= 4.3.1'
gem 'bootstrap',                '~> 4.0'
gem 'bootstrap-glyphicons',     '~> 0.0.1'

group :development, :test do
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'rspec-rails',            '~> 3.7', '>= 3.7.2'
end

group :test do
  gem 'capybara',               '~> 2.17'
end

group :development do
  gem 'web-console',            '>= 3.3.0'
  gem 'listen',                 '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen',  '~> 2.0.0'
  gem 'guard',                  '~> 2.14', '>= 2.14.2'
  gem 'guard-rspec',            '~> 4.7', '>= 4.7.3'
end

gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
