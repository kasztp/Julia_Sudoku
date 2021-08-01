using CSV, DataFrames

function load_board(filename)
    board = CSV.read(filename, DataFrame, header = 0) |> Array{Int8, 2}
    return board
end


function solve!(bo::Array{Int8, 2})
    find = find_empty(bo)
    if find == (10, 10)
        return bo
    else
        row, col = find
    end
    for i in 1:9
        if valid(bo, i, (row, col))
            bo[row, col] = i

            if solve(bo)
                return true
            end
            bo[row, col] = 0
        end
    end
    return false
end


function valid(bo::Array{Int8, 2}, num, pos)
    row = pos[1]
    col = pos[2]
    # Check row
    for i in 1:9
        if bo[row, i] == num && col != i
            return false
        end
    end
    # Check column
    for i in 1:9
        if bo[i, col] == num && row != i
            return false
        end
    end
    # Check box
    box_x = Int8(floor(col / 3))
    if box_x < 1
        box_x = 1
    end
    box_y = Int8(floor(row / 3))
    if box_y < 1
        box_y = 1
    end

    for i in (box_y*3):(box_y*3 + 3)
        for j in (box_x * 3):(box_x*3 + 3)
            if bo[i, j] == num && (i,j) != (col, row)
                return false
            end
        end
    end
    return true
end


function find_empty(bo::Array{Int8, 2})
    for i in 1:9
        for j in 1:9
            if bo[i, j] == 0
                return (i, j)  # row, col
            end
        end
    end
    return (10,10)
end


function print_board(bo::Array{Int8, 2})
    for i in 1:9
        if (i-1) % 3 == 0 && i != 0
            println("- - - - - - - - - - - -")
        end

        for j in 1:9
            if (j-1) % 3 == 0 && j != 1
                print(" | ")
            end
            if j == 9
                println(bo[i, j])
            else
                print("$(bo[i, j]) ")
            end
        end
    end
end


sudoku = load_board(raw"C:\Users\kaszt\github\Julia_Sudoku\9x9.csv")
println(sudoku)
println("\nOriginal:")
print_board(sudoku)
solve(sudoku)
println("\nSolved:")
print_board(sudoku)
