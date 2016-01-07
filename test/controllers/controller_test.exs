defmodule Repeatex.ControllerTest do
  use TestApp.Case

  test "parsing" do
    response = conn(:get, "/repeatex", %{repeats: "every day"})
      |> send_request
      |> json_response

    assert response[:repeats] == %{type: "daily", days: [], frequency: 1}
  end

  test "formatting" do
    response = conn(:get, "/repeatex", %{repeats: %{}})
      |> send_request
      |> json_response

    assert response[:repeats] == nil
  end
end
