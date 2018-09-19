require 'spec_helper'

describe Project do
  it { should validate_presence_of :title }
  it { is_expected.to belong_to(:user) }

  it { should have_many :tasks }
end
