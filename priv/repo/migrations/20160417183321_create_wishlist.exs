defmodule App.Repo.Migrations.CreateWishlist do
  use Ecto.Migration

  def change do
    create table(:wishlists) do
      add :name, :string

      timestamps
    end

  end
end
