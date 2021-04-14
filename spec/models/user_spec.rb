require 'rails_helper'

# Test suite for the Todo model
RSpec.describe User, type: :model do
  it { should have_secure_password }
  # Association test
  # ensure Todo model has a 1:m relationship with the Item model
  it { should have_one(:doctor).dependent(:destroy) }
  it { should have_one(:patient).dependent(:destroy) }
  # Validation tests
  # ensure columns title and created_by are present before saving
  it { should validate_presence_of(:amka) }
  it { should validate_presence_of(:email) }
  it { should validate_presence_of(:password_digest) }
  it { should validate_presence_of(:fullname) }
  it { should validate_presence_of(:date_of_birth) }
  it { should validate_presence_of(:password_confirmation) }
  it { should validate_uniqueness_of(:amka) }
  it { should validate_uniqueness_of(:email) }
end
