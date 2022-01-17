function get_input()
    lines = readlines("input/input.txt")
    n = length(lines)
    vents = Array{Vector{Int64}}(undef, n)
    for (i, line) in enumerate(lines)
        segment = parse.(Int64, vcat(split.(split(line, " -> "), ",")...))
        vents[i] = segment
    end
    vents
end

function p1(vents)
    vent_counts = Dict()
    for vent in vents
        x1, y1, x2, y2 = vent
        if y1 > y2
            y1, y2 = y2, y1
        end
        if x1 > x2
            x1, x2 = x2, x1
        end
        if x1 == x2
            for y in range(y1, y2)
                tup = (x1, y)
                if tup in keys(vent_counts)
                    vent_counts[tup] += 1
                else
                    vent_counts[tup] = 1
                end
            end
        elseif y1 == y2
            for x in range(x1, x2)
                tup = (x, y1)
                if tup in keys(vent_counts)
                    vent_counts[tup] += 1
                else
                    vent_counts[tup] = 1
                end
            end
        end
    end
    output = 0
    for val in values(vent_counts)
        if val > 1
            output += 1
        end
    end
    println("P1: ", output)
end

function p2(vents)
    vent_counts = Dict()
    for vent in vents
        x1, y1, x2, y2 = vent
        ystep = if y1 > y2
            -1
        else
            1
        end
        xstep = if x1 > x2
            -1
        else
            1
        end
        if x1 == x2
            for y in range(y1, y2, step = ystep)
                tup = (x1, y)
                if tup in keys(vent_counts)
                    vent_counts[tup] += 1
                else
                    vent_counts[tup] = 1
                end
            end
        elseif y1 == y2
            for x in range(x1, x2, step = xstep)
                tup = (x, y1)
                if tup in keys(vent_counts)
                    vent_counts[tup] += 1
                else
                    vent_counts[tup] = 1
                end
            end
        else
            for tup in zip(range(x1, x2, step = xstep), range(y1, y2, step = ystep))
                if tup in keys(vent_counts)
                    vent_counts[tup] += 1
                else
                    vent_counts[tup] = 1
                end
            end
        end
    end
    output = 0
    for val in values(vent_counts)
        if val > 1
            output += 1
        end
    end
    println("P2: ", output)
end

function solve()
    vents = get_input()
    if length(vents) == 0
        println("Empty input!")
        exit(1)
    end
    p1(vents)
    p2(vents)
end

solve()
