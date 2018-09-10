require 'rails_helper'

RSpec.describe Vote, type: :model do

  describe "#validations" do
    let(:user) { create :user }
    let(:question) { create :question, user: user }
    let(:answer) { create :answer, question: question, user: user }

    subject { vote }

    context "when question vote has all associated attributes" do
      let(:vote) { create :vote, post: question, user: user }
      it { is_expected.to be_valid }
    end

    context "when answer vote has all associated attributes" do
      let(:vote) { create :vote, post: question, user: user }
      it { is_expected.to be_valid }
    end

    context "when question vote is missing associated user" do
      let(:vote) { create :vote, post: question, user: user }
      before { vote.update(user: nil) }
      it { is_expected.not_to be_valid }
    end

    context "when answer vote is missing associated user" do
      let(:vote) { create :vote, post: answer, user: user }
      before { vote.update(user: nil) }
      it { is_expected.not_to be_valid }
    end

    context "when question vote is missing associated post" do
      let(:vote) { create :vote, post: question, user: user }
      before { vote.update(post: nil) }
      it { is_expected.not_to be_valid }
    end

    context "when answer vote is missing associated post" do
      let(:vote) { create :vote, post: answer, user: user }
      before { vote.update(post: nil) }
      it { is_expected.not_to be_valid }
    end

    context "when question vote is missing associated vote status" do
      let(:vote) { create :vote, post: question, user: user }
      before { vote.update(upvote: nil) }
      it { is_expected.not_to be_valid }
    end

    context "when answer vote is missing associated vote status" do
      let(:vote) { create :vote, post: answer, user: user }
      before { vote.update(upvote: nil) }
      it { is_expected.not_to be_valid }
    end
  end
end
