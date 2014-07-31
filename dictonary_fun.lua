-- Generate a bunchof random words and input them off to the left using Super+h 'word' Return Super+l 
-- requires /usr/share/dict/words, xautomation
-- cheating is bad

-- table containing every word in words file greater than 3 characters long and not containing a hyphen or apostrophe
dict = {}
used = {}
-- start and end indexes such that letter_idx["b"] = {start_idx, end_idx} for each letter
letter_idx = {}

math.randomseed(os.time())

for word in io.lines("/usr/share/dict/words") do
    if ((not (string.find(word, "-") or string.find(word, "'"))) and string.len(word) >= 4) then
        table.insert(dict, word)
    end
end

for index, word in ipairs(dict) do
    letter = string.sub(word, 1, 1)
    if not letter_idx[letter] then
        letter_idx[letter] = {index, index}
    elseif letter_idx[letter][2] < index then
        letter_idx[letter][2] = index
    end
end

function rand_word(letter)
    index = math.random(letter_idx[letter][1], letter_idx[letter][2])
    return dict[index]
end

function new_word(letter)
    word = rand_word(letter)
    i = 0
    while used[word] do
        if i == 100 then
            return nil
        end
        word = rand_word(letter)
        i = i + 1
    end
    used[word] = true
    return word
end

while true do
    read = io.read()
    idx = string.find(read, "%l")
    if not idx then
        break
    end
    ch = string.sub(read, idx, idx)
    word = new_word(ch)
    print(word)
    -- very hacky way to input the word using xautomation
    os.execute([[xte 'keydown Super_L' 'key h' 'keyup Super_L']])
    os.execute([[xte 'keydown Control_L' 'key a' 'keyup Control_L' 'key Delete']])
    os.execute([[xte 'str ]] .. word .. [[']] )
    os.execute([[xte 'keydown Super_L' 'key l' 'keyup Super_L']])
end
