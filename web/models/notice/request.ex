defmodule Zhora.Notice.Request do
  use Zhora.Web, :entity

  @primary_key false

  schema "embedded Model" do
    field :action, :string
    field :cgi_data, :map
    # field :component
    # field :context
    # field :params
    # field :session
    field :url, :string
  end

  @required_fields ~w(cgi_data url)
  @optional_fields ~w(action)

  def changeset(model, params \\ :empty) do
    cast(model, params, @required_fields, @optional_fields)
  end
end
