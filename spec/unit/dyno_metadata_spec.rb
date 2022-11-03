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

  context "values from ENV" do
    test_env = {
      HEROKU_APP_ID:             SecureRandom.hex,
      HEROKU_APP_NAME:           SecureRandom.hex,
      DYNO:                      SecureRandom.hex,
      HEROKU_DYNO_ID:            SecureRandom.hex,
      HEROKU_RELEASE_CREATED_AT: SecureRandom.hex,
      HEROKU_RELEASE_VERSION:    SecureRandom.hex,
      HEROKU_SLUG_COMMIT:        SecureRandom.hex,
      HEROKU_SLUG_DESCRIPTION:   SecureRandom.hex,
    }

    around do |example|
      ClimateControl.modify(test_env) do
        example.run
      end
    end

    subject { described_class.to_h.tap { |hsh| hsh.delete(:short_commit) }.values }
    it { is_expected.to eq(test_env.values) }
  end

  context "alternative values from ENV" do
    let(:test_env) do
      {
        # https://fly.io/docs/reference/runtime-environment/
        FLY_APP_NAME:       SecureRandom.hex,
        FLY_ALLOC_ID:       "b996131a-5bae-215b-d0f1-2d75d1a8812b",
        FLY_REGION:         "ams",
        # Not documented, found with "fly ssh console"
        FLY_PUBLIC_IP:      "2605:4c40:197:7fd0:0:fa4a:e57b:1",
        FLY_VCPU_COUNT:     "1",
        FLY_VM_MEMORY_MB:   "256",
        # Alternatives
        RELEASE_CREATED_AT: "2022-11-03T21:00:00Z",
        RELEASE_VERSION:    "v123",
        RELEASE_COMMIT:     "e0efd36c5f678ace3c54694b7bf94db6ba4cb649",
      }
    end

    around do |example|
      ClimateControl.modify(test_env) do
        example.run
      end
    end

    describe ".app_name" do
      subject { described_class.app_name }
      it { is_expected.to eq(test_env.fetch(:FLY_APP_NAME)) }
    end

    describe ".dyno_id" do
      subject { described_class.dyno_id }
      it { is_expected.to eq(test_env.fetch(:FLY_ALLOC_ID)) }
    end

    describe ".release_created_at" do
      subject { described_class.release_created_at }
      it { is_expected.to eq(test_env.fetch(:RELEASE_CREATED_AT)) }
    end

    describe ".release_version" do
      subject { described_class.release_version }
      it { is_expected.to eq(test_env.fetch(:RELEASE_VERSION)) }
    end

    describe ".release_commit" do
      subject { described_class.release_commit }
      it { is_expected.to eq(test_env.fetch(:RELEASE_COMMIT)) }
    end

    describe ".commit" do
      subject { described_class.commit }
      it { is_expected.to eq(test_env.fetch(:RELEASE_COMMIT)) }
    end

    describe ".short_commit" do
      subject { described_class.short_commit }
      it { is_expected.to eq(test_env.fetch(:RELEASE_COMMIT)[0..6]) }
    end

    describe ".fly_alloc_id" do
      subject { described_class.fly_alloc_id }
      it { is_expected.to eq(test_env.fetch(:FLY_ALLOC_ID)) }
    end

    describe ".fly_region" do
      subject { described_class.fly_region }
      it { is_expected.to eq(test_env.fetch(:FLY_REGION)) }
    end

    describe ".fly_public_ip" do
      subject { described_class.fly_public_ip }
      it { is_expected.to eq(test_env.fetch(:FLY_PUBLIC_IP)) }
    end

    describe ".fly_vcpu_count" do
      subject { described_class.fly_vcpu_count }
      it { is_expected.to eq(test_env.fetch(:FLY_VCPU_COUNT)) }
    end

    describe ".fly_vm_memory_mb" do
      subject { described_class.fly_vm_memory_mb }
      it { is_expected.to eq(test_env.fetch(:FLY_VM_MEMORY_MB)) }
    end
  end

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
