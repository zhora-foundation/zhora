defmodule Zhora.ApiV1PingTest do
  use Zhora.ConnCase
  alias Zhora.DataFactory

  setup_all do
    DataFactory.create(:project)

    :ok
  end

  test "POST /v1/ping with compressed data", %{conn: conn} do
    json = %{version: "2.5.3",
             framework: "Sinatra 1.4.7",
             environment: nil,
             hostname: "zhora.hoster",
             config: %{api_key: "validkey"}}

    conn =
      conn
      |> put_req_header("x-api-key", "validkey")
      |> put_req_header("accept", "application/json")
      |> put_req_header("content-type", "application/json")
      |> put_req_header("content-encoding", "deflate")
      |> post("/v1/ping", deflate_json(json))

    assert json_response(conn, 200) ==
      %{"features" =>
        %{"notices" => true,
          "local_variables" => true,
          "metrics" => true,
          "traces" => true,
          "feedback" => true},
        "limit" => false}
  end

  test "POST /v1/ping with valid params", %{conn: conn} do
    conn =
      conn
      |> put_req_header("x-api-key", "validkey")
      |> put_req_header("accept", "application/json")
      |> put_req_header("content-type", "application/json")
      |> post("/v1/ping",
          %{version: "2.5.3",
            framework: "Sinatra 1.4.7",
            environment: nil,
            hostname: "zhora.hoster",
            config: %{api_key: "validkey"}})

    assert json_response(conn, 200) ==
      %{"features" =>
        %{"notices" => true,
          "local_variables" => true,
          "metrics" => true,
          "traces" => true,
          "feedback" => true},
        "limit" => false}
  end

  test "POST /v1/ping without params", %{conn: conn} do
    conn =
      conn
      |> put_req_header("x-api-key", "validkey")
      |> post("/v1/ping")

    assert json_response(conn, 200) ==
      %{"features" =>
        %{"notices" => true,
          "local_variables" => true,
          "metrics" => true,
          "traces" => true,
          "feedback" => true},
        "limit" => false}
  end

  test "POST /v1/ping with invalid api_key", %{conn: conn} do
    conn =
      conn
      |> put_req_header("x-api-key", "invalid-k3i")
      |> post("/v1/ping")

    assert json_response(conn, 200) ==
      %{"features" => %{},
        "error" => "Invalid API key",
        "limit" => 0}
  end

  test "POST /v1/ping without api_key", %{conn: conn} do
    conn = post(conn, "/v1/ping")

    assert json_response(conn, 200) ==
      %{"features" => %{},
        "error" => "Invalid API key",
        "limit" => 0}
  end
end
