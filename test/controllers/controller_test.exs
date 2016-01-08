defmodule Repeatex.ControllerTest do
  use TestApp.Case

  test "parsing" do
    response = conn(:get, "/repeatex", %{repeats: "every day"})
      |> send_request
      |> json_response

    assert response[:repeats] == %{type: "daily", days: [], frequency: 1}
  end

  test "formatting" do
    response = conn(:put, "/repeatex", %{"repeats" => %{
      "type" => "monthly",
      "days" => [15, 25],
      "frequency" => 1
    }}) |> send_request |> json_response

    assert response == %{
      description: "15th and 25th every month"
    }
  end
end
