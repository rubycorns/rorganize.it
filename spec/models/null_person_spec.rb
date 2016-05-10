require 'spec_helper'

describe NullPerson do
  let(:null_person) { described_class.new }

  specify 'is not an admin' do
    expect(null_person.admin?).to be_falsey
  end
end