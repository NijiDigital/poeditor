require 'spec_helper'

describe Poesie::ContextFormatter do
  before do
    Poesie::Log::quiet = true
  end

  let(:terms) do
    JSON.parse(fixture('terms.json'))
  end

  module CurrentOS
    UNKNOW = 0
    ANDROID = 1
    IOS = 2
  end

  describe "Context.json" do
    it "generates proper context json file" do
      Dir.mktmpdir do |dir|
        path = dir + '/Context.json'
        stub_time()
        Poesie::ContextFormatter::write_context_json(terms, path, CurrentOS::ANDROID)
        expect(File.exist?(path)).to eq(true)
        expect(File.read(path)).to eq(fixture('Context.json'))
        Poesie::ContextFormatter::write_context_json(terms, path, CurrentOS::IOS)
        expect(File.exist?(path)).to eq(true)
        expect(File.read(path)).to eq(fixture('Context.json'))
      end
    end
  end
end
