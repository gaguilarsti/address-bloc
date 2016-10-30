require_relative '../models/entry' #this tells ruby that we have a dependency on this file
# the standard first line of an RSpec test file.  Saying that the file is a spec file and we are testing 'Entry'
RSpec.describe Entry do
  # use 'describe' to give our test structure.  Here using it to say that the specs test the 'Entry' attributes
  describe "attributes" do
    #creating and using this helper method to define entry and remove the duplication below. See the first test where I just commented it out.
    let(:entry) { Entry.new('Ada Lovelace', '010.012.1815', 'augusta.king@lovelace.com') }

    # seperating individual tests using the 'it' method.  Each 'it' is a seperate test.
    it "responds to name" do
      #entry = Entry.new('Ada Lovelace', '010.012.1815', 'augusta.king@lovelace.com')
      #each test ends with at least one 'expect' method, used to declare the expectations for the test.
      expect(entry).to respond_to(:name)
    end

    it "reports its name" do
      expect(entry.name).to eq('Ada Lovelace')
    end

    it "responds to phone number" do
      expect(entry).to respond_to(:phone_number)
    end

    it "reports its phone number" do
      expect(entry.phone_number).to eq('010.012.1815')
    end

    it "responds to email" do
      expect(entry).to respond_to(:email)
    end

    it "reports its email" do
      expect(entry.email).to eq('augusta.king@lovelace.com')
    end
  end
#5 - we use a new describe block to seperate the to_s test from the initializer tests.
# The # in front of the to_s indicates that this is an instance method.
  describe "#to_s" do
  it "prints an entry as a string" do
    entry = Entry.new('Ada Lovelace', '010.012.1815', 'augusta.king@lovelace.com')
    expected_string = "Name: Ada Lovelace\nPhone Number: 010.012.1815\nEmail: augusta.king@lovelace.com"
    #6 - we use the eq to check that to_s returns a string equal to expected_string.
    expect(entry.to_s).to eq(expected_string)
    end
  end
end
