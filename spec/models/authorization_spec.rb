require "rails_helper"

RSpec.describe Authorization do
  describe "validations" do
    it { should validate_presence_of(:client_id) }
  end

  it "generates code and code expiration on creation" do
    auth = create(:authorization, code: nil, code_expires_at: nil)

    expect(auth.code).to be
    expect(auth.code_expires_at).to be
  end

  describe "generate_token!" do
    it "generates a token and token_expires_at" do
      auth = create(:authorization)

      auth.generate_token!
      auth.reload

      expect(auth.token).to be
      expect(auth.token_expires_at).to be
    end
  end

  describe ".not_token_expired" do
    it "returns authorizations where tokens aren't expired" do
      valid = create(:authorization, token_expires_at: 1.year.from_now)
      expired = create(:authorization, token_expires_at: 1.year.ago)

      results = Authorization.not_token_expired

      expect(results).to include(valid)
      expect(results).not_to include(expired)
    end
  end

  describe ".not_code_expired" do
    it "returns authorizations where tokens aren't expired" do
      valid = create(:authorization)
      expired = create(:authorization)
      expired.update(code_expires_at: 1.day.ago)

      results = Authorization.not_code_expired

      expect(results).to include(valid)
      expect(results).not_to include(expired)
    end
  end
end
