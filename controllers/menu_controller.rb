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
    puts "5 - View Entry Number n"
    puts "6 - Exit"
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
       system "clear"
       entry_n_submenu
       main_menu
     when 6
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
      # call entry_submenu to display a submenu for each entry.
      entry_submenu(entry)
    end

    system "clear"
    puts "End of entries"

  end

  def search_entries

  end

  def read_csv

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
    when "e"
      #display and edit the current entry
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

  def entry_n_submenu
    print "Enter the entry number you want to see: "
    selection = gets.chomp.to_i
    if (selection > @address_book.entries.count)
      puts "Sorry, #{selection} does not exist"
      #gives the user another chance to enter an entry record to look up
      entry_n_submenu
    else
      #this displays the selection the user entered (which is valid)
      puts @address_book.entries[selection]
      puts "Press enter to return to the main menu"
      gets.chomp
      system "clear"
    end
  end


end
