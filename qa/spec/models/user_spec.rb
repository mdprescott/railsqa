require 'rails_helper'

RSpec.describe User, type: :model do

  describe "#validations" do
    let(:user) { create :user }

    subject { user }

    context "when user has necessary attributes" do
      it { is_expected.to be_valid }
    end

    context "when user is missing name" do
      before { user.update(name: nil) }
      it { is_expected.not_to be_valid }
    end

    context "when user is missing email" do
      before { user.update(email: nil) }
      it { is_expected.not_to be_valid }
    end

    context "when user email is invalid" do
      before { user.update(email: "XYZ") }
      it { is_expected.not_to be_valid }
    end

  end
end
