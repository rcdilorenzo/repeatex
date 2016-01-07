defmodule TestApp.Case do
  use ExUnit.CaseTemplate

  using do
    quote do
      use Plug.Test

      def send_request(conn) do
        conn
        |> put_private(:plug_skip_csrf_protection, true)
        |> TestApp.call([])
      end

      def json_response(conn) do
        Poison.decode!(conn.resp_body, keys: :atoms!)
      end
    end
  end
end

defmodule TestApp.ErrorView do

  def render("404.html", _assigns) do
    "Page not found"
  end

  def render("500.html", _assigns) do
    "Server internal error"
  end

  # In case no render clause matches or no
  # template is found, let's render it as 500
  def template_not_found(_template, assigns) do
    render "500.html", assigns
  end
end
