require 'rails_helper'

RSpec.describe Comment, type: :model do

  describe "#validations" do
    let(:user) { create :user }
    let(:question) { create :question, user: user }
    let(:answer) { create :answer, question: question, user: user }

    subject { comment }

    context "when question comment has all attributes" do
      let(:comment) { create :comment, post: question, user: user }
      it { is_expected.to be_valid }
    end

    context "when answer comment has all attributes" do
      let(:comment) { create :comment, post: answer, user: user }
      it { is_expected.to be_valid }
    end

    context "when question comment is missing user" do
      let(:comment) { create :comment, post: question, user: user }
      before { comment.update(user: nil) }
      it { is_expected.not_to be_valid }
    end

    context "when answer comment is missing user" do
      let(:comment) { create :comment, post: answer, user: user }
      before { comment.update(user: nil) }
      it { is_expected.not_to be_valid }
    end

    context "when question comment is missing associated post" do
      let(:comment) { create :comment, post: question, user: user }
      before { comment.update(post: nil) }
      it { is_expected.not_to be_valid }
    end

    context "when answer comment is missing associated post" do
      let(:comment) { create :comment, post: answer, user: user }
      before { comment.update(post: nil) }
      it { is_expected.not_to be_valid }
    end


    context "when question comment is missing body" do
      let(:comment) { create :comment, post: question, user: user }
      before { comment.update(body: nil) }
      it { is_expected.not_to be_valid }
    end

    context "when answer comment is missing body" do
      let(:comment) { create :comment, post: answer, user: user }
      before { comment.update(body: nil) }
      it { is_expected.not_to be_valid }
    end

  end
end
