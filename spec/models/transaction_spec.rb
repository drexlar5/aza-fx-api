require 'rails_helper'

RSpec.describe Transaction, type: :model do
  it { should validate_presence_of(:user_id) }
  
  it { should validate_presence_of(:input_amount) }
  it { should validate_numericality_of(:input_amount) }
  it { should validate_presence_of(:input_currency) }
  it { should allow_values('USD').for(:input_currency)}
  it { should validate_length_of(:input_currency).is_equal_to(3)}
  
  it { should validate_presence_of(:transaction_id) }
  it { should validate_uniqueness_of(:transaction_id) }
  
  it { should validate_presence_of(:output_amount) }
  it { should validate_numericality_of(:output_amount) }
  it { should validate_presence_of(:output_currency) }
  it { should allow_values('NGN').for(:output_currency)}
  it { should validate_length_of(:output_currency).is_equal_to(3)}
end
