defmodule Pollutiondb.Repo.Migrations.CreateReading do
  use Ecto.Migration

  def change do
    create table(:reading) do
      add :date, :date
      add :time, :time
      add :type, :string
      add :value, :float
      add :station_id, references(:stations, on_delete: :delete_all)
    end
  end
end
