set :stage, :production
set :branch, :master

set :server_port, 80
set :server_port_ssl, 443

set :full_app_name, "#{fetch(:application)}_#{fetch(:stage)}"

# Don't forget to put your server ip
server '3.225.135.0', user: fetch(:deploy_user).to_s, roles: %w(app db), primary: true
# server '3.225.135.0', user: fetch(:deploy_user).to_s, roles: %w(app), primary: true
# server '3.225.135.0', user: fetch(:deploy_user).to_s, roles: %w(app), primary: true

set :server_names, {
    '3.225.135.0': '3.225.135.0 node0.server',
    '3.225.135.0': '3.225.135.0 node1.server',
    '3.225.135.0': '3.225.135.0 node2.server',
}

set :deploy_to, "#{fetch(:deploy_path)}/#{fetch(:full_app_name)}"

set :rails_env, :production

set :puma_user, fetch(:deploy_user)
set :puma_rackup, -> { File.join(current_path, 'config.ru') }
set :puma_state, "#{shared_path}/tmp/states/puma.state"
set :puma_pid, "#{shared_path}/tmp/pids/puma.pid"
set :puma_bind, "unix://#{shared_path}/tmp/sockets/puma.#{fetch(:full_app_name)}.sock"
set :puma_default_control_app, "unix://#{shared_path}/tmp/sockets/pumactl.#{fetch(:full_app_name)}.sock"
set :puma_conf, "#{shared_path}/config/puma.rb"
set :puma_access_log, "#{shared_path}/log/puma_access.log"
set :puma_error_log, "#{shared_path}/log/puma_error.log"
set :puma_role, :app
set :puma_env, :production
set :puma_threads, [1, 4]
set :puma_workers, 8
set :puma_worker_timeout, nil
set :puma_init_active_record, false
set :puma_preload_app, true
set :puma_plugins, [:tmp_restart]
set :nginx_disable_http, false
set :nginx_http_limit_url, %w()
set :allow_asset, true
set :nginx_use_ssl, true
set :nginx_https_limit_url, %w()
set :nginx_certificate_path, "#{shared_path}/certificates/#{fetch(:stage)}.crt"
set :nginx_key_path, "#{shared_path}/certificates/#{fetch(:stage)}.key"
