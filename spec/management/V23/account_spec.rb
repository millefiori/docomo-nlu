# frozen_string_literal: true

RSpec.describe DocomoNlu::Management::V23::Account do
  describe "#accounts" do
    it "Get all accounts" do
      VCR.use_cassette("/V23/account/index") do
        accounts = DocomoNlu::Management::V23::Account.all
        expect(accounts.first.accountId).not_to be_nil
      end
    end

    it "Create an account" do
      VCR.use_cassette("/V23/account/create") do
        account = DocomoNlu::Management::V23::Account.new(accountName: "test_account1", password: "testaccount20180821", authorization: 2, enable: true)
        account.save
        expect(account.accountId).not_to be_nil
      end
    end

    it "Get an account" do
      VCR.use_cassette("/V23/account/show") do
        account = DocomoNlu::Management::V23::Account.find(237)
        expect(account.id).not_to be_nil
      end
    end

    it "Update an account" do
      VCR.use_cassette("/V23/account/show") do
        account = DocomoNlu::Management::V23::Account.find(237)
        VCR.use_cassette("/V23/account/update") do
          account.accountName = "update account"
          account.description = "update account"
          expect(account.save).to eq true
        end
      end
    end

    it "Delete an account" do
      VCR.use_cassette("/V23/account/show") do
        account = DocomoNlu::Management::V23::Account.find(237)
        VCR.use_cassette("/V23/account/delete") do
          expect(account.destroy.code).to eq "204"
        end
      end
    end

    it "Count all accounts" do
      VCR.use_cassette("/V23/account/count") do
        expect(DocomoNlu::Management::V23::Account.count).to eq 454
      end
    end
  end
end
