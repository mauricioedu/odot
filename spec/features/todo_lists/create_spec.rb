require "rails_helper"

describe "Creating todo lists" do 

	def create_todo_list(options={})
		options[:title] ||= "My todo list"
		options[:description] ||= "This is my todo list"
		
		visit "/todo_lists"
		click_link "New Todo list"
		expect(page).to have_content("New Todo List")

		fill_in "Title", with: options[:title]
		fill_in "Description", with: options[:description]
		click_button "Create Todo list"
	end




	it "redirects to the todo list index page on sucess" do
		create_todo_list

		expect(page).to have_content()
	end	

	it "displays an error when the todo list has no tittle" do
		expect(TodoList.count).to eq(0)
		
		create_todo_list title: ""

		expect(page).to have_content("error")
		expect(TodoList.count).to eq(0)
		visit "/todo_lists"
		expect(page).to_not have_content("Esta é minha guia hoje.")
	end

	it "displays an error when the todo list has a less than 3 characters" do
		expect(TodoList.count).to eq(0)
		
		create_todo_list title: "te"

		expect(page).to have_content("error")
		expect(TodoList.count).to eq(0)
		visit "/todo_lists"
		expect(page).to_not have_content("Esta é minha guia hoje.")
	end	

	it "displays an error when the todo list has no Description" do
		expect(TodoList.count).to eq(0)
		
		create_todo_list title: "Agora Vai", description: ""

		expect(page).to have_content("error")
		expect(TodoList.count).to eq(0)
		visit "/todo_lists"
		expect(page).to_not have_content("Agora vai.")
	end

	it "displays an error when the todo list has less than 5 characters" do
		expect(TodoList.count).to eq(0)
		
		create_todo_list title: "Agora Vai", description: "sss"

		expect(page).to have_content("error")
		expect(TodoList.count).to eq(0)
		visit "/todo_lists"
		expect(page).to_not have_content("Agora vai.")
	end	
end