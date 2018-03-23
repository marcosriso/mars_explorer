defmodule MarsExplorerWeb.CommController do
  use MarsExplorerWeb, :controller

  def receive(conn, params) do
    infolines = String.split(params["msg"], "\n")

    explorationArea = Enum.at(infolines, 0) |> String.split(" ")

    # Red Rover
    redRoverInitialPosition = Enum.at(infolines, 1) |> String.split(" ")
    redRoverCommands = Enum.at(infolines, 2)  |> String.codepoints()
    redRoverEndPosition = MarsExplorer.processCommands("Red", redRoverInitialPosition, redRoverCommands)

    # Blue Rover
    blueRoverInitialPosition = Enum.at(infolines, 3)  |> String.split(" ")
    blueRoverCommands = Enum.at(infolines, 4) |> String.codepoints()
    blueRoverEndPosition = MarsExplorer.processCommands("Blue", blueRoverInitialPosition, blueRoverCommands)

    # return values
    msg = %{:explorationArea => explorationArea, :redrover => redRoverEndPosition, :bluerover => blueRoverEndPosition}
    json conn, msg
  end
end