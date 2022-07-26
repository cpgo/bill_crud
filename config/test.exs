import Config

# Configure your database
#
# The MIX_TEST_PARTITION environment variable can be used
# to provide built-in test partitioning in CI environment.
# Run `mix help test` for more information.
config :bill_crud, BillCrud.Repo,
  username: System.get_env("PGUSER") || "postgres",
  password: System.get_env("postgres") || "postgres",
  hostname: System.get_env("PGHOST") || "localhost",
  database: System.get_env("TEST_PGDATABASE") || "bill_crud_test",
  pool: Ecto.Adapters.SQL.Sandbox,
  pool_size: 10

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :bill_crud, BillCrudWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "SiuXzFiXAfBYo08SoD9D/9IwD/NLVQuSVbMh8G0402J8QrltUpqHXQCCwRMCSNme",
  server: false

# In test we don't send emails.
config :bill_crud, BillCrud.Mailer, adapter: Swoosh.Adapters.Test

# Print only warnings and errors during test
config :logger, level: :warn

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime
