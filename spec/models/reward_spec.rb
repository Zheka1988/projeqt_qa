require 'rails_helper'

RSpec.describe Reward, type: :model do
  it { should belong_to :question }
  # it { should belong_to :user }

  it { should validate_presence_of :name }

  it 'have one attached files' do
    expect(Reward.new.file).to be_an_instance_of(ActiveStorage::Attached::One)
  end
end
