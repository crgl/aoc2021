function get_input()
    readlines("input/input.txt")
end

function p1(vals, n, slen)
    # We're going to do direct, fallible indexing
    # This would break with poorly formatted input
    sums = zeros(slen)
    for val in vals, i in range(1, slen)
        @inbounds sums[i] += parse(Int, val[i])
    end
    bools = sums.*2 .> ones(slen) * n
    gam = 0
    eps = 0
    for (i, b) in enumerate(bools)
        if b
            gam += (1 << (slen - i))
        else
            eps += (1 << (slen - i))
        end
    end
    println("P1: ", gam * eps)
end

function p2(vals)
    println("P2: ", "???")
end

function solve()
    vals = get_input()
    n = length(vals) # number of vals
    slen = if n > 0
        length(vals[1])
    else
        print("P1: 0??")
        exit(1)
        n
    end
    p1(vals, n, slen)
    p2(vals)
end

solve()
