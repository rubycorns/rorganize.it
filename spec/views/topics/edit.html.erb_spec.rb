require 'spec_helper'

describe "topics/edit" do
  before(:each) do
    @topic = assign(:topic, stub_model(Topic,
      :user_name => "MyString",
      :body => "MyText",
      :group_id => 1
    ))
  end

  it "renders the edit topic form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", topic_path(@topic), "post" do
      assert_select "input#topic_user_name[name=?]", "topic[user_name]"
      assert_select "textarea#topic_body[name=?]", "topic[body]"
      assert_select "input#topic_group_id[name=?]", "topic[group_id]"
    end
  end
end
