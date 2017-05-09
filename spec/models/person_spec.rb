# == Schema Information
#
# Table name: people
#
#  id                     :integer          not null, primary key
#  first_name             :string(255)
#  last_name              :string(255)
#  email                  :string(255)      default(""), not null
#  group_id               :integer
#  created_at             :datetime
#  updated_at             :datetime
#  encrypted_password     :string(255)      default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#  picture                :string(255)
#  twitter                :string(255)
#  working_on             :text
#  workshop_coach         :boolean
#

require 'spec_helper'

describe Person, vcr: {cassette_name: 'create_group'} do

  it { is_expected.to have_many(:groups) }
  it { is_expected.to have_many(:memberships) }
  it { is_expected.to have_many(:topics) }
  it { is_expected.to have_many(:posts) }

  it { is_expected.to validate_presence_of(:first_name) }

  let(:person)        { create(:person) }
  let!(:group)        { create(:group) }
  let!(:second_group) { create(:second_group)}

  subject { person }

  it 'has the correct full name' do
    expect(subject.full_name).to eq 'Ruby Corn'
  end

  it 'has no group' do
    expect(subject.has_group?).to be_falsey
  end

  it 'is a minimal valid user' do
    expect(subject).to be_valid
  end

  describe 'an invalid person' do
    before { subject.first_name = '' }

    it { is_expected.not_to be_valid }
  end

  describe '#has_group?' do
    it 'is not a member of a group' do
      expect(subject.has_group?).to be_falsey
    end

    describe 'joining a group' do
      before { subject.join!(group, {}) }

      it 'makes a person a member of that group' do
        expect(subject.has_group?).to be_truthy
      end
    end
  end

  describe '#name=' do
    it 'displays the first and last name' do
      subject.name = 'Ruby Corn'
      expect(subject.name).to eq 'Ruby Corn'
    end

    it 'does not double the name if there is only one' do
      subject.name = 'Ruby'

      expect(subject.name).to eq 'Ruby'
      expect(subject.first_name).to eq 'Ruby'
      expect(subject.last_name).to eq nil
    end

    it 'allows for three names' do
      subject.name = 'Ruby Fabulous Rubycorn'

      expect(subject.name).to eq 'Ruby Fabulous Rubycorn'
      expect(subject.first_name).to eq 'Ruby'
      expect(subject.last_name).to eq 'Fabulous Rubycorn'
    end

    it 'allows for many many names' do
      subject.name = 'Ruby Fabulous Rubycorn What Does It Even Mean'

      expect(subject.name).to eq 'Ruby Fabulous Rubycorn What Does It Even Mean'
      expect(subject.first_name).to eq 'Ruby'
      expect(subject.last_name).to eq 'Fabulous Rubycorn What Does It Even Mean'
    end
  end

  describe '#join!' do
    before { subject.join!(group, {}) }

    it 'puts the person in the correct group' do
      expect(subject.memberships.first.group_id).to eq group.id
    end

    describe 'joining a second group' do
      before { subject.join!(second_group, {}) }

      it 'allows the person to also be a member of the second group' do
        expect(subject.member_of?(second_group)).to be_truthy
      end

      it 'allows the person to be a member of both groups' do
        expect(subject.memberships.count).to eq 2
      end
    end
  end

  describe '#member_of?' do
    before { subject.join!(group, {}) }

    it 'checks to see if they are a member of a group' do
      expect(subject.member_of?(group)).to be_truthy
    end
  end

  describe 'willing to coach workshop checkbox' do
    it 'indicates the Person wants to coach workshops' do
      person.workshop_coach = true
      expect(person.workshop_coach).to be_truthy
    end

    it 'indicates the Person does not want to coach workshops' do
      expect(person.workshop_coach).to be_falsey
    end
  end

  describe '.workshop_coach' do
    subject { described_class.workshop_coach }
    let!(:workshop_coach) { create :workshop_coach }
    let!(:second_person)  { create :second_person }

    it 'lists only workshop coach' do
      expect(subject).to contain_exactly workshop_coach
    end
  end

  describe '.order_by_name' do
    let!(:person) { create :person }
    let!(:second_person) { create :second_person }
    let!(:third_person)  { create :person, first_name: 'lolo', last_name: 'lowercase' }
    let!(:fourth_person) { create :person, first_name: 'Anna', last_name: 'Analog' }
    it 'returns an ordered names list ' do
      expect((Person.order_by_name).map(&:name)).to eq [ 'Anna Analog', 'lolo lowercase', 'Ruby Corn', 'Tarn Shoes']
    end
  end

  describe '.order_by_name, .workshop_coach' do
    subject { described_class.workshop_coach.order_by_name }
    let!(:workshop_coach) { create :workshop_coach }
    let!(:second_workshop_coach)  { create :workshop_coach, first_name: 'Zlatan', last_name: 'Zukanovic'  }
    let!(:third_workshop_coach)  { create :workshop_coach, first_name: 'lolo', last_name: 'lowercase' }
    context 'combine scopes' do
      it 'lists in alphabetical order when lowercased name is present' do
        expect(subject.map(&:name)).to eq ['Corny Chocolate-Bar', 'lolo lowercase', 'Zlatan Zukanovic']
      end
    end
  end

  describe '.admin' do
    subject { described_class.admin }

    let!(:admin) { create(:admin) }
    let!(:user)  { create(:person) }

    it 'lists all the admins' do
      expect(subject).to contain_exactly(admin)
    end
  end

  describe '.visible_locations_for & .filtered_by_visibility' do
    let!(:non_public_person) { create :person, country: 'DE', city: 'Berlin', non_public: true }
    let!(:public_person)     { create :person, country: 'CA', city: 'Vancouver', non_public: false }

    context '.visible_locations_for' do
      it 'displays the locations for all users when someone is logged in' do
        expect(Person.visible_locations_for(:countries, true)).to eql ['DE', 'CA']
        expect(Person.visible_locations_for(:cities, true)).to eql ['Berlin', 'Vancouver']
      end

      it 'displays only the locations of public users when no one is logged in' do
        expect(Person.visible_locations_for(:countries, false)).to eql ['CA']
        expect(Person.visible_locations_for(:cities, false)).to eql ['Vancouver']
      end
    end

    context '.filtered_by_visibility' do
      it 'displays all people when someone is logged in' do
        expect(Person.filtered_by_visibility(true)).to match_array [non_public_person, public_person]
      end

      it 'only displays public people when no one is logged in' do
        expect(Person.filtered_by_visibility(false)).to match_array [public_person]
      end
    end
  end

  describe '.from_omniauth' do
    let(:auth)        { double "auth", provider: 'github', uid: '123456', info: auth_info }
    let(:auth_info)   { double "auth_info", email: 'buffy.summers@example.com', name: 'Buffy Summers', image: nil }
    let(:auth_person) { Person.from_omniauth(auth) }

    context 'where a does not already exist' do
      specify do
        expect(auth_person.email).to eq "buffy.summers@example.com"
        expect(auth_person.name).to eq 'Buffy Summers'
        expect(auth_person.uid).to eq '123456'
        expect(auth_person.provider).to eq 'github'
      end
    end

    context 'where a person already exists' do
      let!(:person) { create :person, provider: 'github', uid: 123456, first_name: 'Buffy', last_name: 'Summers' }

      specify do
        expect(auth_person).to eq person
      end
    end
  end

  describe '#merge_with_github!' do
    let(:github_person) { build :person, provider: 'github', uid: '123456' }
    let(:person) { build :second_person }

    it 'merges the rorganize person with a github person' do
      person.merge_with_github!(github_person)
      expect(person.reload.provider).to eq 'github'
      expect(person.reload.uid).to eq '123456'
    end
  end

  context 'filtering by city or country' do
    let!(:person) { create :person }
    let!(:second_person) { create :second_person }

    describe '.cities' do
      it 'returns a list of cities' do
        expect(Person.cities).to eq ['Berlin', 'Hamburg']
      end
    end

    describe '.countries' do
      it 'returns a list of countries' do
        expect(Person.countries).to eq ['DE']
      end
    end
  end
end
