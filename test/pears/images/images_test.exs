defmodule Pears.ImagesTest do
  use Pears.DataCase

  alias Pears.Images

  describe "images" do
    alias Pears.Images.Image

    @valid_attrs %{binary_data: "some binary_data", binary_type: "some binary_type"}
    @update_attrs %{binary_data: "some updated binary_data", binary_type: "some updated binary_type"}
    @invalid_attrs %{binary_data: nil, binary_type: nil}

    def image_fixture(attrs \\ %{}) do
      {:ok, image} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Images.create_image()

      image
    end

    test "list_images/0 returns all images" do
      image = image_fixture()
      assert Images.list_images() == [image]
    end

    test "get_image!/1 returns the image with given id" do
      image = image_fixture()
      assert Images.get_image!(image.id) == image
    end

    test "create_image/1 with valid data creates a image" do
      assert {:ok, %Image{} = image} = Images.create_image(@valid_attrs)
      assert image.binary_data == "some binary_data"
      assert image.binary_type == "some binary_type"
    end

    test "create_image/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Images.create_image(@invalid_attrs)
    end

    test "update_image/2 with valid data updates the image" do
      image = image_fixture()
      assert {:ok, image} = Images.update_image(image, @update_attrs)
      assert %Image{} = image
      assert image.binary_data == "some updated binary_data"
      assert image.binary_type == "some updated binary_type"
    end

    test "update_image/2 with invalid data returns error changeset" do
      image = image_fixture()
      assert {:error, %Ecto.Changeset{}} = Images.update_image(image, @invalid_attrs)
      assert image == Images.get_image!(image.id)
    end

    test "delete_image/1 deletes the image" do
      image = image_fixture()
      assert {:ok, %Image{}} = Images.delete_image(image)
      assert_raise Ecto.NoResultsError, fn -> Images.get_image!(image.id) end
    end

    test "change_image/1 returns a image changeset" do
      image = image_fixture()
      assert %Ecto.Changeset{} = Images.change_image(image)
    end
  end
end
