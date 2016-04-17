defmodule App.Repo.Migrations.CreateWishlist do
  use Ecto.Migration

  def change do
    create table(:wishlists, primary_key: false) do
      add :id, :uuid, primary_key: true
      add :name, :string

      timestamps
    end

  end
end
