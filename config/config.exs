# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

import_config "#{Mix.env}.exs"
