# RunThisAsync

RunThisAsync allows you to call any chain of methods on a class (or object) asynchronously inside a sidekiq job.

Why? So that you don't have to write a job that just calls your service object every time you need to run something asynchronously.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'run_this_async'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install run_this_async

## Usage

By calling:

```ruby
YourKlass.run_this.new(1, 2, 3).call.async
```

You get:

```ruby
YourKlass.new(1, 2, 3).call
```

Scheduled to be performed asynchronously inside the RunThisAsync::AsyncRunner sidekiq job.

## More

Check the spec here: https://github.com/fenoloftaleina/run_this_async/blob/master/spec/run_this_async_spec.rb.

## Contributing

Pull requests are very much welcome.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
