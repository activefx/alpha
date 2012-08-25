# this file loads first so other initializers have access
require 'configatron'
Configatron::Rails.init

require File.join(Rails.root, "lib", "core_ext.rb")
require File.join(Rails.root, "lib", "simple_form", "label_nested_input.rb")
