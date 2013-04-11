# This file is used by Rack-based servers to start the application.

require ::File.expand_path('../config/environment',  __FILE__)
run Alpha::Application

# Unicorn self-process killer
require 'unicorn/worker_killer'

# Max requests per worker
max_request_min =  ENV['MAX_REQUEST_MIN'].to_i || 3072
max_request_max =  ENV['MAX_REQUEST_MAX'].to_i || 4096
use Unicorn::WorkerKiller::MaxRequests, max_request_min, max_request_max

# Max memory size (RSS) per worker
oom_min = ((ENV['OOM_MIN'].to_i || 192) * (1024**2))
oom_max = ((ENV['OOM_MAX'].to_i || 256) * (1024**2))
use Unicorn::WorkerKiller::Oom, oom_min, oom_max
