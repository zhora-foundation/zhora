defmodule Zhora.Notice.Error do
  use Zhora.Web, :entity

  alias Zhora.Notice.Backtrace

  embedded_schema do
    embeds_many :backtrace, Backtrace

    # field :causes
    field :class, :string
    # field :fingerprint
    field :message, :string
    field :source, :map
    # field :tags
    field :token, :string
  end

  @required_fields ~w(class message source token)
  @optional_fields ~w()

  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
    |> cast_embed(:backtrace)
  end
end
