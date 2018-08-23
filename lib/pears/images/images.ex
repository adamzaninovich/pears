defmodule Pears.Images do
  @moduledoc """
  The Images context.
  """

  import Ecto.Query, warn: false
  alias Pears.Repo

  alias Pears.Images.Image

  @doc """
  Gets image data from a URL and saves it in an Image record

  ## Examples

      iex> fetch_image("http://i.imgur.com/TEyfeTt.gif")
      {:ok, %Image{binary_data: image_data, binary_type: "image/gif"}}

  """
  def create_image_from_url(image_url) do
    with %Ecto.Changeset{valid?: true} <- Image.url_changeset(%Image{}, image_url),
         {:ok, %HTTPoison.Response{body: data, headers: headers}} <-
           HTTPoison.get(image_url, follow_redirect: true),
         {:ok, image} <- create_image(data, get_content_type(headers)) do
      {:ok, image}
    else
      %Ecto.Changeset{valid?: false} = changeset ->
        {:error, changeset}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:error, changeset}

      {:error, _response} ->
        changeset =
          %Image{}
          |> Image.url_changeset(image_url)
          |> Ecto.Changeset.add_error(:image_url, "Unable to fetch image")

        {:error, changeset}
    end
  end

  defp get_content_type(headers) do
    Map.new(headers)["Content-Type"]
  end

  @doc """
  Returns the list of images.

  ## Examples

      iex> list_images()
      [%Image{}, ...]

  """
  def list_images do
    Repo.all(Image)
  end

  @doc """
  Gets a single image.

  Raises `Ecto.NoResultsError` if the Image does not exist.

  ## Examples

      iex> get_image!(123)
      %Image{}

      iex> get_image!(456)
      ** (Ecto.NoResultsError)

  """
  def get_image!(id), do: Repo.get!(Image, id)

  def get_random_image do
    Repo.one(from(i in Image, order_by: fragment("random()"), limit: 1))
  end

  @doc """
  Creates a image.

  ## Examples

      iex> create_image(data, type)
      {:ok, %Image{}}

      iex> create_image(%{field: value})
      {:ok, %Image{}}

      iex> create_image(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_image(data, "image/" <> _ = type) do
    create_image(%{binary_data: data, binary_type: type})
  end

  def create_image(_data, non_image_type) do
    {:error, "not an image: #{non_image_type}"}
  end

  def create_image(attrs \\ %{}) do
    %Image{}
    |> Image.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a image.

  ## Examples

      iex> update_image(image, %{field: new_value})
      {:ok, %Image{}}

      iex> update_image(image, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_image(%Image{} = image, attrs) do
    image
    |> Image.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Image.

  ## Examples

      iex> delete_image(image)
      {:ok, %Image{}}

      iex> delete_image(image)
      {:error, %Ecto.Changeset{}}

  """
  def delete_image(%Image{} = image) do
    Repo.delete(image)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking image changes.

  ## Examples

      iex> change_image(image)
      %Ecto.Changeset{source: %Image{}}

  """
  def change_image(%Image{} = image) do
    Image.changeset(image, %{})
  end
end
