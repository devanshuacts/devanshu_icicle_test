module DictionaryManagement

    def load_file_to_hash(file, key_word_length)
        @dict_hash = Hash.new
        file_text = File.read(file)
        file_text.each_line do |line|
            add_to_hash(line.strip, key_word_length)
        end
        @dict_hash
    end

    # add each string to hash data structure
    # the hash consists of keys of minimum word length letter and values as words starting from it including itself
    def add_to_hash(str, key_word_length)
        key = str.slice(0, key_word_length)
        @dict_hash[key] = [] unless @dict_hash[key]
        @dict_hash[key].push(str)
    end

    # checks whether the provided word exists in dictionary hash or not
    def exists_in_dict(word, key_word_length)
        key = word.slice(0,key_word_length).upcase
        if @dict_hash[key] && @dict_hash[key].include?(word.upcase)
            true
        else
            false
        end
    end

end
