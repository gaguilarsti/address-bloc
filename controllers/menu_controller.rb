# include address_book by using require_relative
require_relative '../models/address_book'

class MenuController
  attr_reader :address_book

  def initialize
    @address_book = AddressBook.new
  end

  def main_menu
    # display the main menu options to the command line.
    puts "Main Menu - #{address_book.entries.count} entries"
    puts "1 - View all entries"
    puts "2 - Create an entry"
    puts "3 - Search for an entry"
    puts "4 - Import entries from a CSV"
    puts "5 - Exit"
    print "Enter your selection: "

    # Retrieve user input from the command line using gets.
    selection = gets.to_i
    # use a case statement operator to determine the proper response to a user's input.
    case selection
     when 1
       system "clear"
       view_all_entries
       main_menu
     when 2
       system "clear"
       create_entry
       main_menu
     when 3
       system "clear"
       search_entries
       main_menu
     when 4
       system "clear"
       read_csv
       main_menu
     when 5
       puts "Good-bye!"
       # terminate the program using exit(0).  0 signals the program is exiting without an error.
       exit(0)
    # use an else to catch invlaid user input.
    else
      system "clear"
      puts "Sorry, that is not a valid input"
      main_menu
    end
  end
  # initially we stubbed out the methods called above in the case statements.
  def create_entry
    # clear the screen before displaying the create entry prompts.
    system "clear"
    puts "New AddressBloc Entry"
    # use print to prompt the user for each Entry attribute.
    print "Name: "
    name = gets.chomp
    print "Phone number: "
    phone = gets.chomp
    print "Email: "
    email = gets.chomp

    # add a new entry to address_book using add_entry to ensure the new entry is added in the proper order.
    address_book.add_entry(name, phone, email)

    system "clear"
    puts "New entry created"
  end

  def view_all_entries
    #iterate through all entries in AddressBook using each.
    address_book.entries.each do |entry|
      system "clear"
      puts entry.to_s
      # call entry_submenu to display a submeny for each entry.
      entry_submenu(entry)
    end

    system "clear"
    puts "End of entries"

  end

  def delete_entry(entry)
    address_book.entries.delete(entry)
    puts "#{entry.name} has been deleted"
  end

  def edit_entry(entry)
    #prompt the user to provide the updated values for the entry.
    print "Update name: "
    name = gets.chomp
    print "Updated phone number: "
    phone_number = gets.chomp
    print "Updated email: "
    email = gets.chomp
    #use !attribute.empty? to set attributes on the entry only if a valid attribute was read from the user input.
    entry.name = name if !name.empty?
    entry.phone_number = phone_number if !phone_number.empty?
    entry.email = email if !email.empty?
    system "clear"
    #print out the entry with the updated attributes.
    puts "Updated entry:"
    puts entry
  end

  def search_entries
    # get the name the user wants to search for.
    print "Search by name: "
    name = gets.chomp
    #call search on address_book which will return a match or nil.
    match = address_book.binary_search(name)
    system "clear"
    #check to see if a match was returned, if so, print to screen, if not, display message.
    if match
      puts match.to_s
      search_submenu(match)
    else
      puts "No match found for #{name}"
    end
  end

  def read_csv
    # prompt the user to enter the CSV file name
    print "Enter CSV file to import:"
    file_name = gets.chomp

    # check to see if the file is empty (e.g. has no records), if so - tell the user and go back to the main menu.
    if file_name.empty?
      system "clear"
      puts "No CSV file read"
      main_menu
    end

    # save the # of entries in the file into the entry_count variable. Confirm to the user how many will be added.
    # file is actually imported using import_from_csv method.
    # give the user notification of an invalid file added.
    begin
      entry_count = address_book.import_from_csv(file_name).count
      system "clear"
      puts "#{entry_count} new entries added from #{file_name}"
    rescue
      puts "#{file_name} is not a valid CSV file, please enter the name of a valid CSV file"
      read_csv
    end
  end

  def entry_submenu(entry)
    #display the submenu options
    puts "n - next entry"
    puts "d - delete entry"
    puts "e - edit this entry"
    puts "m - return to main menu"

    #chomp removes any trailing whitespace from an entry - e.g. an extra space bar entry.
    selection = gets.chomp

    case selection
      #when the user asks to see the next entry, we can do nothing and control will be returned to view_all_entries.
    when "n"
      #move to the next entry
    when "d"
      #delete the current entry
      delete_entry(entry)
    when "e"
      #display and edit the current entry
      edit_entry(entry)
      entry_submenu(entry)
    when "m"
      #return to main menu
      system "clear"
      main_menu
    else
      system "clear"
      puts "#{selection} is not a valid input"
      entry_submenu(entry)
    end
  end

  def search_submenu(entry)
    #print out submenu for an entry.
    puts "\nd - delete entry"
    puts "e - edit this entry"
    puts "m - return to main menu"
    # save the user input to selection.
    selection = gets.chomp

    #use a case statement to take specific action based on user input.
    case selection
      when "d"
        system "clear"
        delete_entry(entry)
        main_menu
      when "e"
        edit_entry(entry)
        system "clear"
        main_menu
      when "m"
        system "clear"
        main_menu
      else
        system "clear"
        puts "#{selection} is not a valid input"
        puts entry.to_s
        search_submenu(entry)
    end
  end

end
