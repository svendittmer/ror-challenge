require 'rails_helper'

RSpec.describe Tag, type: :model do
  it 'validates presence of title' do
    @tag = Tag.new(title: nil)
    expect(@tag.save).to be false
    expect(@tag.errors[:title]).to include("can't be blank")
  end
end
