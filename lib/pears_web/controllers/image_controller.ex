defmodule PearsWeb.ImageController do
  use PearsWeb, :controller

  alias Pears.Images
  alias Pears.Images.Image

  def index(conn, _params) do
    images = Images.list_images()
    render(conn, "index.html", images: images)
  end

  def new(conn, _params) do
    changeset = Images.change_image(%Image{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"image" => %{"image_url" => url}}) do
    case Images.create_image_from_url(url) do
      {:ok, _image} ->
        conn
        |> put_flash(:info, "Image created successfully.")
        |> redirect(to: image_path(conn, :index))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    image = Images.get_image!(id)
    {:ok, _image} = Images.delete_image(image)

    conn
    |> put_flash(:info, "Image deleted successfully.")
    |> redirect(to: image_path(conn, :index))
  end

  def show(conn, %{"id" => id}) do
    id
    |> Images.get_image!()
    |> send_image(conn)
  end

  def show_random(conn, _params) do
    Images.get_random_image()
    |> send_image(conn)
  end

  defp send_image(image, conn) do
    conn
    |> put_resp_content_type(image.binary_type, "utf-8")
    |> send_resp(200, image.binary_data)
  end
end
