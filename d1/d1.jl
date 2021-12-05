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

function p2(vals)
    output = 0
    base = if length(vals) < 4
        0
    else
        sum(vals[1:3])
    end
    new_val = base
    for tup in zip(vals, vals[2:end], vals[3:end])
        new_val = sum(tup)
        if new_val > base
            output += 1
        end
        base = new_val
    end
    println("P2: ", output)
end

function solve()
    vals = get_input()
    p1(vals)
    p2(vals)
end

solve()
