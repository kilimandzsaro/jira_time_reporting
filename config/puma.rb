require "dotenv"

Dotenv.load(".env")

threads_count = ENV['RAILS_MAX_THREADS'] || 5
threads threads_count, threads_count

rails_port = ENV['PORT'] || 3000
port rails_port

rails_env = ENV['RAILS_ENV'] || "development"
environment rails_env

plugin :tmp_restart
