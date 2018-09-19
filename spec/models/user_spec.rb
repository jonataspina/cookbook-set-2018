require 'rails_helper'

RSpec.describe User, type: :model do
  
  it "should sum 2 values" do
    user = User.new
    expect(user.soma(1,2)).to eq 3
  end
end
