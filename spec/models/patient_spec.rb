require 'rails_helper'

# Test suite for the Todo model
RSpec.describe Patient, type: :model do
  # Association test
  # ensure Todo model has a 1:m relationship with the Item model
  it { should belong_to(:user) }
  it { should have_many(:appointments).dependent(:destroy) }
  it { should have_many(:doctors).through(:appointments) }
end
