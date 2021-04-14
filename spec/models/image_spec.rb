require 'rails_helper'

# Test suite for the Todo model
RSpec.describe Image, type: :model do
  # Association test
  # ensure Todo model has a 1:m relationship with the Item model
  it { should belong_to(:doctor) }
  # Validation tests
  # ensure columns title and created_by are present before saving
  it { should validate_presence_of(:image_base64) }
end
