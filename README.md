# devanshu_icicle_test

### Problem
1. The challenge was to convert a 10 digit number into possible word lists from the dictionary file provided.
2. The number will not contain digits 0 and 1. The words should be minimum 3 chars.

3. e.g. 6686787825 should return the following list :
  [["motor", "usual"], ["noun", "struck"], ["nouns", "truck"], ["nouns", "usual"], ["onto", "struck"], "motortruck"]

### Coming to the logic:

1. A hash map has been implemented to load the dictionary.txt file into a hash

2. There are two files: dictionary_management.rb and dictionary.rb. The first deals with dictionary management of creating a hash object and inserting each word of the file provided to it into that hash. It also checks whether a word is present in the dictionary or not.
The second file dictionary.rb has the core logic of returning all the words possible for a given 10 digit number.

3. The implementation is as follows: 
   * Firstly, a dictionary object is created and calls to load dictionary.txt file into a hash using load_file_to_hash method     of module DictionaryManagement.
   * Then the method return_all_words is called upon the object and a 10 digit number is passed as argument to it. This method calls other private class methods and module methods to find all possible words in the dictionary for that number.
   * To find the combinations of word lengths possible for a given minimum word length and max length of the number is calculated in method find_combinations. For minimum word length 3 and max digit length as 10 the combinations possible are [3,3,4], [3,4,3], [3,7], [4,3,3], [4,6], [5,5], [6,4], [7,3] and [10].
   * A loop runs for each combination iterating over each word length array, say [4,6].
   * The idea is to return all possible words possible from first 4 letters as one word and then next 6 letters as          another word using above example of [4,6] pair of word lengths.
   * For each such pair or triplet, the logic to find possible words is implemented in function get_combination_words of    Dictionary class.
   * It uses the method exists_in_dict in DictionaryManagement module to check whether a word exists in dictionary or not.
   * For each word length a cartesian product of individual word lenghths e.g. 4 and 6 is computed to find all possible     permutaions and combinations.
   * Similarly all such word length combinations are iterated and the words are collected and pushed into one array.
   * That array is retuned to the caller of method get_combination_words. If no words are possible then an empty array is   returned
 
4. For testing I have used rspec gem. The spec file contains test cases to check for numbers 6686787825 and 2282668687

### Run code:
```
ruby lib/dictionary.rb
```
The file contains a sample object of class Dictionary and calls get_combination_words by passing number 2282668687. The sample object implementation is commented. If comments are removed it would return an array of array of possible words:

```
[
            ["act", "boo", "tots"], ["act", "boo", "tour"], ["act", "con", "tots"], ["act", "con", "tour"], 
            ["act", "coo", "tots"], ["act", "coo", "tour"], ["bat", "boo", "tots"], ["bat", "boo", "tour"], 
            ["bat", "con", "tots"], ["bat", "con", "tour"], ["bat", "coo", "tots"], ["bat", "coo", "tour"], 
            ["cat", "boo", "tots"], ["cat", "boo", "tour"], ["cat", "con", "tots"], ["cat", "con", "tour"], 
            ["cat", "coo", "tots"], ["cat", "coo", "tour"], ["act", "boot", "mus"], ["act", "boot", "nus"], 
            ["act", "boot", "our"], ["act", "coot", "mus"], ["act", "coot", "nus"], ["act", "coot", "our"], 
            ["bat", "boot", "mus"], ["bat", "boot", "nus"], ["bat", "boot", "our"], ["bat", "coot", "mus"], 
            ["bat", "coot", "nus"], ["bat", "coot", "our"], ["cat", "boot", "mus"], ["cat", "boot", "nus"], 
            ["cat", "boot", "our"], ["cat", "coot", "mus"], ["cat", "coot", "nus"], ["cat", "coot", "our"], 
            ["act", "amounts"], ["act", "contour"], ["bat", "amounts"], ["bat", "contour"], ["cat", "amounts"], 
            ["cat", "contour"], ["acta", "mot", "mus"], ["acta", "mot", "nus"], ["acta", "mot", "our"], 
            ["acta", "not", "mus"], ["acta", "not", "nus"], ["acta", "not", "our"], ["acta", "oot", "mus"], 
            ["acta", "oot", "nus"], ["acta", "oot", "our"], ["acta", "mounts"], ["catamounts"]
        ]
```

### Run test cases:
```
rspec spec/dictionary_spec.rb
```
To run single test case:
```
rspec spec/dictionary_spec.rb -e "<test case string inside it block>"
```

1. The spec helper contains configuration to run the tests in documentation format.
2. It contains following test cases:
   * 2 valid inputs (is both number and contains digits 2-9). It returns an array of possible words of minimum size 3.
   * An Integer of number of digits not equal to 10, returns an empty array.
   * A string of numbers of length 10.
   * An input of any kind, e.g. invalid input of string, less than 10 digit number and valid input. All should
      return an array either empty or containing words.

### Benchmarking

For benchmarking, it is calculated by using unix's time utility:
As the script contains a defualt run of sample Dictionary object for finding possible words for the number: 2282668687

```
# dict = Dictionary.new
# list = dict.return_all_words(2282668687) #To execute for any other number replace the default number by custom number
```
Removing the comments and then running the commad:

```
time ruby lib/dictionary.rb
```

In my 2.2 GHz Intel Core i7 processor on macOS 10.13.6 following is the benchmark report:

```
real	0m0.475s
user	0m0.427s
sys	    0m0.042s
```
