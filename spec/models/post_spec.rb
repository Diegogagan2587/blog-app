require 'rails_helper'

RSpec.describe Post, type: :model do
  user = User.create(name: 'Tom', photo: '', bio: 'Teacher from Mexico')
  user_two = User.create(name: 'Tim', photo: '', bio: 'Teacher from Venezuela')
  subject { Post.new(author: user, title: 'How to gain a dollar', text: 'Get a job') }
  before { subject.save }

  it 'title should be present' do
    subject.title = nil
    expect(subject).to_not be_valid
  end

  it 'title should not exceed 250 characters' do
    subject.title = 'a' * 251
    expect(subject).to_not be_valid
  end

  it 'comments_counter should be 0 by default' do
    expect(subject.comments_counter).to eq(0)
  end

  it 'comments_couter should be equal to 2' do
    Comment.create(post: subject, author: user, text: 'First comment')
    Comment.create(post: subject, author: user, text: 'Second comment')
    expect(subject.comments_counter).to eq(2)
  end

  it 'likes_counter should be 0 by default' do
    expect(subject.likes_counter).to eq(0)
  end

  it 'likes_counter should be equal to 2' do
    Like.create(user:, post: subject)
    Like.create(user: user_two, post: subject)
    expect(subject.likes_counter).to eq(2)
  end
end