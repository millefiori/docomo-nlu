# frozen_string_literal: true

RSpec.describe DocomoNlu::Management::V26::Log do
  before do
    DocomoNlu::Management::V26::Base.access_token = DocomoNlu.config.admin_access_token
  end

  describe "#logs" do
    let(:project_id) { 176 }
    let(:params) { { details: [{ operation: "", target: "input", query: "Hello" }]} }
    let(:log) { DocomoNlu::Management::Log.new(project_id: project_id) }

    it "Get count all logs" do
      VCR.use_cassette("/V26/log/count/all") do
        expect(log.count).not_to be_nil
      end
    end

    it "Get count using query" do
      VCR.use_cassette("/V26/log/count/query") do
        expect(log.count(params)).not_to be_nil
      end
    end

    it "Get all logs" do
      VCR.use_cassette("/V26/log/all") do
        expect(log.download).not_to be_nil
      end
    end

    it "Get logs using query" do
      VCR.use_cassette("/V26/log/query") do
        expect(log.download(params)).not_to be_nil
      end
    end
  end
end
