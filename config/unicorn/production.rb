RAILS_ENV = ENV["RAILS_ENV"] || "production"
RAILS_ROOT = "/home/web/idnet-example/current"

worker_processes 8
working_directory RAILS_ROOT

listen '/home/web/idnet-example/shared/tmp/sockets/unicorn.sock', :backlog => 2048
timeout 30

pid File.join("/home/web/idnet-example/shared/tmp/pids/unicorn.pid")

stderr_path File.join(RAILS_ROOT, "log/unicorn.stderr.log")
stdout_path File.join(RAILS_ROOT, "log/unicorn.stdout.log")

preload_app true
GC.copy_on_write_friendly = true if GC.respond_to?(:copy_on_write_friendly=)

before_exec do |server|
  ENV['BUNDLE_GEMFILE'] = File.join(RAILS_ROOT, 'Gemfile')
end

before_fork do |server, worker|
  # Before forking, kill the master process that belongs to the .oldbin PID.
  # This enables 0 downtime deploys.

  # Incremental kill-off
  old_pid = "#{server.config[:pid]}.oldbin"
  if old_pid != server.pid
    begin
      sig = (worker.nr + 1) >= server.worker_processes ? :QUIT : :TTOU
      puts "Sending #{sig} signal to old unicorn master..."
      Process.kill(sig, File.read(old_pid).to_i)
    rescue Errno::ENOENT, Errno::ESRCH
    end
  end

  # Throttle the master from forking too quickly by sleeping.
  sleep 1
end

after_fork do |server, worker|
  # if preload_app is true, then you may also want to check and
  # restart any other shared sockets/descriptors such as Memcached,
  # and Redis.  TokyoCabinet file handles are safe to reuse
  # between any number of forked children (assuming your kernel
  # correctly implements pread()/pwrite() system calls)
end
