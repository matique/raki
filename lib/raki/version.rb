# frozen_string_literal: true

# Raki is freely distributable under the terms of an MIT-style license.
# See MIT-LICENSE or https://opensource.org/licenses/MIT.

# The Raki main module, serving as a namespace for all core Raki
# modules and classes.
#
# All modules meant for use in your application are <tt>autoload</tt>ed here,
# so it should be enough just to <tt>require 'rack'</tt> in your code.

module Raki
  VERSION = '0.0.2'
end
