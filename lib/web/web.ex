defmodule Repeatex.Web do
  def controller do
    quote do
      use Phoenix.Controller
    end
  end

  defmacro __using__(which) when is_atom(which) do
    apply(__MODULE__, which, [])
  end

  use Plug.Builder

  plug Repeatex.Router
end
