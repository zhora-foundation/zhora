defmodule Zhora.Notice do
  use Zhora.Web, :model

  alias Zhora.{Project}
  alias Zhora.Notice.{Error, Notifier, Request, Server}

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id

  schema "notices" do
    belongs_to :project, Project

    embeds_one :error, Error
    embeds_one :notifier, Notifier
    embeds_one :request, Request
    embeds_one :server, Server

    timestamps updated_at: false
  end

  @required_fields ~w(project_id)
  @optional_fields ~w()

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
    |> cast_embed(:error)
    |> cast_embed(:notifier)
    |> cast_embed(:request)
    |> cast_embed(:server)
    |> assoc_constraint(:project)
  end
end
