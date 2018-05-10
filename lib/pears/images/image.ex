defmodule Pears.Images.Image do
  use Ecto.Schema
  import Ecto.Changeset


  schema "images" do
    field :binary_data, :binary
    field :binary_type, :string

    timestamps()
  end

  @doc false
  def changeset(image, attrs) do
    image
    |> cast(attrs, [:binary_data, :binary_type])
    |> validate_required([:binary_data, :binary_type])
  end
end
