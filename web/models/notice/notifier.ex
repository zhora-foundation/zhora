defmodule Zhora.Notice.Notifier do
  use Zhora.Web, :entity

  @primary_key false

  schema "embedded Model" do
    field :language, :string
    field :name, :string
    field :url, :string
    field :version, :string
  end

  @required_fields ~w(language name url version)
  @optional_fields ~w()

  def changeset(model, params \\ :empty) do
    cast(model, params, @required_fields, @optional_fields)
  end
end
