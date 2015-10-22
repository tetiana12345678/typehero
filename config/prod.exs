use Mix.Config

config :typehero, Typehero.Endpoint,
  http: [port: System.get_env("PORT")],
  url: [scheme: "https", host: "typehero.herokuapp.com", port: 443],
  force_ssl: [rewrite_on: [:x_forwarded_proto]],
  cache_static_manifest: "priv/static/manifest.json",
  secret_key_base: System.get_env("SECRET_KEY_BASE")

# Do not print debug messages in production
config :logger, level: :info

#Configure your database
config :typehero, Typehero.Repo,
  adapter: Ecto.Adapters.Postgres,
  url: System.get_env("DATABASE_URL"),
  size: 20

# For production, we configure the host to read the PORT
# from the system environment. Therefore, you will need
# to set PORT=80 before running your server.
#
# ## SSL Support
#
# To get SSL working, you will need to add the `https` key
# to the previous section, and set your `:url` port to 443
#
#  config :typehero, Typehero.Endpoint,
#    ...
#    url: [host: "example.com", port: 443],
#    https: [port: 443,
#            keyfile: System.get_env("SOME_APP_SSL_KEY_PATH"),
#            certfile: System.get_env("SOME_APP_SSL_CERT_PATH")]
#
# Where those two env variables point to a file on
# disk for the key and cert.

# ## Using releases
#
# If you are doing OTP releases, you need to instruct Phoenix
# to start the server for all endpoints:
#
#     config :phoenix, :serve_endpoints, true
#
# Alternatively, you can configure exactly which server to
# start per endpoint:
#
#     config :typehero, Typehero.Endpoint, server: true
#

# Finally import the config/prod.secret.exs
# which should be versioned separately. Not needed for heroku, as it's uses ENV variables
# import_config "prod.secret.exs"
