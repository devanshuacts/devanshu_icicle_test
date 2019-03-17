class Dictionary

    require_relative "./dictionary_management"
    include DictionaryManagement

    NUM_LENGTH = 10.freeze
    MIN_WORD_LENGTH = 3.freeze

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

    # New dictionary object loads dictionary.txt file into a new hash object
    # It uses load_file_to_hash method of DictionaryManagement module
    def initialize
        file = File.join(File.dirname(__FILE__), "../dictionary.txt")
        load_file_to_hash(file, MIN_WORD_LENGTH)
    end

    # If the argument is not an Integer or not equal to 10 digits, return empty array
    # Else, returns an array of words possible for the 10 digit Integer
    def return_all_words(num)
        empty_arr = []
        num_str = num.to_s
        return empty_arr if !(num.is_a? Integer) or num_str.length != NUM_LENGTH
        return empty_arr if (num_str.include? '0' or num_str.include? '1')
        word_list = get_dictionary_words(num_str)
    end

    # *********************************** private methods ****************************************************************#
    private

    # method to get all the possible words from the dictionary
    def get_dictionary_words(num_str)
        list = []
        combinations = find_combinations
        combinations.each do |word_lengths|
            possible_words = get_combination_words(num_str, word_lengths)
            next if possible_words.include?([]) #if one word_length returns an empty array, jump to next word length combination
            one, *remaining = possible_words
            list.push(one.product(*remaining)) #find permutations of all possible word combinations
        end
        list.empty? ? list : list.flatten!(1) #flatten into a one dimensional array
    end

    # method which returns all the words for a particular combination e.g. [4,3]
    # i.e. all possible words of 4 and 3 letters for the number
    def get_combination_words(num_str, word_lengths)
        this_comb = []
        start_pos_str = len_str = 0
        word_lengths.each do |word_length|
            character_arrays = []
            len_str = word_length
            character_arrays = num_char_map(num_str, start_pos_str, len_str, character_arrays)
            start_pos_str = start_pos_str + len_str
            word_arr = chararr_to_words(character_arrays)
            words = return_dict_words(word_arr)
            this_comb.push(words)
        end
        this_comb
    end

    # convert number to its corresponding character map
    def num_char_map(str, start, len, char_arrs)
        str[start,len].each_char do |char|
            char_arrs.push(NUMCHAR_MAP[char])
        end
        char_arrs
    end

    # join the cartesian product of characters to form words
    def chararr_to_words(char_arrs)
        first, *rest = char_arrs
        arr_product = first.product(*rest)
        arr_product.map { |arr| arr.join}
    end

    # from the word array passed return only those words which are present in dictionary hash
    # uses exists_in_dict method of DictionaryManagement module to check whether a word exists in dictionary or not
    def return_dict_words(word_arr)
        words = []
        word_arr.each do |word|
            if exists_in_dict(word, MIN_WORD_LENGTH)
                words.push(word)
            end
        end
        words
    end

    # return all combinations(pairs, triplets etc.) of word lengths possible for a fixed minimum word length and the number of digits/max length of word
    def find_combinations
        comb_arr = []
        return [] unless MIN_WORD_LENGTH.between?(1, NUM_LENGTH)
        word_len = MIN_WORD_LENGTH
        max_len = NUM_LENGTH
        comb_arr = find_all_pairs(MIN_WORD_LENGTH, NUM_LENGTH)
        comb_arr.each do |arr|
            arr.each_with_index do |ele, index|
                arr_cp = arr.dup
                new_pair = []
                if (ele >= 2*MIN_WORD_LENGTH)
                    new_pair = calculate_single_pair(MIN_WORD_LENGTH, ele)
                    arr_cp[index] = new_pair
                    comb_arr.push(arr_cp.flatten(1))
                end
            end
        end
        comb_arr.push([max_len])
        comb_arr.uniq!
    end
    
    #returns only pairs for a given word length and max length
    def find_all_pairs(word_len, max_len)
        comb_arr = []
        while(word_len <= max_len)
            pair = calculate_single_pair(word_len, max_len)
            comb_arr.push(pair) if !pair.nil?
            word_len += 1
        end
        comb_arr
    end
    
    # calculates a single pair for a given word length, max length and minimum word length
    def calculate_single_pair(word_len, max_len)
        pair_word_len = max_len - word_len
        [word_len, pair_word_len] if ( pair_word_len >= MIN_WORD_LENGTH )
    end
end

# dict = Dictionary.new
# # dict.load_file_to_hash
# list1 = dict.return_all_words(2282668687) ##To execute for any other number replace the default number by custom number
# p list1

# #dict.load_file_to_hash
# list2 = dict.return_all_words(6686787825) ##To execute for any other number replace the default number by custom number
# p list2
