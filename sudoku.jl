using CSV, DataFrames, Dates


function load_board(filename)
    board = CSV.read(filename, DataFrame, header = 0) |> Array{Int8, 2}
    return board
end


function print_board(board::Array{Int8, 2})
    for i in 1:9
        if (i-1) % 3 == 0 && i != 0
            println("- - - - - - - - - - - -")
        end

        for j in 1:9
            if (j-1) % 3 == 0 && j != 1
                print(" | ")
            end
            if j == 9
                println(board[i, j])
            else
                print("$(board[i, j]) ")
            end
        end
    end
end


function solve(board::Array{Int8, 2})
    find = find_empty(board)
    if find == (10, 10)
        return true
    else
        row, col = find
        for i in 1:9
            if valid(board, i, (row, col))
                board[row, col] = i
                if solve(board)
                    return true
                else
                    board[row, col] = 0
                end
            end
        end
    end
    return false
end


function valid(board::Array{Int8, 2}, num, pos)
    row = pos[1]
    col = pos[2]

    # Check row
    for i in 1:9
        if ((board[row, i] == num) && (col != i))
            return false
        end
    end

    # Check column
    for i in 1:9
        if ((board[i, col] == num) && (row != i))
            return false
        end
    end

    # Check box
<<<<<<< HEAD
    coordinates = Dict( 1 => 1, 2 => 1, 3 => 1,
                        4 => 4, 5 => 4, 6 => 4,
                        7 => 7, 8 => 7, 9 => 7)
    box = board[coordinates[row]:(coordinates[row]+2),
          coordinates[col]:(coordinates[col]+2)]
=======
    coordinates = Dict(1 => 1, 2 => 1, 3 => 1, 4 => 4, 5 => 4, 6 => 4, 7 => 7, 8 => 7, 9 => 7)
    #box_x = coordinates[col]
    #box_y = coordinates[row]
    box = board[coordinates[row]:(coordinates[row]+2),coordinates[col]:(coordinates[col]+2)]
>>>>>>> 80c2382d64fefab3fd55daa2559add8afd1bc764
    num_in_box = findall( x -> x == num, box )

    if length(num_in_box) > 0
        return false
    end

    return true
end


function find_empty(board::Array{Int8, 2})
    for i in 1:9
        for j in 1:9
            if board[i, j] == 0
                return (i, j)  # row, col
            end
        end
    end
    return (10,10)
end


sudoku = load_board(raw"C:\Users\kaszt\github\Julia_Sudoku\9x9.csv")
println("\nOriginal:\n")
print_board(sudoku)
start_time = Time(Dates.now())
solve(sudoku)
end_time = Time(Dates.now())
println("\nSolved:\n")
print_board(sudoku)
time_taken = end_time - start_time
println(Dates.Millisecond(time_taken))
