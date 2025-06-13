defmodule PollutiondbWeb.StationLive do
  use PollutiondbWeb, :live_view

  alias Pollutiondb.Station

  def mount(_params, _session, socket) do
    socket = assign(socket, stations: Station.get_all(), name: "", lat: "", lon: "")
    {:ok, socket}
  end

  def to_float(number, default) do
    case Float.parse(number) do
      {float, _} -> float
      :error -> default
    end
  end

  def handle_event("insert", %{"name" => name, "lat" => lat, "lon" => lon}, socket) do
    Station.add(name, to_float(lon, 0.0), to_float(lat, 0.0))
    socket = assign(socket, stations: Station.get_all(), name: name, lat: lat, lon: lon)
    {:noreply, socket}
  end

  def handle_event("search", %{"name" => name}, socket) do
    socket = assign(socket, stations: Station.find_by_name(name))
    {:noreply, socket}
  end

  def render(assigns) do
    ~H"""
        <div class="max-w-4xl p-4 mx-auto">
          <h2 class="mb-4 text-2xl font-bold">Create new station</h2>
          <form phx-submit="insert" class="px-8 pt-6 pb-8 mb-4 bg-white rounded shadow-md">
            <div class="mb-4">
              <label class="block mb-2 text-sm font-bold text-gray-700" for="name">Name:</label>
              <input class="w-full px-3 py-2 leading-tight text-gray-700 border rounded shadow appearance-none focus:outline-none focus:shadow-outline" type="text" name="name" value={@name} />
            </div>
            <div class="mb-4">
              <label class="block mb-2 text-sm font-bold text-gray-700" for="lat">Latitude:</label>
              <input class="w-full px-3 py-2 leading-tight text-gray-700 border rounded shadow appearance-none focus:outline-none focus:shadow-outline" type="number" name="lat" step="0.1" value={@lat} />
            </div>
            <div class="mb-4">
              <label class="block mb-2 text-sm font-bold text-gray-700" for="lon">Longitude:</label>
              <input class="w-full px-3 py-2 leading-tight text-gray-700 border rounded shadow appearance-none focus:outline-none focus:shadow-outline" type="number" name="lon" step="0.1" value={@lon} />
            </div>
            <div class="flex items-center justify-between">
              <button class="px-4 py-2 font-bold text-white bg-blue-500 rounded hover:bg-blue-700 focus:outline-none focus:shadow-outline" type="submit">
                Create Station
              </button>
            </div>
          </form>

          <h2 class="mb-4 text-2xl font-bold">Search for stations</h2>
          <form phx-change="search" class="px-8 pt-6 pb-8 mb-4 bg-white rounded shadow-md">
            <div class="mb-4">
              <label class="block mb-2 text-sm font-bold text-gray-700" for="search-name">Station Name:</label>
                <input
                  class="w-full px-3 py-2 leading-tight text-gray-700 border rounded shadow appearance-none focus:outline-none focus:shadow-outline"
                  id="search-name"
                  type="text"
                  name="name"
                  placeholder="Enter station name..."
                />
              <p class="mt-1 text-xs text-gray-500">Start typing to search automatically</p>
            </div>
          </form>
          <div class="px-8 pt-6 pb-8 mb-4 overflow-x-auto bg-white rounded drop-shadow-md bg-red">
            <table class="min-w-full bg-white">
              <thead class="bg-gray-100">
                <tr>
                  <th class="px-4 py-2 text-left">Name</th>
                  <th class="px-4 py-2 text-left">Longitude</th>
                  <th class="px-4 py-2 text-left">Latitude</th>
                </tr>
              </thead>
              <tbody>
                <%= for station <- @stations do %>
                  <tr class="border-t">
                    <td class="px-4 py-2"><%= station.name %></td>
                    <td class="px-4 py-2"><%= station.lon %></td>
                    <td class="px-4 py-2"><%= station.lat %></td>
                  </tr>
                <% end %>
              </tbody>
            </table>
          </div>
        </div>
        """
  end
end
