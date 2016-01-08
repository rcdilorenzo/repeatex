if Code.ensure_loaded?(Phoenix.Router) do
  defmodule Repeatex.Router do
    use Phoenix.Router

    pipeline :api do
      plug :accepts, ["json"]
    end

    scope "/", Repeatex do
      pipe_through :api

      get "/", Controller, :read
      put "/", Controller, :format
    end
  end
end
