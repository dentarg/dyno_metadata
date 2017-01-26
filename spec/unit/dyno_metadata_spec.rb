# frozen_string_literal: true

RSpec.describe DynoMetadata do
  let(:defaults) do
    {
      app_id:             "9daa2797-e49b-4624-932f-ec3f9688e3da",
      app_name:           "example-app",
      dyno:               "web.1",
      dyno_id:            "1vac4117-c29f-4312-521e-ba4d8638c1ac",
      release_created_at: "2015-04-02T18:00:42Z",
      release_version:    "v42",
      slug_commit:        "2c3a0b24069af49b3de35b8e8c26765c1dba9ff0",
      slug_description:   "Deploy 2c3a0b2",
      short_commit:       "2c3a0b2",
    }
  end

  subject { described_class.to_h }
  it { is_expected.to match(defaults) }

  describe ".commit" do
    subject { described_class.commit }
    it { is_expected.to eq(defaults.fetch(:slug_commit)) }
  end

  describe ".short_commit(12)" do
    subject { described_class.short_commit(12) }
    it { is_expected.to eq("2c3a0b24069a") }
  end

  describe "::VERSION" do
    subject { described_class::VERSION }
    it { is_expected.to match(/\d+.\d+.\d+/) }
  end

  describe ".fetch" do
    it "is private" do
      expect { described_class.fetch("FOO", "BAR") }.to raise_error(/private/)
    end
  end
end
