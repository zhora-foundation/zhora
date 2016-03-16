defmodule Zhora.V1.PingView do
  use Zhora.Web, :view

  @features %{"feedback" => true, "local_variables" => true,
              "metrics" => true, "notices" => true, "traces" => true}

  def render("error.json", _params) do
    %{error: "Invalid API key", features: %{}, limit: 0}
  end

  def render("success.json", _params) do
    %{features: @features, limit: false}
  end
end
