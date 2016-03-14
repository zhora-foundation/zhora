defmodule Zhora.PageController do
  use Zhora.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
