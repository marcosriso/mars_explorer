defmodule MarsExplorer do
  @moduledoc """
  MarsExplorer keeps the contexts that define your domain
  and business logic.

  Contexts are also responsible for managing your data, regardless
  if it comes from the database, an external API or others.
  """

  def processCommands(roverName, roverInitialPosition, roverCommands) do
    xpos = Enum.at(roverInitialPosition, 0)
    ypos = Enum.at(roverInitialPosition, 1)
    direction = Enum.at(roverInitialPosition, 2)

    roverStruct = %Rover{name: roverName, xpos: xpos, ypos: ypos, direction: direction}
    totalCommmands = Enum.count(roverCommands)
    startAt = 0
    processedRover = processCommands(roverCommands, roverStruct, totalCommmands, startAt)
  end

  def move(roverStruct, command) do
    directions = ["N", "E", "S", "W"]
    direction = roverStruct.direction
    case command do
      "L" ->
        i = Enum.find_index(directions, fn(x) -> x == direction end)
        if (i==0) do
          direction = Enum.at(directions, 3)
        else
          direction = Enum.at(directions, i-1)
        end
        roverStruct
      "R" ->
        i = Enum.find_index(directions, fn(x) -> x == direction end)
        if (i==3) do
          direction = Enum.at(directions, 2)
        else
          direction = Enum.at(directions, i+1)
        end
        roverStruct
      "M" ->
        i = Enum.find_index(directions, fn(x) -> x == direction end)
        roverStruct
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
