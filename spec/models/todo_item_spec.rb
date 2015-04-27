
require 'spec_helper'

RSpec.describe TodoItem, :type => :model do
    it {should belong_to(:todo_list)}

    describe "#completed?" do
      let!(:todo_item) {TodoItem.create(content: "Hello")}

      it "is false when completed_at is blank" do
        todo_item.completed_at = nil
        expect(todo_item.completed?).to eq(false)
      end

      it "return true when completed at not empty" do
        todo_item.completed_at = Time.now
        expect(todo_item.completed?).to eq(true)
      end

    end
end
