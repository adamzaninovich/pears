defmodule Pears.ImageFetcher do
  use GenServer

  alias Pears.Repo
  alias Pears.Image

  # Client API

  def start_link(opts \\ []) do
    GenServer.start_link(__MODULE__, [], opts ++ [name: __MODULE__])
  end

  def get_image(image) do
    GenServer.cast(__MODULE__, {image})
  end

  # Server implementation

  def init(_), do: {:ok, []}

  def handle_cast({image}, _state) do
    %HTTPoison.Response{body: image, headers: headers} = HTTPoison.get!(image.image_url)
    Image.changeset(
      image,
      %{"image_binary" => image, "image_binary_type" => get_content_type(headers)}
    )
    |> Repo.update!
    {:noreply, []}
  end

  defp get_content_type(headers) do
    header_map = headers |> Map.new
    header_map["Content-Type"]
  end
end
