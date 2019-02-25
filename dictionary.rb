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
end
