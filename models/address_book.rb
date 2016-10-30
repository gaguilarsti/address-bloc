# telling ruby to load the library named entry.rb
require_relative 'entry'

class AddressBook
  attr_reader :entries

  def initialize
    @entries = []
  end

  def add_entry(name, phone_number, email)
    #9 we create a variable to store the insertion index.
    index = 0
    entries.each do |entry|
      #10 we compare name with the name of the current entry.  if the name lexicographically proceeds entry.name, we've found the index to insert at.
      #Otherwise we increment index and continue comparing the other entries.
      if name <entry.name
        break
      end
      index += 1
    end
    #11we insert a new entry into entries using the calculated index.
  entries.insert(index, Entry.new(name, phone_number, email))
  end
end
