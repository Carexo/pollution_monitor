import Ecto.Query

defmodule Pollutiondb.Reading do
  use Ecto.Schema


  schema "reading" do
      field :date, :date
      field :time, :time
      field :type, :string
      field :value, :float
      belongs_to :station, Pollutiondb.Station
  end


  def add_now(station, type, value) do
    %Pollutiondb.Reading{
      date: Date.utc_today,
      time: Time.truncate(Time.utc_now, :second),
      station: station,
      value: value,
      type: type}
      |> Pollutiondb.Repo.insert()
  end

  def find_by_date(date) do
    query = from(r in Pollutiondb.Reading,
        where: r.date == ^date, preload: [:station])

    Pollutiondb.Repo.all(query)
  end

  def add(station, date, time, type, value) do
    %Pollutiondb.Reading{
      date: date,
      time: time,
      station: station,
      value: value,
      type: type
    }
    |> Pollutiondb.Repo.insert()
  end
end
