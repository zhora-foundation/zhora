defmodule Zhora.Deploy do
  use Zhora.Web, :model

  alias Zhora.Project

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id

  schema "deploys" do
    belongs_to :project, Project

    field :environment, :string
    field :revision, :string
    field :repository, :string
    field :local_username, :string

    timestamps
  end

  @required_fields ~w(project_id environment revision repository local_username)
  @optional_fields ~w()

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
    |> assoc_constraint(:project)
  end
end
