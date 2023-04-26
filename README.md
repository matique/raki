# Raki
[![Gem Version](https://badge.fury.io/rb/raki.png)](http://badge.fury.io/rb/raki)

The Raki specification enables a kind of piping objects.

The composing is done by Raki::Chain and Raki::Builder.

## Installation

As usual:
```ruby
# Gemfile
gem "raki"
```
and run "bundle install".

## Specification

A Raki is a Ruby object (not a class) that responds to "call".
It takes exactly one argument, a Hash, and returns a result, again a Hash.

Rakis are stackable due to the generality of its argument and result.

Sometimes it is expected that a Raki delivers an array of strings as
part of the result.
The convention is that this array is accessed as "result[:body]".

## Simple Raki

A simple Raki (a proc/lambda can be a Raki):

~~~
raki = ->(hsh) { {body: ["Hello World!"]} }
~~~

and a little more complex:

~~~
raki = ->(hsh) { {body: ["Hi #{hsh[:name]!", "Nice to meet you."] } }
~~~

## Middleware

A Raki::Middleware is a Raki that calls another Raki enabling
"before" and "after" code, i.e. operations around the second Raki.

A Raki middleware is ready to be stacked.

A sample for a Raki middleware:

~~~ruby
# already included in "gem raki"
module Raki
  class Middleware
    def initialize(app)
      @app = app
    end
  end
end


# your sample
class SampleMiddleware < Raki::Middleware
  def call(env)
    # do something before
    result = @app.call(env) # if @app
    # do something after
    result[:body] << "My grain of salt."
    result
  end
end
~~~

## Composing

### Raki::Chain

Raki::Chain chains Rakis.
In particular, it will forward the result of a previous Raki
as the argument of the next one.
The argument for the first Raki is the arguent of the "call".
The return value is the result of the last Raki.

A sample:

~~~
class Cl < Raki::Base
  def call(env)
    env + @args.first
  end
end

proca = ->(env) { env + "a" }
app = Raki::Chain.new do
  add Cl, "C"
  add proca
  add { |env| env + "b" }
  add ->(env) { env + "c" }
end

app.call("") # --> "Cabc"
~~~

### Raki::Builder

Raki::Builder chains Raki::Middleware.
In particular, the "@app" is initialized for each middleware.
The last middleware "@app" is initialized to "nil".

It is expected that each middleware takes care to call the next one.

A sample:

~~~
class MW < Raki::Middleware
  def call(env)
    result = env + @args.first
    return result unless @app

    @app.call(result)
  end
end

app = Raki::Builder.new do
  add MW, "a"
  add MW, "b"
end

app.call("") # --> "ab"

~~~

### Recommendations

Implement a Raki as idempotent, i.e. same arguments delivers same results.

It is always a good idea to avoid side-effects.

Frozen arguments may avoid some strange behaviour.

## Miscellaneous

Heavily inspired by Rack.

Copyright (c) 2020-2023 Dittmar Krall (www.matiq.com),
released under the MIT license:

* https://opensource.org/licenses/MIT
