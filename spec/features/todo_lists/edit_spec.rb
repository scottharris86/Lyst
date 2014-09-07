require 'spec_helper'

describe "editing a todo list" do

  let!(:todo_list) {TodoList.create(title: "Groceries", description: "Grocery List")}

  def update_todo_list(options={})
    options[:title] ||= "My todo list"
    options[:description] ||="This is my todo list"
    visit '/todo_lists'

    todo_list = options[:todo_list]

    within "#todo_list_#{todo_list.id}" do
      click_link 'Edit'
    end

    fill_in 'Title', with: options[:title]
    fill_in 'Description', with: options[:description]
    click_button "Update Todo list"
  end
  it "updates a todo list successfuly with the correct information" do
    update_todo_list todo_list: todo_list, title: "New Title", description: "New Description"

    todo_list.reload

    expect(page).to have_content("Todo list was successfully updated.")
    expect(todo_list.title).to eq("New Title")
    expect(todo_list.description).to eq("New Description")
  end
  it "displays error on no title" do
    update_todo_list todo_list: todo_list, title: "", description: "New Description"
    todo_list.reload
    expect(page).to have_content("error")
  end
  it "displays an error on to short of a title" do
    update_todo_list todo_list: todo_list, title: "hi", description: "New Description"
    todo_list.reload
    expect(page).to have_content("error")
  end
  it "displays an error on no description" do
    update_todo_list todo_list: todo_list, title: "Work List", description: ""
    todo_list.reload
    expect(page).to have_content("error")
  end
  it "displays an error on to short of a description" do
    update_todo_list todo_list: todo_list, title: "Work List", description: "her"
    todo_list.reload
    expect(page).to have_content('error')
  end
end
