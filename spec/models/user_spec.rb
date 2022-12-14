require 'rails_helper'

RSpec.describe User, type: :model do
  it { should validate_presence_of(:email) }
  it { should validate_uniqueness_of(:email) }

  it { should validate_presence_of(:user_id) }

  it { should validate_presence_of(:password) }
  it { should_not validate_length_of(:password).is_at_least(4)}
  it { should have_secure_password }
end
