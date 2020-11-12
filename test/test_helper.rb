# frozen_string_literal: true

if ENV.delete('COVERAGE')
  require 'simplecov'

  def SimpleCov.rack_coverage(**opts)
    start do
      add_filter "/test/"
    end
  end
  SimpleCov.rack_coverage
end

$:.unshift(File.expand_path('../lib', __dir__))
require_relative '../lib/raki'
require 'minitest/global_expectations/autorun'
require 'stringio'
