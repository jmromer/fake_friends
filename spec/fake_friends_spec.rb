require 'spec_helper'
include FakeFriends

describe FakeFriend do

  describe "::gather" do
    context "with valid input" do
      let(:users){ FakeFriend.gather(5) }

      it "returns an array of FakeFriends" do
        expect(users).to be_an Array
        expect(users).to be_composed_of FakeFriend
      end

      it "returns the requested number of FakeFriends" do
        expect(users.count).to be 5
      end

      it "does not return duplicates" do
        expect(users.count).to be users.map(&:username).uniq.count
      end
    end

    context "with invalid input" do
      describe "with a negative number" do
        it { expect { FakeFriend.gather(-1) }.to raise_error(ArgumentError) }
      end
      describe "with too high a number" do
        it { expect { FakeFriend.gather(102) }.to raise_error(ArgumentError) }
      end
    end
  end


  describe "::find_by" do
    context "with valid input (by id)" do
      let(:user){ FakeFriend.find_by(id: 1) }

      it "returns a FakeFriend" do
        expect(user).to be_a FakeFriend
      end

      it "returns the correct FakeFriend" do
        expect(user.name).to eq("Visual Idiot")
      end
    end

    context "with valid input (by username)" do
      let(:user){ FakeFriend.find_by(username: 'idiot') }

      it "returns a FakeFriend" do
        expect(user).to be_a FakeFriend
      end

      it "returns the correct FakeFriend" do
        expect(user.name).to eq("Visual Idiot")
      end
    end

    context "with invalid input" do
      describe "with an invalid key" do
        it { expect { FakeFriend.find_by(age: 50) }.to raise_error(ArgumentError) }
      end
      describe "with an invalid id" do
        it { expect { FakeFriend.find_by(id: 102) }.to raise_error(ArgumentError) }
      end
      describe "with an invalid username" do
        it { expect { FakeFriend.find_by(username: "invalid_username") }.to raise_error(ArgumentError) }
      end
    end
  end
end
