import Config

config :ex_xendit,
  base_url: "https://api.xendit.co"

import_config "#{config_env()}.exs"
