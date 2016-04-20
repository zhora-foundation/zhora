defmodule Zhora.ApiV1NoticesTest do
  use Zhora.ConnCase
  alias Zhora.{Notice, DataFactory}

  setup do
    project = DataFactory.create(:project)

    on_exit fn ->
      Repo.delete(project)
      Repo.delete_all(Notice)
    end

    {:ok, %{project: project}}
  end

  test "POST /v1/notices with valid notices", %{conn: conn, project: project} do
    json =
      %{"api_key" => "validkey",
        "error" => %{"backtrace" => [
          %{"file" => "app.rb",
             "method" => "block in <main>", "number" => "11"},
           %{"file" => "[GEM_ROOT]/gems/sinatra-1.4.7/lib/sinatra/base.rb",
             "method" => "call", "number" => "1611"},
           %{"file" => "[GEM_ROOT]/gems/sinatra-1.4.7/lib/sinatra/base.rb",
             "method" => "block in compile!", "number" => "1611"},
           %{"file" => "[GEM_ROOT]/gems/sinatra-1.4.7/lib/sinatra/base.rb",
             "method" => "block (3 levels) in route!", "number" => "975"},
           %{"file" => "[GEM_ROOT]/gems/sinatra-1.4.7/lib/sinatra/base.rb",
             "method" => "route_eval", "number" => "994"},
           %{"file" => "[GEM_ROOT]/gems/sinatra-1.4.7/lib/sinatra/base.rb",
             "method" => "block (2 levels) in route!", "number" => "975"},
           %{"file" => "[GEM_ROOT]/gems/sinatra-1.4.7/lib/sinatra/base.rb",
             "method" => "block in process_route", "number" => "1015"},
           %{"file" => "[GEM_ROOT]/gems/sinatra-1.4.7/lib/sinatra/base.rb",
             "method" => "catch", "number" => "1013"},
           %{"file" => "[GEM_ROOT]/gems/sinatra-1.4.7/lib/sinatra/base.rb",
             "method" => "process_route", "number" => "1013"},
           %{"file" => "[GEM_ROOT]/gems/sinatra-1.4.7/lib/sinatra/base.rb",
             "method" => "block in route!", "number" => "973"},
           %{"file" => "[GEM_ROOT]/gems/sinatra-1.4.7/lib/sinatra/base.rb",
             "method" => "each", "number" => "972"},
           %{"file" => "[GEM_ROOT]/gems/sinatra-1.4.7/lib/sinatra/base.rb",
             "method" => "route!", "number" => "972"},
           %{"file" => "[GEM_ROOT]/gems/sinatra-1.4.7/lib/sinatra/base.rb",
             "method" => "block in dispatch!", "number" => "1085"},
           %{"file" => "[GEM_ROOT]/gems/sinatra-1.4.7/lib/sinatra/base.rb",
             "method" => "block in invoke", "number" => "1067"},
           %{"file" => "[GEM_ROOT]/gems/sinatra-1.4.7/lib/sinatra/base.rb",
             "method" => "catch", "number" => "1067"},
           %{"file" => "[GEM_ROOT]/gems/sinatra-1.4.7/lib/sinatra/base.rb",
             "method" => "invoke", "number" => "1067"},
           %{"file" => "[GEM_ROOT]/gems/sinatra-1.4.7/lib/sinatra/base.rb",
             "method" => "dispatch!", "number" => "1082"},
           %{"file" => "[GEM_ROOT]/gems/sinatra-1.4.7/lib/sinatra/base.rb",
             "method" => "block in call!", "number" => "907"},
           %{"file" => "[GEM_ROOT]/gems/sinatra-1.4.7/lib/sinatra/base.rb",
             "method" => "block in invoke", "number" => "1067"},
           %{"file" => "[GEM_ROOT]/gems/sinatra-1.4.7/lib/sinatra/base.rb",
             "method" => "catch", "number" => "1067"},
           %{"file" => "[GEM_ROOT]/gems/sinatra-1.4.7/lib/sinatra/base.rb",
             "method" => "invoke", "number" => "1067"},
           %{"file" => "[GEM_ROOT]/gems/sinatra-1.4.7/lib/sinatra/base.rb",
             "method" => "call!", "number" => "907"},
           %{"file" => "[GEM_ROOT]/gems/sinatra-1.4.7/lib/sinatra/base.rb",
             "method" => "call", "number" => "895"},
           %{"file" => "[GEM_ROOT]/gems/rack-protection-1.5.3/lib/rack/protection/xss_header.rb",
             "method" => "call", "number" => "18"},
           %{"file" => "[GEM_ROOT]/gems/rack-protection-1.5.3/lib/rack/protection/path_traversal.rb",
             "method" => "call", "number" => "16"},
           %{"file" => "[GEM_ROOT]/gems/rack-protection-1.5.3/lib/rack/protection/json_csrf.rb",
             "method" => "call", "number" => "18"},
           %{"file" => "[GEM_ROOT]/gems/rack-protection-1.5.3/lib/rack/protection/base.rb",
             "method" => "call", "number" => "49"},
           %{"file" => "[GEM_ROOT]/gems/rack-protection-1.5.3/lib/rack/protection/base.rb",
             "method" => "call", "number" => "49"},
           %{"file" => "[GEM_ROOT]/gems/rack-protection-1.5.3/lib/rack/protection/frame_options.rb",
             "method" => "call", "number" => "31"},
           %{"file" => "[GEM_ROOT]/gems/rack-1.6.4/lib/rack/nulllogger.rb",
             "method" => "call", "number" => "9"},
           %{"file" => "[GEM_ROOT]/gems/rack-1.6.4/lib/rack/head.rb",
             "method" => "call", "number" => "13"},
           %{"file" => "[GEM_ROOT]/gems/rack-1.6.4/lib/rack/methodoverride.rb",
             "method" => "call", "number" => "22"},
           %{"file" => "[GEM_ROOT]/gems/sinatra-1.4.7/lib/sinatra/base.rb",
             "method" => "call", "number" => "182"},
           %{"file" => "[GEM_ROOT]/gems/sinatra-1.4.7/lib/sinatra/base.rb",
             "method" => "call", "number" => "2013"},
           %{"file" => "[GEM_ROOT]/gems/sinatra-1.4.7/lib/sinatra/base.rb",
             "method" => "block in call", "number" => "1487"},
           %{"file" => "[GEM_ROOT]/gems/sinatra-1.4.7/lib/sinatra/base.rb",
             "method" => "synchronize", "number" => "1787"},
           %{"file" => "[GEM_ROOT]/gems/sinatra-1.4.7/lib/sinatra/base.rb",
             "method" => "call", "number" => "1487"},
           %{"file" => "[GEM_ROOT]/gems/puma-3.2.0/lib/puma/configuration.rb",
             "method" => "call", "number" => "227"},
           %{"file" => "[GEM_ROOT]/gems/puma-3.2.0/lib/puma/server.rb",
             "method" => "handle_request", "number" => "561"},
           %{"file" => "[GEM_ROOT]/gems/puma-3.2.0/lib/puma/server.rb",
             "method" => "process_client", "number" => "406"},
           %{"file" => "[GEM_ROOT]/gems/puma-3.2.0/lib/puma/server.rb",
             "method" => "block in run", "number" => "271"},
           %{"file" => "[GEM_ROOT]/gems/puma-3.2.0/lib/puma/thread_pool.rb",
             "method" => "block in spawn_thread", "number" => "111"}],
          "causes" => [],
          "class" => "RuntimeError",
          "fingerprint" => nil,
          "message" => "RuntimeError: Sinatra has left the building",
          "source" => %{
            "10" => "get '/error' do\n",
            "11" => "  raise \"Sinatra has left the building\"\n",
            "12" => "end\n",
            "9" => "\n"},
          "tags" => [],
          "token" => "0b9e7584-b801-432d-9b0b-0acb8681adda"},
        "notifier" => %{
          "language" => "ruby",
          "name" => "honeybadger-ruby",
          "url" => "https://github.com/honeybadger-io/honeybadger-ruby",
          "version" => "2.5.3"},
        "request" => %{
          "action" => nil,
          "cgi_data" => %{
            "GATEWAY_INTERFACE" => "CGI/1.2",
            "HTTP_ACCEPT" => "text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8",
            "HTTP_ACCEPT_ENCODING" => "gzip, deflate, sdch",
            "HTTP_ACCEPT_LANGUAGE" => "ru-RU,ru;q=0.8,en-US;q=0.6,en;q=0.4,zh-CN;q=0.2,zh;q=0.2,fr;q=0.2",
            "HTTP_CACHE_CONTROL" => "max-age=0",
            "HTTP_CONNECTION" => "keep-alive",
            "HTTP_COOKIE" => "_ym_uid=1457778892477015491; _ga=GA1.1.89976845.1457778892",
            "HTTP_HOST" => "localhost:4567",
            "HTTP_UPGRADE_INSECURE_REQUESTS" => "1",
            "HTTP_USER_AGENT" => "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_11_4) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/49.0.2623.87 Safari/537.36",
            "HTTP_VERSION" => "HTTP/1.1",
            "PATH_INFO" => "/error",
            "REMOTE_ADDR" => "127.0.0.1",
            "REQUEST_METHOD" => "GET",
            "REQUEST_PATH" => "/error",
            "REQUEST_URI" => "/error",
            "SCRIPT_NAME" => "",
            "SERVER_NAME" => "localhost",
            "SERVER_PORT" => "4567",
            "SERVER_PROTOCOL" => "HTTP/1.1",
            "SERVER_SOFTWARE" => "puma 3.2.0 Spring Is A Heliocentric Viewpoint"},
          "component" => nil,
          "context" => nil,
          "params" => %{},
          "session" => %{},
          "url" => "http://localhost:4567/error"},
        "server" => %{
          "environment_name" => "production",
          "hostname" => "zhora.hoster",
          "pid" => 50787,
          "project_root" => "/Users/zhora/zhora-test",
          "stats" => %{"load" => %{}, "mem" => %{}},
          "time" => "2016-03-28 05:45:18 UTC"}}

    conn =
      conn
      |> put_req_header("x-api-key", "validkey")
      |> put_req_header("accept", "application/json")
      |> put_req_header("content-type", "application/json")
      |> put_req_header("content-encoding", "deflate")
      |> post("/v1/notices", deflate_json(json))

    notices = Repo.all(assoc(project, :notices))
    notice = List.first(notices)

    assert json_response(conn, 200) == %{"id" => notice.id}
    assert List.first(get_resp_header(conn, "x-uuid")) == notice.id

    assert length(notices) == 1
    assert notice.error.class == "RuntimeError"
    assert notice.notifier.language == "ruby"
    assert notice.request.url == "http://localhost:4567/error"
    assert notice.server.environment_name == "production"
  end

  test "POST /v1/notices with invalid notices", %{conn: conn, project: project} do
    json =
      %{"api_key" => "validkey",
        "error" => %{},
        "notifier" => %{},
        "request" => %{},
        "server" => %{}}

    conn =
      conn
      |> put_req_header("x-api-key", "validkey")
      |> put_req_header("accept", "application/json")
      |> put_req_header("content-type", "application/json")
      |> put_req_header("content-encoding", "deflate")
      |> post("/v1/notices", deflate_json(json))

    assert json_response(conn, 400) == %{"error" => "malformed value"}
    assert length(Repo.all(assoc(project, :notices))) == 0
  end

  test "POST /v1/notices without payload", %{conn: conn, project: project} do
    conn =
      conn
      |> put_req_header("x-api-key", "validkey")
      |> put_req_header("accept", "application/json")
      |> put_req_header("content-type", "application/json")
      |> put_req_header("content-encoding", "deflate")
      |> post("/v1/notices", deflate_json(%{}))

    assert json_response(conn, 400) == %{"error" => "malformed value"}
    assert length(Repo.all(assoc(project, :notices))) == 0
  end
end
