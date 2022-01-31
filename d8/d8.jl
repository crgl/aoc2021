# I can parse all of these as bytes, if I wanted to
# It's a list of 10 bytes and then a list of 4 bytes
# Fits in an Int128, but that's not what you'd really want
# We also want counts pretty accessible and there's not really a space concern
#   0:      1:      2:      3:      4:
#  aaaa    ....    aaaa    aaaa    ....
# b    c  .    c  .    c  .    c  b    c
# b    c  .    c  .    c  .    c  b    c
#  ....    ....    dddd    dddd    dddd
# e    f  .    f  e    .  .    f  .    f
# e    f  .    f  e    .  .    f  .    f
#  gggg    ....    gggg    gggg    ....

#   5:      6:      7:      8:      9:
#  aaaa    aaaa    aaaa    aaaa    aaaa
# b    .  b    .  .    c  b    c  b    c
# b    .  b    .  .    c  b    c  b    c
#  dddd    dddd    ....    dddd    dddd
# .    f  e    f  .    f  e    f  .    f
# .    f  e    f  .    f  e    f  .    f
#  gggg    gggg    ....    gggg    gggg

# Ignoring the lettering, we have by number of segments:
# 7: 8
# 6: 0, 6, 9
# 5: 2, 3. 5
# 4: 4
# 3: 7
# 2: 1

# or, by segment:
# a: 0, 2, 3, 5, 6, 7, 8, 9
# b: 0, 4, 5, 6, 8, 9
# c: 0, 1, 2, 3, 4, 7, 8, 9
# d: 2, 3, 4, 5, 6, 8, 9
# e: 0, 2, 6, 8, 9
# f: 0, 1, 3, 4, 5, 6, 7, 8, 9
# g: 0, 2, 3, 5, 6, 8, 9

# so 0, 6, and 9 are missing d, c, and e, respectively
# This means that we can identify those 3 segments as a set
# We can also identify a, c, and f by 7 (3 segments)
# so we have 6 identified by that which doesn't contain all of 7's segments
# We could then use 4 to split 0 and 9, because 4 union 7 is contained in 9 but not 0
# 2, 3, and 5: get 3 using 7
# Then, use 9 for 5
# Do this one at a time, then store digits. In fact, just output the 4 digit codes for now

function get_input()
    displays = []
    for line in readlines("input/input.txt")
        mapping = Dict()
        input = split(line)
        unique_digits = sort([Set(s) for s in input[1:10]], by=length)
        mapping[8] = unique_digits[10]
        mapping[1] = unique_digits[1]
        mapping[7] = unique_digits[2]
        mapping[4] = unique_digits[3]
        for digit in unique_digits[7:9]
            if length(digit) != 6
                exit(1)
            end
            if length(union(digit, mapping[7])) != length(digit)
                mapping[6] = digit
            elseif length(union(digit, mapping[4])) != length(digit)
                mapping[0] = digit
            else
                mapping[9] = digit
            end
        end
        for digit in unique_digits[4:6]
            if length(digit) != 5
                exit(1)
            end
            if length(union(digit, mapping[7])) == length(digit)
                mapping[3] = digit
            elseif length(union(digit, mapping[9])) == length(mapping[9])
                mapping[5] = digit
            else
                mapping[2] = digit
            end
        end
        values = sort(collect(pairs(mapping)), by=p -> p[1])
        function disp_to_dig(s, values=values)
            for val in values
                if issetequal(val[2], s)
                    return val[1]
                end
            end
            println("Error! Semi-gracefully exiting")
            println(mapping)
            println(values)
            exit(1)
        end
        display = [disp_to_dig(Set(s)) for s in input[end-3:end]]
        push!(displays, display)
    end
    displays
end

function p1(displays)
    easy = Set([1, 4, 7, 8])
    output = 0
    for display in displays
        for digit in display
            if digit in easy
                output += 1
            end
        end
    end
    println("P1: ", output)
end

function p2(displays)
    output::Int128 = 0
    for display in displays
        for (i, val) in enumerate(reverse(display))
            output += exp10(i - 1) * val
        end
    end
    println("P2: ", output)
end

function solve()
    displays = get_input()
    if length(displays) == 0
        println("Empty input!")
        exit(1)
    end
    p1(displays)
    p2(displays)
end

solve()
