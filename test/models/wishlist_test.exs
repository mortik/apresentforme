defmodule App.WishlistTest do
  use App.ModelCase

  alias App.Wishlist

  @valid_attrs %{name: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Wishlist.changeset(%Wishlist{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Wishlist.changeset(%Wishlist{}, @invalid_attrs)
    refute changeset.valid?
  end
end
