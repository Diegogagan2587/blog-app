require 'rails_helper'

RSpec.describe User, type: :model do
  # Tests will go here.
  subject { User.new(name: 'Tom', photo: '', bio: 'Teacher from Mexico') }

  before { subject.save }

  it 'name should be present' do
    subject.name = nil
    expect(subject).to_not be_valid
  end

  it 'bio should be present' do
    subject.bio = nil
    expect(subject).to_not be_valid
  end

  it 'count of posts should be 0 by default ' do
    expect(subject.posts_counter).to eq(0)
  end

  it 'count of posts should be 2 by ' do
    user = User.create(name: 'Tom', photo: '', bio: 'Teacher from Mexico')
    Post.create(author: user, title: '0 things you shoul know', text: 'First post')
    Post.create(author: user, title: '1 thing you should know', text: 'Second post')
    expect(user.posts_counter).to eq(2)
  end
end