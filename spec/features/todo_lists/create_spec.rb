require 'spec_helper'

describe "creating todo lists" do
  it "redirects to the todo list index page on success" do
    visit '/todo_lists'
    click_link "New Todo list"
    expect(page).to have_content("New todo_list")
    fill_in "Title", with: "My todo list"
    fill_in 'Description', with: "my Description"
    click_button "Create Todo list"
    expect(page).to have_content("My todo list")
  end

  it "displays and error when the todo list has no title" do
    expect(TodoList.count).to eq(0)
    visit '/todo_lists'
    click_link "New Todo list"
    expect(page).to have_content("New todo_list")
    fill_in "Title", with: ""
    fill_in 'Description', with: "my Description"
    click_button "Create Todo list"
    expect(page).to have_content("error")
    expect(TodoList.count).to eq(0)

    visit '/todo_lists'
    expect(page).to_not have_content("my Description")

  end

  it "displays and error when the todo list has a title less than 3 characters" do
    expect(TodoList.count).to eq(0)
    visit '/todo_lists'
    click_link "New Todo list"
    expect(page).to have_content("New todo_list")
    fill_in "Title", with: "hi"
    fill_in 'Description', with: "my Description"
    click_button "Create Todo list"
    expect(page).to have_content("error")
    expect(TodoList.count).to eq(0)

    visit '/todo_lists'
    expect(page).to_not have_content("my Description")
  end

  it "displays and error when the todo list has no Description" do
    expect(TodoList.count).to eq(0)
    visit '/todo_lists'
    click_link "New Todo list"
    expect(page).to have_content("New todo_list")
    fill_in "Title", with: "Grocery list"
    fill_in 'Description', with: ""
    click_button "Create Todo list"
    expect(page).to have_content("error")
    expect(TodoList.count).to eq(0)

    visit '/todo_lists'
    expect(page).to_not have_content("Grocery list")

  end

  it "displays and error when the todo list has Description is less than 3 characters" do
    expect(TodoList.count).to eq(0)
    visit '/todo_lists'
    click_link "New Todo list"
    expect(page).to have_content("New todo_list")
    fill_in "Title", with: "Grocery list"
    fill_in 'Description', with: "my"
    click_button "Create Todo list"
    expect(page).to have_content("error")
    expect(TodoList.count).to eq(0)

    visit '/todo_lists'
    expect(page).to_not have_content("Grocery list")
  end
end
