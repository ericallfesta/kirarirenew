require 'spec_helper'

RSpec.configure { |c| c.filter_run_excluding mass_assignment: true }

module MassAssignment
  class List < ActiveRecord::Base
    self.table_name = :mass_assignment_lists
    has_many :items, class_name: 'MassAssignment::Item'
  end

  class Item < ActiveRecord::Base
    self.table_name = :mass_assignment_items
    belongs_to :list, class_name: 'MassAssignment::List'
    validates :name, presence: true
    validates :list, presence: true
  end
end

describe MassAssignment::Item, mass_assignment: true do
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
      create_table :mass_assignment_lists do |t|
        t.string :name
      end
      create_table :mass_assignment_items do |t|
        t.string :name
        t.integer :list_id
      end
    end
  end

  after :all do
    ActiveRecord::Base.transaction do
      drop_table :mass_assignment_lists
      drop_table :mass_assignment_items
    end
  end

  let(:raise_invalid) { raise_error(ActiveRecord::RecordInvalid) }

  describe "#create" do
    describe "with invalid parameters" do
      it { expect{ described_class.create!( {} ) }.to raise_invalid }
      it { expect{ described_class.create!( name: "sample" ) }.to raise_invalid }
      it { expect{ described_class.create!( name: "sample", list_id: 1000 ) }.to raise_invalid }
      # => Run: SELECT  `mass_assignment_lists`.* FROM `mass_assignment_lists`
      #         WHERE `mass_assignment_lists`.`id` = 1000
      #         ORDER BY `mass_assignment_lists`.`id` ASC LIMIT 1
    end

    describe "with valid parameters" do
      before :all do
        @list = MassAssignment::List.create( name: "SampleList" )
      end
      it do
        item = described_class.create( name: "sample", list_id: @list.id )
        expect(item).to be_a(described_class)
      end
    end
  end

  describe "#update_attributes" do
    before :all do
      @list1 = MassAssignment::List.create( name: "SampleList" )
      @list2 = MassAssignment::List.create( name: "SampleList" )
    end
    let(:item) { described_class.create( name: "sample", list_id: @list1.id ) }
    describe "with invalid parameters" do
      it { expect{ item.update_attributes!( name: "" ) }.to raise_invalid }
      it { expect{ item.update_attributes!( name: "sample", list_id: 1000 ) }.to raise_invalid }
      it { expect{ item.update_attributes!( list_id: @list2.id ) }.to_not raise_invalid }
      # => Should refuse to upadte list_id thourgh #update action by any controller
    end
  end
end
