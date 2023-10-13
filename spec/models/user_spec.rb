require 'rails_helper'

RSpec.describe User, type: :model do
  # Tests will go here.
  subject do
    User.new(name: 'Tom', photo: '', bio: 'Teacher from Mexico',
             password: 'a123456', email: 'antonio@email.com')
  end

  before { subject.save }

  it 'name should be present' do
    subject.name = nil
    expect(subject).to_not be_valid
  end

  it 'bio should be present' do
    expect(subject.bio).to eq('Teacher from Mexico')
    expect(subject).to be_valid
  end

  it 'count of posts should be 0 by default ' do
    expect(subject.posts_counter).to eq(0)
  end

  it 'count of posts should be 2 by ' do
    Post.create(author: subject, title: '0 things you shoul know', text: 'First post')
    Post.create(author: subject, title: '1 thing you should know', text: 'Second post')
    expect(subject.posts_counter).to eq(2)
  end
end
