require 'rbconfig'
HOST_OS = RbConfig::CONFIG['host_os']

if defined?(Footnotes) && Rails.env.development?
  Footnotes.run! # first of all

  if HOST_OS =~ /linux/i
    Footnotes::Filter.prefix = 'gedit://%s&line=%d&column=%d'
  end
  # ... other init code
end

