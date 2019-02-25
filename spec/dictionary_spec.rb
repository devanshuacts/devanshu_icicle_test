require 'rspec'
require '../dictionary.rb'

describe Dictionary do
    before(:all) do
        @dictionary = Dictionary.new
        @dictionary.load_file_to_hash
        @list1 = [[
            "mot", "opt", "puck"], ["mot", "opt", "ruck"], ["mot", "opt", "suck"], ["mot", "ort", "puck"], 
            ["mot", "ort", "ruck"], ["mot", "ort", "suck"], ["not", "opt", "puck"], ["not", "opt", "ruck"], 
            ["not", "opt", "suck"], ["not", "ort", "puck"], ["not", "ort", "ruck"], ["not", "ort", "suck"], 
            ["oot", "opt", "puck"], ["oot", "opt", "ruck"], ["oot", "opt", "suck"], ["oot", "ort", "puck"], 
            ["oot", "ort", "ruck"], ["oot", "ort", "suck"], ["mot", "opts", "taj"], ["mot", "opus", "taj"], 
            ["mot", "orts", "taj"], ["not", "opts", "taj"], ["not", "opus", "taj"], ["not", "orts", "taj"], 
            ["oot", "opts", "taj"], ["oot", "opus", "taj"], ["oot", "orts", "taj"], ["noun", "pup", "taj"], 
            ["noun", "pur", "taj"], ["noun", "pus", "taj"], ["noun", "sup", "taj"], ["noun", "suq", "taj"], 
            ["onto", "pup", "taj"], ["onto", "pur", "taj"], ["onto", "pus", "taj"], ["onto", "sup", "taj"], 
            ["onto", "suq", "taj"], ["noun", "struck"], ["onto", "struck"], ["motor", "truck"], ["motor", "usual"], 
            ["nouns", "truck"], ["nouns", "usual"], ["motortruck"]
        ]
        @list2 = [
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
    end

    describe "initialized in before(:all)" do
        context "when phone number is Integer and of 10 digits" do
            it "should return a list containing words in list1 for number 6686787825" do
                mylist = @dictionary.return_all_words(6686787825)
                expect(mylist).to eq(@list1)
            end

            it "should return a list containing words in list2 for number 2282668687" do
                mylist = @dictionary.return_all_words(2282668687)
                expect(mylist).to eq(@list2)
            end
        end
    end
end