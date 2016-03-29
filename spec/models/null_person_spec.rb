require 'spec_helper'

describe NullPerson do
  let(:null_person) { NullPerson.new }

  specify 'is not an admin' do
    expect(null_person.admin?).to be false
  end
end