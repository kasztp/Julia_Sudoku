using CSV, DataFrames

function load_board(filename)
    board = CSV.read(filename, DataFrame, header = 0) |> Matrix{Int8}
    return board
end

println(load_board(raw"C:\Users\kaszt\github\Julia_Sudoku\9x9.csv"))
