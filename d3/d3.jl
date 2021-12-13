function get_input()
    bitstrings = readlines("input/input.txt")
    collect(parse.(Int, bitstring) for bitstring in collect.(bitstrings))
end

function p1(vals, slen)
    sums = zeros(slen)
    for val in vals, i in range(1, slen)
        sums[i] += val[i]
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

function p2(vals, slen)
    oxy = 0
    carb = 0
    output = oxy * carb
    println("P2: ", output)
end

function solve()
    vals = get_input()
    if length(vals) == 0
        exit(1)
    end
    slen = length(vals[1])
    p1(vals, slen)
    p2(vals, slen)
end

solve()
