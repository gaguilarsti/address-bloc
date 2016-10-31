# telling ruby to load the library named entry.rb
require_relative 'entry'
require "csv"

class AddressBook
  attr_reader :entries

  def initialize
    @entries = []
  end

  def add_entry(name, phone_number, email)
    # we create a variable to store the insertion index.
    index = 0
    entries.each do |entry|
      # we compare name with the name of the current entry.  if the name lexicographically proceeds entry.name, we've found the index to insert at.
      #Otherwise we increment index and continue comparing the other entries.
      if name < entry.name
        break
      end
      index += 1
    end
    #we insert a new entry into entries using the calculated index.
  entries.insert(index, Entry.new(name, phone_number, email))
  end

  # Define the method.  Methods starts by reading the file, using File.read.
  # The file will be in a CSV format.  Use the CSV class to parse the file.  The result is an object of type CSV::Table.
  def import_from_csv(file_name)
    csv_text = File.read(file_name)
    csv = CSV.parse(csv_text, headers: true, skip_blanks: true)
    # Iterate over the CSV::Table object's rows.  Then create a has for each row.
    # Convert each row_hash to an entry by using add_entry method.
    csv.each do |row|
      row_hash = row.to_hash
      add_entry(row_hash["name"], row_hash["phone_number"], row_hash["email"])
    end
  end

  def remove_entry(name, phone_number, email)
    delete_entry = nil

    @entries.each do |entry|
      if name == entry.name && phone_number == entry.phone_number && email == entry.email
        delete_entry = entry
      end
    end

    @entries.delete(delete_entry)

  end
end
