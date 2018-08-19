require 'rails_helper'

RSpec.describe Answer, type: :model do

  describe "#validations" do
    let(:user) { create :user }
    let(:question) { create :question, user: user }
    let(:answer) { create :answer, user: user, question: question }

    subject { answer }

    context "when answer has associated user, associated question, body" do
      it { is_expected.to be_valid }
    end

    context "when answer is missing associated user" do
      before { answer.update(user: nil) }
      it { is_expected.not_to be_valid }
    end

    context "when answer is missing associated question" do
      before { answer.update(question: nil) }
      it { is_expected.not_to be_valid }
    end

    context "when answer is missing body" do
      before { answer.update(body: nil) }
      it { is_expected.not_to be_valid }
    end

  end
end
