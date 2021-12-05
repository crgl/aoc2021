function parse_line(s)
    words = split(s)
    (words[1], parse(Int64, words[2]))
end

function get_input()
    map(parse_line, readlines("input/input.txt"))
end

function p1(vals)
    hor = 0
    vert = 0
    for (dir, n) in vals
        if dir == "forward"
            hor += n
        elseif dir == "down"
            vert += n
        elseif dir == "up"
            vert -= n
        else
            println(dir, " is not supported")
            exit(1)
        end
    end
    println("P1: ", hor * vert)
end

function p2(vals)
    hor = 0
    vert = 0
    aim = 0
    for (dir, n) in vals
        if dir == "forward"
            hor += n
            vert += aim * n
        elseif dir == "down"
            aim += n
        elseif dir == "up"
            aim -= n
        else
            println(dir, " is not supported")
            exit(1)
        end
    end
    println("P2: ", hor * vert)
end

function solve()
    vals = get_input()
    p1(vals)
    p2(vals)
end

solve()
