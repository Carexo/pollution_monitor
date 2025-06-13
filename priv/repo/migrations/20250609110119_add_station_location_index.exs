defmodule Pollutiondb.Repo.Migrations.AddStationLocationIndex do
  use Ecto.Migration

  def change do
    create unique_index(:stations, [:name], name: :unique_station_name_index)
    create unique_index(:stations, [:lon, :lat], name: :unique_station_location_index)
  end
end
