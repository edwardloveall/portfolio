workers 1
threads 1, 6
environment 'production'
app_dir = File.expand_path('../../..', __FILE__)
bind "unix://#{app_dir}/tmp/sockets/puma.sock"
stdout_redirect "#{app_dir}/log/puma.stdout.log",
                "#{app_dir}/log/puma.stderr.log",
                true
pidfile "#{app_dir}/tmp/pids/puma.pid"
state_path "#{app_dir}/tmp/pids/puma.state"
activate_control_app
daemonize true
