defmodule Pears.Images.Image do
  use Ecto.Schema
  import Ecto.Changeset

  schema "images" do
    field :binary_data, :binary
    field :binary_type, :string
    field :image_url, :string, virtual: true

    timestamps()
  end

  @doc false
  def changeset(image, attrs) do
    image
    |> cast(attrs, [:binary_data, :binary_type])
    |> validate_required([:binary_data, :binary_type])
  end

  @doc false
  def url_changeset(image, url) do
    image
    |> cast(%{image_url: url}, [:image_url])
    |> validate_required([:image_url])
  end
end
