require 'spec_helper'

class MockModelForAfterCreate < ActiveRecord::Base
  after_create :raise_error

  def raise_error
    raise "AfterCreate"
  end
end

describe MockModelForAfterCreate do
  def table_exists?(name)
    ActiveRecord::Base.connection.table_exists? name
  end

  def create_table(name)
    if block_given? && ! table_exists?(name)
      ActiveRecord::Base.connection.create_table(name) { |t| yield(t) }
    end
  end

  def drop_table(name)
    if table_exists?(name)
      ActiveRecord::Base.connection.drop_table(name)
    end
  end

  before :all do
    ActiveRecord::Base.transaction do
      create_table :mock_model_for_after_creates do |t|
        t.string :name
      end
    end
  end

  after :all do
    ActiveRecord::Base.transaction do
      drop_table :mock_model_for_after_creates
    end
  end

  let(:target) { MockModelForAfterCreate.new }

  it "call raise_error callback after create" do
    expect{
      target.run_callbacks(:create)
    }.to raise_error /AfterCreate/
  end

  it "call raise_error callback after save model" do
    expect{
      target.save
    }.to raise_error /AfterCreate/
  end
end
