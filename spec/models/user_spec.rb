require 'rails_helper'

RSpec.describe User, type: :model do
  #Tests will go here.
  subject { User.new(name: 'Tom', photo:'#', bio: 'Teacher from Mexico' ) }

  before { subject.save }

  it 'name should be present' do
    subject.name = nil
    expect(subject).to_not be_valid
  end

  it 'photo should be present' do
    subject.photo = nil
    expect(subject).to_not be_valid
  end

  it 'bio should be present' do
    subject.bio = nil
    expect(subject).to_not be_valid
  end
end