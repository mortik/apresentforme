defmodule App.WishlistController do
  use App.Web, :controller

  alias App.Wishlist

  plug :scrub_params, "wishlist" when action in [:create, :update]

  def index(conn, _params) do
    wishlists = Repo.all(Wishlist)
    render(conn, "index.html", wishlists: wishlists)
  end

  def new(conn, _params) do
    changeset = Wishlist.changeset(%Wishlist{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"wishlist" => wishlist_params}) do
    changeset = Wishlist.changeset(%Wishlist{}, wishlist_params)

    case Repo.insert(changeset) do
      {:ok, _wishlist} ->
        conn
        |> put_flash(:info, "Wishlist created successfully.")
        |> redirect(to: wishlist_path(conn, :index))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    wishlist = Repo.get!(Wishlist, id)
    render(conn, "show.html", wishlist: wishlist)
  end

  def edit(conn, %{"id" => id}) do
    wishlist = Repo.get!(Wishlist, id)
    changeset = Wishlist.changeset(wishlist)
    render(conn, "edit.html", wishlist: wishlist, changeset: changeset)
  end

  def update(conn, %{"id" => id, "wishlist" => wishlist_params}) do
    wishlist = Repo.get!(Wishlist, id)
    changeset = Wishlist.changeset(wishlist, wishlist_params)

    case Repo.update(changeset) do
      {:ok, wishlist} ->
        conn
        |> put_flash(:info, "Wishlist updated successfully.")
        |> redirect(to: wishlist_path(conn, :show, wishlist))
      {:error, changeset} ->
        render(conn, "edit.html", wishlist: wishlist, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    wishlist = Repo.get!(Wishlist, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(wishlist)

    conn
    |> put_flash(:info, "Wishlist deleted successfully.")
    |> redirect(to: wishlist_path(conn, :index))
  end
end
