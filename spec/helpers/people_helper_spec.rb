require "rails_helper"
require "spec_helper"

describe PeopleHelper do
  let(:null_person) { NullPerson.new }
  let(:person) { build_stubbed :person }

  describe "#logged_in?(person)" do
    before { allow(helper).to receive(:current_person).and_return person }

    it "checks if current person is logged in by default" do
      expect(helper.logged_in?).to be true
    end

    it "checks if the current person is the comparable person" do
      expect(helper.logged_in?(person)).to be true
    end

    context "no one is logged in" do
      before { expect(helper).to receive(:current_person).and_return null_person }

      it "returns false" do
        expect(helper.logged_in?).to be false
      end
    end

    context "current person is not the comparable person" do
      let(:random) { build_stubbed :person }

      it "returns false" do
        expect(helper.logged_in?(random)).to be false
      end
    end
  end

  describe "#admin?" do
    before { allow(helper).to receive(:current_person).and_return person }

    it "determines that the current user is not an admin" do
      expect(helper.admin?).to be false
    end

    context "the current user is an admin" do
      let(:person) { build_stubbed :admin }
      it "returns true" do
        expect(helper.admin?).to be true
      end
    end
  end

  describe "#person_avatar(person)" do
    it "returns the user's avatar" do
      expect(helper.person_avatar(person).is_a?(String)).to be true
      expect(helper.person_avatar(person)).to match /person_profile_avatar.png/ # file paths will be different for everyone
    end

    context "user does not have avatar" do
      let(:no_picture) { build_stubbed :second_person }
      it "returns a default avatar" do
        expect(helper.person_avatar(no_picture)).to eql "<img alt=\"Avatar\" src=\"/avatar.png\" width=\"40\" height=\"40\" />"
      end
    end
  end

  describe "#profile_link(person)" do
    context "someone is logged in" do
      before { allow(helper).to receive(:current_person).and_return person }

      it "links to the person"do
        expect(helper.profile_link(person)).to match /a href/
        expect(helper.profile_link(person)).to match /Ruby Corn/
      end
    end

    context "no one is logged in" do
      before { allow(helper).to receive(:current_person).and_return null_person }

      it "does not link to the person"do
        expect(helper.profile_link(person)).to_not match /a href/
        expect(helper.profile_link(person)).to eql "Ruby Corn"
      end
    end
  end

  describe "#location_for?(person)" do
    it "returns true if the person has a location" do
      expect(helper.location_for?(person)).to be true
    end

    it "returns false when the city and country not present" do
      person.city = nil
      person.country = nil
      expect(helper.location_for?(person)).to be_falsy
    end
  end
end
