maxRow = 20
maxCol = 20
life = {}
count = 0

function instruction()
  print("This is Conway's Life game rewritten in Lua.")
end

function getRowCol()
  local function getRow()
    print("Row:")
    local row = tonumber(io.read())
    if row == 0 then do return end end
    while row == nil or row < 3 do
      print("Please enter a valid number.")
      row = tonumber(io.read())
    end
    maxRow = row
  end

  local function getCol()
    print("Collum:")
    local col = tonumber(io.read())
    if col == 0 then do return end end
    while col == nil or col < 3 do
      print("Please enter a valid number.")
      col = tonumber(io.read())
    end
    maxCol = col
  end

  print("Please enter the size of the board (A minimum of 3x3. Type '0' for a default set of 20x20).")
  getRow()
  print("The board currenly has "..maxRow.." Rows.")
  getCol()
  print("The board currenly has "..maxCol.." Collums.")
end

function initialize()
  for i = 1, maxRow do
    life[i] = {}
    for j = 1, maxCol do
      life[i][j] = 0
    end
  end

  local function setRow()
    while row == nil or row < 1 or row > maxRow do
      if row == nil then
        print("Your input must be a number!")
      elseif row < 1 or row > maxRow then
        print("Out of range!")
      end
      row = tonumber(io.read())
    end
  end

  local function setCol()
    while col == nil or col < 1 or col > maxCol do
      if col == nil then
        print("Your input must be a number!")
      elseif col < 1 or col > maxCol then
        print("Out of range!")
      end
      col = tonumber(io.read())
    end
  end

  print("Please list the coordinates of lives. Type '-1' when finished.")
  row = tonumber(io.read())
  while row ~= -1 do
    setRow()
    col = tonumber(io.read())
    setCol()
    life[row][col] = 1
    row = tonumber(io.read())
  end
  printLife()
end

function printLife()
  for i = 1, maxRow do
    for j = 1, maxCol do
      if life[i][j] == 1 then
        count = count + 1
        io.write('*')
      else
        io.write("0")
      end
    end
    io.write('\n')
  end
  next()
end

function next()
  print("Continue?(y/any)")
  y = tostring(io.read())
  if y == 'y' or y == 'Y' then
    if count ~= 0 then
      count = 0
      updateLife()
    else
      print("Game Over...")
      os.exit()
    end
  else
    print("Exit...")
    os.exit()
  end
end

function updateLife()
  local newLife = {}
  for i = 1, maxRow do
    newLife[i] = {}
    for j = 1, maxCol do
      local count = neighbor(i, j)
      if count == 2 then
        newLife[i][j] = life[i][j]
      elseif count == 3 then
        newLife[i][j] = 1
      else
        newLife[i][j] = 0
      end
    end
  end

  for i = 1, maxRow do
    for j = 1, maxCol do
      life[i][j] = newLife[i][j]
    end
  end

  printLife()
end

function neighbor(row, col)
  local count = 0
  for i = row-1, row+1 do
    if i > 0 and i <= maxRow then
      for j = col-1, col+1 do
        if j > 0 and j <= maxCol then
          count = count + life[i][j]
        end
      end
    end
  end
  count = count - life[row][col]
  return count
end

instruction()
getRowCol()
initialize()
