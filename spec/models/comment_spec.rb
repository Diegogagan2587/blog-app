require 'rails_helper'

RSpec.describe Comment, type: :model do
  user = User.create(name: 'Tom', photo: '', bio: 'Teacher from Mexico')
  post = Post.create(author: user, title: 'How to gain a dollar', text: 'Get a job')
  subject { Comment.new(post: , author: user, text: 'First comment') }

  before { subject.save }

  it 'should be valid' do
    expect(subject).to be_valid
  end

  it 'should not be valid without a post' do
    subject.post = nil
    expect(subject).to_not be_valid
  end

  it 'should not be valid without an author' do
    subject.author = nil
    expect(subject).to_not be_valid
  end

  it 'should not be valid without a text' do
    subject.text = nil
    expect(subject).to_not be_valid
  end

  it 'should update comments_counter after save' do
    expect(post.comments_counter).to eq(1)
  end

  it 'should update comments_counter after destroy' do
    subject.destroy
    expect(post.comments_counter).to eq(0)
  end

  it 'should return 5 most recent comments' do
    5.times do |i|
      Comment.create(post:, author: user, text: "Comment #{i}")
    end
    expect(post.five_recent_comments.count).to eq(5)
  end
end
