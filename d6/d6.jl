# In theory this should be a recursive function of sorts
# f(m, n) = f(m - 1, n - 1) if n > 0 and m > 0
# f(0, n) = 1 if m == 0
# f(m, 0) = f(m - 1, 6) + f(m - 1, 8)
# How does this help, exactly?
# Caching and recursion, I suppose, puts us at at most m * n which is in this case ~640 calls
# super reasonable, I must admit, since the recursion depth is also capped
# Now it's just a matter of how dictionaries are passed around in julia

function get_input()
    parse.(Int128, split(readline("input/input.txt"), ","))
end

function recurse(m, n, cache)
    if (m, n) in keys(cache)
        cache[(m, n)]
    elseif m == 0
        cache[(m, n)] = 1
        1
    elseif n == 0
        output = recurse(m - 1, 6, cache) + recurse(m - 1, 8, cache)
        cache[(m, n)] = output
        output
    else
        output = recurse(m - 1, n - 1, cache)
        cache[(m, n)] = output
        output
    end
end

function p1(vals)
    output = 0
    cache = Dict()
    for val in vals
        output += recurse(80, val, cache)
    end
    println("P1: ", output)
end

function p2(vals)
    output = 0
    cache = Dict()
    for val in vals
        output += recurse(256, val, cache)
    end
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
