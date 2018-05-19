require "rails_helper"

RSpec.describe "Admin redirect" do
  it "redirects the authenticated admin if there's a redirect url param" do
    user = create(:user)

    visit new_admin_micropost_path

    expect(current_url).to eq(
      new_admin_session_url(original_path: new_admin_micropost_path)
    )

    fill_in "Email", with: user.email
    fill_in "Password", with: user.password_digest
    click_on "Sign in"

    expect(current_url).to eq(new_admin_micropost_url)
  end
end
