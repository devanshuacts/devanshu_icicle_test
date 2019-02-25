module HashDictionary

    # The combination of word lengths possible for a 10 digit Integer
    COMBINATIONS = [[3,3,4], [3,4,3], [3,7], [4,3,3], [4,6], [5,5], [6,4], [7,3], [10]]

    # Number to char mapping
    NUMCHAR_MAP = {
        '2' => ['a', 'b', 'c'],
        '3' => ['d', 'e', 'f'],
        '4' => ['g', 'h', 'i'],
        '5' => ['j', 'k', 'l'],
        '6' => ['m', 'n', 'o'],
        '7' => ['p', 'q', 'r', 's'],
        '8' => ['t', 'u', 'v'],
        '9' => ['w', 'x', 'y', 'z']
    }

    # encapsulate COMBINATIONS array into a method
    def combinations
        COMBINATIONS
    end

    # encapsulate NUMCHAR_MAP hash into a method
    def numchar_map
        NUMCHAR_MAP
    end

    # add each string to hash data structure
    # the hash consists of keys of 3 letter words and values as words starting from it including itself
    def add_to_hash(str)
        key = str.slice(0,3)
        @dict_hash[key] = [] unless @dict_hash[key]
        @dict_hash[key].push(str)
    end

    # from the word array passed return only those words which are present in dictionary hash
    def return_dict_words(word_arr)
        words = []
        word_arr.each do |word|
            key = word.slice(0,3).upcase
            if @dict_hash[key] && @dict_hash[key].include?(word.upcase)
                words.push(word)
            end
        end
        words
    end
end