defmodule PearsWeb.ImageView do
  use PearsWeb, :view

  def display_image(conn, image, attrs \\ []) do
    image_src = image_path(conn, :show, image)
    attrs = attrs ++ [src: image_src, alt: "pear-#{image.id}"]
    tag(:img, attrs)
  end

  def display_linked_image(conn, image) do
    image_src = image_path(conn, :show, image)
    image_tag = tag(:img, src: image_src, alt: "pear-#{image.id}")
    link(image_tag, to: image_src)
  end
end
