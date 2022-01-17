"""
Overdesigning:

Store every board as well as a 5x5 bitarray defaulting to ones and a set of
remaining counts (initialized to 12 5s) and a mapping from numbers to positions

Every time a number is called, go through its list of indices, decrementing and
flipping bits. When any of the counters hit 0, multiply the board by its
corresponding bitarray, sum, multiply by the current number, and return. P1!

"""

function get_input()
    lines = readlines("input/input.txt")
    if length(lines) < 7
        println("Insufficient input!")
        exit(1)
    end
    calls = parse.(Int64, split(popfirst!(lines), ","))
    boards = []
    locs = Dict()
    for idx in range(1, length=length(lines) ÷ 6)
        board = zeros(Int64, 5, 5)
        input_idx = (idx - 1) * 6 + 1
        for i in range(1, length=5)
            line = try
                parse.(Int64, split(lines[input_idx + i]))
            catch e
                println(board)
                exit()
            end
            for (j, val) in enumerate(line)
                board[i, j] = val
                if val in keys(locs)
                    push!(locs[val], (idx, i, j))
                else
                    locs[val] = [(idx, i, j)]
                end
            end
        end
        push!(boards, board)
    end
    (calls, boards, locs)
end

function pos_to_diag(i, j)
    ret = UInt64[]
    if i == j
        push!(ret, 1)
    end
    if i + j == 4
        push!(ret, 2)
    end
    ret
end

function p1(calls, boards, locs)
    tokens = [ones(Bool, 5, 5) for _ in boards]
    counts = [ones(Int64, 3, 5) .* 5 for _ in boards]
    done = 0
    for call in calls
        if call in keys(locs)
            for (idx, i, j) in locs[call]
                tokens[idx][i, j] = 0
                counts[idx][1, i] -= 1
                if counts[idx][1, i] == 0
                    done = idx
                end
                counts[idx][2, j] -= 1
                if counts[idx][2, j] == 0
                    done = idx
                end
                for k in pos_to_diag(i, j)
                    counts[idx][3, k] -= 1
                    if counts[idx][3, k] == 0
                        done = idx
                    end
                end
            end
        end
        if done != 0
            return sum(tokens[done] .* boards[done]) * call
        end
    end
    return "???"
end

function p2(calls, boards, locs)
    tokens = [ones(Bool, 5, 5) for _ in boards]
    counts = [ones(Int64, 3, 5) .* 5 for _ in boards]
    finished = Set()
    num_boards = length(boards)
    final = 0
    for call in calls
        if call in keys(locs)
            for (idx, i, j) in locs[call]
                if length(finished) != num_boards
                    final = idx
                end
                tokens[idx][i, j] = 0
                counts[idx][1, i] -= 1
                if counts[idx][1, i] == 0
                    push!(finished, idx)
                end
                counts[idx][2, j] -= 1
                if counts[idx][2, j] == 0
                    push!(finished, idx)
                end
                for k in pos_to_diag(i, j)
                    counts[idx][3, k] -= 1
                    if counts[idx][3, k] == 0
                        push!(finished, idx)
                    end
                end
            end
        end
        if length(finished) == num_boards
            return sum(tokens[final] .* boards[final]) * call
        end
    end
    return "???"
end

function solve()
    calls, boards, locs = get_input()
    o1 = p1(calls, boards, locs)
    println("P1: ", o1)
    o2 = p2(calls, boards, locs)
    println("P2: ", o2)
end

solve()
