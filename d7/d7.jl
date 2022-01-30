# So, this also seems like a math problem. I think the answer is probably to sum them all
# And then to take note of where the shifts are. Conveniently, all are positive
# And narrowly indicated, so it's very easy to iterate across.
# We start out subtracting the count, and then after that we keep subtracting double the number
# Once it goes negative, we stop moving. So we have a total O(n) steps
# I think I'll just go one by one, but in theory you could only stop at numbers with at least one point
# Fine I'll at least do the minimum thing, but no reason to do the O(n) thing
# It's 1000 now, still fine

using Statistics

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
    median
    println("The median value is approximately ", median(vals))
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

# Part 2 has more going on. We're now weighting further points much higher
# In fact... I think before we wanted to choose the median and now we want the mean?
# This is a whole error vs squared error thing. Let's spot check that first.
# Squares with the median. So I believe we should be able to just calculate the value at the mean
# although specifically, right... it's the sum from 1 to n, which is n * (n + 1) / 2. works for me!
# Tempting to just round, but let's check floor and ceiling first
# As we should have! Rounding was not quite the answer, I am surprised to say
# Well, not that surprised as I checked, but it is not quite squared error in any case
# Also I had initially forgotten absolute values, like a fool

function p2(vals)
    output::Int128 = 0
    stop_cand = mean(vals)
    println("The mean is ", stop_cand)
    predicted_stop = round(stop_cand)
    println(predicted_stop)
    poss1 = floor(stop_cand)
    poss2 = ceil(stop_cand)
    poss3 = poss1 - 1
    poss4 = poss2 + 1
    for val in vals
        diff = abs(val - predicted_stop)
        output += (diff * (diff + 1)) / 2
    end
    println("P2: ", output)
    println("if we were doing exact errors, but")
    output = 0
    for val in vals
        diff = abs(val - poss1)
        output += (diff * (diff + 1)) / 2
    end
    println("P2 based on floor: ", output)
    output = 0
    for val in vals
        diff = abs(val - poss2)
        output += (diff * (diff + 1)) / 2
    end
    println("P2 based on ceiling: ", output)
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
