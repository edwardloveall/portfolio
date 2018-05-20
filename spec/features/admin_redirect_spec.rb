require "rails_helper"

RSpec.describe "Admin redirect" do
  it "redirects the authenticated admin if there's a redirect url param" do
    user = create(:user)

    visit new_admin_micropost_path
    fill_in "Email", with: user.email
    fill_in "Password", with: user.password_digest
    click_on "Sign in"

    expect(current_url).to eq(new_admin_micropost_url)
  end

  context "when there are query parameters" do
    it "redirects to that path including those parameters" do
      user = create(:user)

      visit new_admin_micropost_path(foo: "bar")
      fill_in "Email", with: user.email
      fill_in "Password", with: user.password_digest
      click_on "Sign in"

      expect(current_url).to eq(new_admin_micropost_url(foo: "bar"))
    end
  end
end
