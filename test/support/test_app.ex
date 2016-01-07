defmodule TestApp.Router do
  use Phoenix.Router

  forward "/repeatex", Repeatex.Web
end

defmodule TestApp do
  use Phoenix.Endpoint, otp_app: :test_app
  plug TestApp.Router
end
