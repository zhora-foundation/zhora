defmodule Zhora.ApiV1DeploysTest do
  use Zhora.ConnCase
  alias Zhora.{Project, Deploy}

  setup do
    project = Repo.insert!(%Project{name: "test", api_key: "validkey"})

    on_exit fn ->
      Repo.delete(project)
      Repo.delete_all(Deploy)
    end

    {:ok, %{project: project}}
  end

  test "POST /v1/deploys with compressed data", %{conn: conn, project: project} do
    json = %{environment: "production",
             revision: "1",
             repository: "http://zhora.io",
             local_username: "zhora"}

    conn =
      conn
      |> put_req_header("x-api-key", "validkey")
      |> put_req_header("accept", "application/json")
      |> put_req_header("content-type", "application/json")
      |> put_req_header("content-encoding", "deflate")
      |> post("/v1/deploys", deflate_json(json))

    assert json_response(conn, 201) == %{"status" => "OK"}

    deploys = Repo.all(assoc(project, :deploys))
    deploy = List.first(deploys)

    assert length(deploys) == 1
    assert deploy.environment == "production"
    assert deploy.revision == "1"
    assert deploy.repository == "http://zhora.io"
    assert deploy.local_username == "zhora"
  end

  test "POST /v1/deploys with valid params", %{conn: conn, project: project} do
    conn =
      conn
      |> put_req_header("x-api-key", "validkey")
      |> put_req_header("accept", "application/json")
      |> put_req_header("content-type", "application/json")
      |> post("/v1/deploys",
          %{environment: "production",
            revision: "1",
            repository: "http://zhora.io",
            local_username: "zhora"})

    assert json_response(conn, 201) == %{"status" => "OK"}
    assert length(Repo.all(assoc(project, :deploys))) == 1
  end

  test "POST /v1/deploys without params", %{conn: conn, project: project} do
    conn =
      conn
      |> put_req_header("x-api-key", "validkey")
      |> post("/v1/deploys")

    assert json_response(conn, 201) == %{"status" => "OK"}
    assert length(Repo.all(assoc(project, :deploys))) == 0
  end

  test "POST /v1/deploys with invalid api_key", %{conn: conn, project: project} do
    conn =
      conn
      |> put_req_header("x-api-key", "invalid-k3i")
      |> post("/v1/deploys")

    assert json_response(conn, 403) == %{"error" => "Invalid API key"}
    assert length(Repo.all(assoc(project, :deploys))) == 0
  end

  test "POST /v1/deploys without api_key", %{conn: conn, project: project} do
    conn = post(conn, "/v1/deploys")

    assert json_response(conn, 403) == %{"error" => "Invalid API key"}
    assert length(Repo.all(assoc(project, :deploys))) == 0
  end
end
