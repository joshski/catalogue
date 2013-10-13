module ProductMatchers
  def have_product(text)
    self.have_css("#results li", text: text)
  end
end
World(ProductMatchers)

Given(/^there are products$/) do
  visit '/'
  page.should have_product("red skateboard")
  page.should have_product("green skateboard")
end

When(/^I search for products$/) do
  within "#search" do
    fill_in "keywords", with: "green"
    click_button "Search"
  end
end

Then(/^I should find matching products$/) do
  page.should have_product("green skateboard")
  page.should_not have_product("red skateboard")
end

When(/^I choose a product$/) do
  visit '/'
  page.click_on "green skateboard"
end

Then(/^I should see product details$/) do
  page.should have_css("h1", "green skateboard")
  page.title.should == "green skateboard"
end