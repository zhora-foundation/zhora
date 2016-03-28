defmodule Zhora.V0.MetricsView do
  use Zhora.Web, :view

  def render("index.json", %{metrics: metrics}) do
    %{metrics: metrics}
  end

  def render("index.json", %{error: reason}) do
    error_json(reason)
  end

  def render("show.json", _params) do
    %{}
  end
end
