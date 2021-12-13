function get_input()
    bitstrings = readlines("input/input.txt")
    collect(bitstring .== '1' for bitstring in collect.(bitstrings))
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
    tmp = vals
    for i in range(1,slen)
        n = length(tmp)
        if n == 1
            break
        end
        count = sum(getindex.(tmp, i))
        desired = if count * 2 >= n
            1
        else
            0
        end
        tmp = tmp[getindex.(tmp, i) .== desired]
    end
    oxy = 0
    for i in range(1, slen)
        oxy += tmp[1][i] << (slen - i)
    end
    tmp = vals
    for i in range(1,slen)
        n = length(tmp)
        if n == 1
            break
        end
        count = sum(getindex.(tmp, i))
        desired = if count * 2 >= n
            0
        else
            1
        end
        tmp = tmp[getindex.(tmp, i) .== desired]
    end
    carb = 0
    for i in range(1, slen)
        carb += tmp[1][i] << (slen - i)
    end
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
