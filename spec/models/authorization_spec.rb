require "rails_helper"

RSpec.describe Authorization do
  describe "validations" do
    it { should validate_presence_of(:client_id) }
  end

  it "generates code and code expiration on creation" do
    auth = Authorization.create(client_id: "donkeyrentals.com")

    expect(auth.code).to be
    expect(auth.code_expires_at).to be
  end
end
