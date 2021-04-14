require 'rails_helper'

# Test suite for the Todo model
RSpec.describe Appointment, type: :model do
  # Association test
  # ensure Todo model has a 1:m relationship with the Item model
  it { should belong_to(:doctor) }
  it { should belong_to(:patient) }
  # Validation tests
  # ensure columns title and created_by are present before saving
  it { should validate_presence_of(:appointment_date_time_start) }
  it { should validate_presence_of(:appointment_date_time_end) }
  it { should validate_presence_of(:doctor_id) }
  it { should validate_presence_of(:patient_id) }
  #it { should validate_uniqueness_of(:appointment_date_time_start).scoped_to(:doctor_id).ignoring_case_sensitivity }
end
