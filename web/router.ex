defmodule Zhora.Router do
  use Zhora.Web, :router

  pipeline :agent_api do
    plug :accepts, ["json"]
  end

  pipeline :agent_api_secured do
    plug Zhora.AuthKeyPlug
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/v0", Zhora.V0 do
    pipe_through :api

    resources "/metrics", MetricsController, only: [:index]
  end

  scope "/v1", Zhora.V1 do
    pipe_through :agent_api

    post "/ping", PingController, :create

    scope "/" do
      pipe_through :agent_api_secured

      post "/notices", NoticesController, :create
      post "/deploys", DeploysController, :create
      post "/metrics", MetricsController, :create
    end
  end
end
