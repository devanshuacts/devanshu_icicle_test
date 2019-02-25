class Dictionary

    require_relative "lib/hash_dictionary"
    include HashDictionary

    # Load the given text file into a hash using module HashDictionary add_to_hash method
    def load_file_to_hash
        @dict_hash = Hash.new
        file_text = File.read(File.join(File.dirname(__FILE__), "dictionary.txt"))
        file_text.each_line do |line|
            add_to_hash(line.strip)
        end
        @dict_hash
    end

    # If the argument is not an Integer or not equal to 10 digits, return empty array
    # Else, returns an array of words possible for the 10 digit Integer
    def return_all_words(num)
        empty_arr = []
        num_str = num.to_s
        return empty_arr if !(num.is_a? Integer) or num_str.length != 10
        word_list = get_dictionary_words(num_str)
    end

    # *********************************** private methods ****************************************************************#
    private

    # method to get all the possible words from the dictionary
    def get_dictionary_words(num_str)
        list = []
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
        word_lengths.each_index do |index|
            character_arrays = []
            len_str = word_lengths[index]
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
            char_arrs.push(numchar_map[char])
        end
        char_arrs
    end

    # join the cartesian product of characters to form words
    def chararr_to_words(char_arrs)
        first, *rest = char_arrs
        arr_product = first.product(*rest)
        arr_product.map { |arr| arr.join}
    end

end

# dict = Dictionary.new
# dict.load_file_to_hash
# list = dict.return_all_words(2282668687) ##To execute for any other number replace the default number by custom number
# p list
