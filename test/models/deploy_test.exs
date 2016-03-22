defmodule Zhora.DeployTest do
  use Zhora.ModelCase

  alias Zhora.Deploy

  @valid_attrs %{project_id: "some content", environment: "some content", local_username: "some content", repository: "some content", revision: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Deploy.changeset(%Deploy{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Deploy.changeset(%Deploy{}, @invalid_attrs)
    refute changeset.valid?
  end
end
