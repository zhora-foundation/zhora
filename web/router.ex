defmodule Zhora.Router do
  use Zhora.Web, :router

  pipeline :agent_api do
    plug :accepts, ["json"]
  end

  pipeline :agent_api_secured do
    plug Zhora.AuthKeyPlug
  end

  scope "/v1", Zhora.V1 do
    pipe_through :agent_api

    post "/ping", PingController, :create

    scope "/" do
      pipe_through :agent_api_secured

      post "/notices", NoticesController, :create
    end
  end
end
