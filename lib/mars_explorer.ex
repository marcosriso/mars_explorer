defmodule MarsExplorer do
  @moduledoc """
  MarsExplorer keeps the contexts that define your domain
  and business logic.

  Contexts are also responsible for managing your data, regardless
  if it comes from the database, an external API or others.
  """

  def processCommands(roverName, roverInitialPosition, roverCommands) do
    {xpos, _} = Enum.at(roverInitialPosition, 0) |> Integer.parse()
    {ypos, _} = Enum.at(roverInitialPosition, 1) |> Integer.parse()
    direction = Enum.at(roverInitialPosition, 2)

    roverStruct = %Rover{name: roverName, xpos: xpos, ypos: ypos, direction: direction, path: []}
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
      end

  end

  def axisMovementDefinition(roverStruct, direction) do
    xpos = roverStruct.xpos
    ypos = roverStruct.ypos

    roverStruct =
      case direction do
        "N" ->
          Map.put(roverStruct, :ypos, (ypos + 1))
        "E" ->
          Map.put(roverStruct, :xpos, (xpos + 1))
        "S" ->
          Map.put(roverStruct, :ypos, (ypos - 1))
        "W" ->
          Map.put(roverStruct, :xpos, (xpos - 1))
      end


  end

  def processCommands(roverCommands, roverStruct, totalCommmands, startAt) when startAt < totalCommmands do
    roverStruct = move(roverStruct, Enum.at(roverCommands, startAt))
    processCommands(roverCommands, roverStruct, totalCommmands, startAt + 1)
  end

  def processCommands(roverCommands, roverStruct, totalCommmands, startAt) do
    roverStruct = move(roverStruct, Enum.at(roverCommands, startAt))
  end

end
