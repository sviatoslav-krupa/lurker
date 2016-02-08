require 'spec_helper'

describe Lurker::Json::Parser do
  let(:klass) { described_class }

  describe "#parse" do
    context "typed" do
      subject { described_class.typed.parse(payload) }

      context "with empty hash" do
        let(:payload) { {} }
        let(:expected) do
          {
            "additionalProperties" => false,
            "description" => "",
            "properties" => {},
            "required" => [],
            "type" => "object"
          }
        end

        specify { expect(subject.to_hash).to eq expected }
      end

      context "with several types" do
        let(:payload) { { "type" => ["string", "null"] } }

        let(:expected) do
          {
            "description" => "",
            "type" => ["string", "null"],
            "example" => ""
          }
        end

        specify { expect(subject.to_hash).to eq expected }
      end

      context "with items" do
        let(:payload) { { "items" => [] } }

        specify { expect(subject.to_hash).to include("type" => "array") }
      end
    end
  end
end
