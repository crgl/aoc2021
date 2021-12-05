function get_input()
    parse.(Int64, readlines("input/input.txt"))
end

function p1(vals)
    output = 0
    base = if length(vals) < 1
    0
    else
        vals[1]
    end
    for val in vals
        if val > base
            output += 1
        end
        base = val
    end
    println("P1: ", output)
end

function solve()
    vals = get_input()
    p1(vals)
end

solve()
