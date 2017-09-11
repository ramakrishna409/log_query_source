Logs the source of execution of all queries to the Rails log. Helpful to track down where queries are being executed in your application, for performance optimizations most likely.

## Install
Install the latest stable release:

`gem install log_query_source`

In Rails, add it to your Gemfile, then restart the server:

```ruby
gem 'log_query_source', '~> 0.0.7''
```

## Usage

There are three levels of debug.

1. app - includes only files in your app/, lib/, and engines/ directories.
2. rails - includes files in your app as well as rails.
3. full - alternate output of full backtrace, useful for debugging gems.

```ruby
LogQuerySource.level = :app # default
```
Additionally, if you are working with a large app, you may wish to limit the number of lines displayed for each query.

```ruby
LogQuerySource.lines = 10 # Default is 1. Setting to 0 includes entire trace.
```

