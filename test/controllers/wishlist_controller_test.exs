defmodule App.WishlistControllerTest do
  use App.ConnCase

  alias App.Wishlist
  @valid_attrs %{name: "some content"}
  @invalid_attrs %{}

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, wishlist_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing wishlists"
  end

  test "renders form for new resources", %{conn: conn} do
    conn = get conn, wishlist_path(conn, :new)
    assert html_response(conn, 200) =~ "New wishlist"
  end

  test "creates resource and redirects when data is valid", %{conn: conn} do
    conn = post conn, wishlist_path(conn, :create), wishlist: @valid_attrs
    assert redirected_to(conn) == wishlist_path(conn, :index)
    assert Repo.get_by(Wishlist, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, wishlist_path(conn, :create), wishlist: @invalid_attrs
    assert html_response(conn, 200) =~ "New wishlist"
  end

  test "shows chosen resource", %{conn: conn} do
    wishlist = Repo.insert! %Wishlist{}
    conn = get conn, wishlist_path(conn, :show, wishlist)
    assert html_response(conn, 200) =~ "Show wishlist"
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, wishlist_path(conn, :show, -1)
    end
  end

  test "renders form for editing chosen resource", %{conn: conn} do
    wishlist = Repo.insert! %Wishlist{}
    conn = get conn, wishlist_path(conn, :edit, wishlist)
    assert html_response(conn, 200) =~ "Edit wishlist"
  end

  test "updates chosen resource and redirects when data is valid", %{conn: conn} do
    wishlist = Repo.insert! %Wishlist{}
    conn = put conn, wishlist_path(conn, :update, wishlist), wishlist: @valid_attrs
    assert redirected_to(conn) == wishlist_path(conn, :show, wishlist)
    assert Repo.get_by(Wishlist, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    wishlist = Repo.insert! %Wishlist{}
    conn = put conn, wishlist_path(conn, :update, wishlist), wishlist: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit wishlist"
  end

  test "deletes chosen resource", %{conn: conn} do
    wishlist = Repo.insert! %Wishlist{}
    conn = delete conn, wishlist_path(conn, :delete, wishlist)
    assert redirected_to(conn) == wishlist_path(conn, :index)
    refute Repo.get(Wishlist, wishlist.id)
  end
end
