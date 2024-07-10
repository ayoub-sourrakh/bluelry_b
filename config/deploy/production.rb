server '15.237.196.239', user: 'ubuntu', roles: %w{app}
set :rails_env, 'production'
set :ssh_options, {
  keys: %w(/home/asourrakh/bly_key.pem),
  forward_agent: false,
  auth_methods: %w(publickey password)
}