function get_input()
    bitstrings = readlines("input/input.txt")
    collect(parse.(Int, bitstring) for bitstring in collect.(bitstrings))
end

function p1(vals)
    # We're going to do direct, fallible indexing
    # This would break with poorly formatted input
    slen = length(vals[1])
    sums = zeros(slen)
    for val in vals, i in range(1, slen)
        @inbounds sums[i] += val[i]
    end
    bools = sums.*2 .> ones(slen) * length(vals)
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
    if length(vals) == 0
        exit(1)
    end
    p1(vals)
    p2(vals)
end

solve()
