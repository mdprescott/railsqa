require 'rails_helper'

RSpec.describe Question, type: :model do

  describe "#accept_answer" do
    let(:user) { create :user }
    let(:question) { create :question, user: user }
    let(:answer) { create :answer, question: question, user: user }

    subject { question.accept_answer(answer) }
    it "method assigns answer id as accepted_answer_id" do
      expect(question.has_accepted_answer?).to be true
      expect(answer.accepted?).to be true
      expect(question.accepted_answer).to eq answer
      subject
    end

  end

  describe "#validations" do
    let(:user) { create :user }
    let(:question) { create :question, user: user }

    subject { question }

    context "when question has associated user, title, body" do
      it { is_expected.to be_valid }
    end

    context "when question is missing associated user" do
      before { question.update(user: nil) }
      it { is_expected.not_to be_valid }
    end

    context "when question is missing title" do
      before { question.update(title: nil) }
      it { is_expected.not_to be_valid }
    end

    context "when question is missing body" do
      before { question.update(body: nil) }
      it { is_expected.not_to be_valid }
    end



  end
end
