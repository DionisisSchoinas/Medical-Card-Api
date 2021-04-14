require 'rails_helper'

# Test suite for the Todo model
RSpec.describe Doctor, type: :model do
  # Association test
  # ensure Todo model has a 1:m relationship with the Item model
  it { should belong_to(:user) }
  it { should have_one(:image).dependent(:destroy) }
  it { should have_many(:appointments).dependent(:destroy) }
  it { should have_many(:patients).through(:appointments) }
  # Validation tests
  # ensure columns title and created_by are present before saving
  it { should validate_presence_of(:speciality) }
  it { should validate_presence_of(:office_address) }
  it { should validate_presence_of(:phone) }
  it { should validate_presence_of(:email) }
  it { should validate_presence_of(:cost) }
end
