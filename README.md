# raki
[![Gem Version](https://badge.fury.io/rb/raki.png)](http://badge.fury.io/rb/raki)

Under heavy construction


## Specification

A Raki is a Ruby object (not a class) that responds to call.
It takes exactly one argument, the environment and returns an Array of
exactly three values: The status, the headers, and the body.

### The Environment

The environment must be a frozen instance of Hash.

## The Response

### The Status

This is an HTTP status. It must be an Integer greater than or equal to 100.

### The Headers

The header must respond to each, and yield values of key and value.

The header keys must be Strings.

The header must not contain a Status key.
The header must conform to RFC7230 token specification,
i.e. cannot contain non-printable ASCII, DQUOTE or â(),/:;<=>?@[]{}â.
The values of the header must be Strings,
consisting of lines (for multiple header values,
e.g. multiple Set-Cookie values) separated by â\nâ.
The lines must not contain characters below 037.

### The Content-Type

There must not be a Content-Type, when the Status is 1xx, 204 or 304.
The Content-Length

There must not be a Content-Length header when the Status is 1xx, 204 or 304.

### The Body

The Body must respond to each and must only yield String values.

If the Body responds to close, it will be called after iteration.
If the body is replaced by a middleware after action,
the original body must be closed first, if it responds to close.

If the Body responds to to_path,
it must return a String identifying the location of a file
whose contents are identical to that produced by calling each;
this may be used by the server as an alternative,
possibly more efficient way to transport the response.

The Body commonly is an Array of Strings,
the application instance itself, or a File-like object.

## Installation

Install the gem:

~~~
gem install raki
~~~

Or in your Gemfile:

~~~
# Gemfile
gem 'raki'
~~~

## Miscellaneous

Heavily inspired by Rack.

Raki is released under the MIT License.

[Code of Conduct](https://github.com/matique/matique/blob/main/CODE_OF_CONDUCT.md)
