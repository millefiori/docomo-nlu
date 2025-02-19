# frozen_string_literal: true

RSpec.describe DocomoNlu::Management::V26::Entry do
  before do
    DocomoNlu::Management::V26::Base.access_token = DocomoNlu.config.admin_access_token
  end

  describe "#entry" do
    let(:project_id) { 48 }
    let(:bot_id) { "test_bot" }

    context "File Upload" do
      let(:entry) { DocomoNlu::Management::V26::Entry.new({ project_id: project_id, bot_id: bot_id }) }

      it "Valid file upload" do
        VCR.use_cassette("/V26/entry/save") do
          entry.file = File.new(File.join("spec", "fixtures", "management", "entry.zip"))
          expect(entry.save).to be_truthy
        end
      end
    end

    context "Delete entry" do
      let(:entry) { DocomoNlu::Management::V26::Entry.new({ project_id: project_id, bot_id: bot_id }) }

      it "use destroy" do
        VCR.use_cassette("/V26/entry/delete") do
          expect(entry.destroy.code).to eq "204"
        end
      end
    end
  end
end
