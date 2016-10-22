if Code.ensure_loaded?(Phoenix) do
  defmodule Repeatex.Controller do
    use Repeatex.Web, :controller

    def read(conn, %{"repeats" => text}) when is_binary(text) do
      json conn, %{repeats: Repeatex.parse(text)}
    end

    def format(conn, %{"repeats" => map}) when is_map(map) do
      json conn, %{description: Repeatex.parse_json(map) |> Repeatex.description}
    end
  end
end
