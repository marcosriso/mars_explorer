defmodule MarsExplorer do
  @moduledoc """
  MarsExplorer logic
  """

  def processCommands(roverName, roverInitialPosition, roverCommands) do
    {xpos, _} = Enum.at(roverInitialPosition, 0) |> Integer.parse()
    {ypos, _} = Enum.at(roverInitialPosition, 1) |> Integer.parse()
    direction = Enum.at(roverInitialPosition, 2)

    roverStruct = %Rover{name: roverName, xpos: xpos, ypos: ypos, direction: direction, path: [%{:x => xpos, :y => ypos}]}
    totalCommmands = Enum.count(roverCommands) - 1
    startAt = 0
    processedRover = processCommands(roverCommands, roverStruct, totalCommmands, startAt)
  end

  def move(roverStruct, command) do
    directions = ["N", "E", "S", "W"]
    direction = roverStruct.direction

    roverStruct =
      case command do
        "L" ->
          i = Enum.find_index(directions, fn(x) -> x == direction end)
          direction =
            if (i==0) do
              Enum.at(directions, 3)
            else
              Enum.at(directions, i-1)
            end
          Map.put(roverStruct, :direction, direction)

        "R" ->
          i = Enum.find_index(directions, fn(x) -> x == direction end)
          direction =
            if (i==3) do
              Enum.at(directions, 0)
            else
              Enum.at(directions, i+1)
            end
          Map.put(roverStruct, :direction, direction)

        "M" ->
          axisMovementDefinition(roverStruct, direction)
        _ ->
          roverStruct
          # Default: Ignores and do nothing right now.
      end

  end

  def axisMovementDefinition(roverStruct, direction) do
    xpos = roverStruct.xpos
    ypos = roverStruct.ypos
    path = roverStruct.path

    roverStruct =
      case direction do
        "N" ->
          ypos = ypos + 1
          Map.put(roverStruct, :ypos, ypos)
        "E" ->
          xpos = xpos + 1
          Map.put(roverStruct, :xpos, xpos)
        "S" ->
          ypos = ypos - 1
          Map.put(roverStruct, :ypos, ypos)
        "W" ->
          xpos = xpos - 1
          Map.put(roverStruct, :xpos, xpos)
        _ ->
          roverStruct
          # Default: Ignores and do nothing right now.
      end

    path = path ++ [%{:x => xpos, :y => ypos}]
    roverStruct = %{roverStruct | path: path}

  end

  # Recursive Magic
  def processCommands(roverCommands, roverStruct, totalCommmands, startAt) when startAt < totalCommmands do
    roverStruct = move(roverStruct, Enum.at(roverCommands, startAt))
    processCommands(roverCommands, roverStruct, totalCommmands, startAt + 1)
  end

  def processCommands(roverCommands, roverStruct, totalCommmands, startAt) do
    roverStruct = move(roverStruct, Enum.at(roverCommands, startAt))
  end

end
