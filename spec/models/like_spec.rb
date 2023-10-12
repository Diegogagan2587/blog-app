require 'rails_helper'

RSpec.describe Like, type: :model do
  user = User.create(name: 'Tom', photo: '', bio: 'Teacher from Mexico')
  post = Post.create(author: user, title: 'How to gain a dollar', text: 'Get a job')
  subject { Like.new(user:, post:) }
  before { subject.save }

  it 'should be valid' do
    expect(subject).to be_valid
  end

  it 'should not be valid without a user' do
    subject.user = nil
    expect(subject).to_not be_valid
  end

  it 'should not be valid without a post' do
    subject.post = nil
    expect(subject).to_not be_valid
  end

  it 'should update likes_counter after save' do
    expect(post.likes_counter).to eq(1)
  end

  it 'should update likes_counter after destroy' do
    subject.destroy
    expect(post.likes_counter).to eq(0)
  end
end
