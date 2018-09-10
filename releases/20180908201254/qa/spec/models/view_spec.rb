require 'rails_helper'

RSpec.describe View, type: :model do

  describe "#validations" do
    let(:user) { create :user }
    let(:question) { create :question, user: user }
    let(:answer) { create :answer, question: question, user: user }

    subject { view }

    context "when question view has all associated attributes" do
      let(:view) { create :view, post: question, user: user }
      it { is_expected.to be_valid }
    end

    context "when answer view has all associated attributes" do
      let(:view) { create :view, post: answer, user: user }
      it { is_expected.to be_valid }
    end

    context "when question view is missing associated user" do
      let(:view) { create :view, post: question, user: user }
      before { view.update(user: nil) }
      it { is_expected.not_to be_valid }
    end

    context "when answer view is missing associated user" do
      let(:view) { create :view, post: answer, user: user }
      before { view.update(user: nil) }
      it { is_expected.not_to be_valid }
    end

    context "when question view is missing associated post" do
      let(:view) { create :view, post: question, user: user }
      before { view.update(post: nil) }
      it { is_expected.not_to be_valid }
    end

    context "when answer view is missing associated post" do
      let(:view) { create :view, post: answer, user: user }
      before { view.update(post: nil) }
      it { is_expected.not_to be_valid }
    end
  end
end
