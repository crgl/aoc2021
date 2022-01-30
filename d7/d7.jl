# So, this also seems like a math problem. I think the answer is probably to sum them all
# And then to take note of where the shifts are. Conveniently, all are positive
# And narrowly indicated, so it's very easy to iterate across.
# We start out subtracting the count, and then after that we keep subtracting double the number
# Once it goes negative, we stop moving. So we have a total O(n) steps
# I think I'll just go one by one, but in theory you could only stop at numbers with at least one point
# Fine I'll at least do the minimum thing, but no reason to do the O(n) thing
# It's 1000 now, still fine

function get_input()
    parse.(Int64, split(readline("input/input.txt"), ","))
end

function p1(vals)
    n = length(vals)
    min_val = min(vals...)
    max_val = max(vals...)
    output = sum(map(val -> val - min_val +1, vals))
    subtractand = n
    counts = Dict()
    for val in vals
        if ~ haskey(counts, val)
            counts[val] = 0
        end
        counts[val] += 1
    end
    for i in range(min_val, max_val)
        output -= subtractand
        if haskey(counts, i)
            subtractand -= 2 * counts[i]
        end
        if subtractand <= 0
            println("We stopped at ", i, " for the record")
            break
        end
    end
    println("P1: ", output)
end

function p2(vals)
    output = 0
    println("P2: ", output)
end

function solve()
    vals = get_input()
    if length(vals) == 0
        println("Empty input!")
        exit(1)
    end
    p1(vals)
    p2(vals)
end

solve()
