defmodule Zhora.ConnCase do
  @moduledoc """
  This module defines the test case to be used by
  tests that require setting up a connection.

  Such tests rely on `Phoenix.ConnTest` and also
  imports other functionality to make it easier
  to build and query models.

  Finally, if the test case interacts with the database,
  it cannot be async. For this reason, every test runs
  inside a transaction which is reset at the beginning
  of the test unless the test case is marked as async.
  """

  use ExUnit.CaseTemplate

  using do
    quote do
      # Import conveniences for testing with connections
      use Phoenix.ConnTest

      alias Zhora.Repo
      import Ecto
      import Ecto.Changeset
      import Ecto.Query, only: [from: 1, from: 2]

      import Zhora.Router.Helpers

      import Zhora.ConnCase, only: [deflate_json: 1]

      # The default endpoint for testing
      @endpoint Zhora.Endpoint
    end
  end

  alias Zhora.{Project, Deploy, TestHelpers}

  setup_all _opts do
    TestHelpers.clean_repos([Project, Deploy])
  end

  setup _opts do
    {:ok, conn: Phoenix.ConnTest.conn}
  end

  def deflate_json(object) do
    object
    |> Poison.encode!
    |> deflate
    |> :erlang.list_to_binary
  end

  defp deflate(content) do
    zlib = :zlib.open
    :zlib.deflateInit(zlib)
    data = :zlib.deflate(zlib, content, :finish)
    :zlib.deflateEnd(zlib)
    data
  end
end
