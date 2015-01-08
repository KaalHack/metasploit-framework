# -*- coding:binary -*-
require 'spec_helper'

require 'rex/java/serialization'
require 'rex/proto/rmi'
require 'msf/rmi/client'

describe Msf::Rmi::Client::Streams do
  subject(:mod) do
    mod = ::Msf::Exploit.new
    mod.extend ::Msf::Rmi::Client
    mod.send(:initialize)
    mod
  end

  let(:default_header) { "JRMI\x00\x02\x4b" }
  let(:header_opts) do
    {
      :version   => 1,
      :protocol  => Rex::Proto::Rmi::Model::MULTIPLEX_PROTOCOL
    }
  end
  let(:opts_header) { "JRMI\x00\x01\x4d" }

  let(:default_call) { "\x50\xac\xed\x00\x05" }
  let(:call_opts) do
    {
      :message_id => Rex::Proto::Rmi::Model::PING_MESSAGE
    }
  end
  let(:opts_call) { "\x52\xac\xed\x00\x05" }

  describe "#build_header" do
    context "when no opts" do
      it "creates a Rex::Proto::Rmi::Model::OutputHeader" do
        expect(mod.build_header).to be_a(Rex::Proto::Rmi::Model::OutputHeader)
      end

      it "creates a default OutputHeader" do
        expect(mod.build_header.encode).to eq(default_header)
      end
    end

    context "when opts" do
      it "creates a Rex::Proto::Rmi::Model::OutputHeader" do
        expect(mod.build_header(header_opts)).to be_a(Rex::Proto::Rmi::Model::OutputHeader)
      end

      it "creates a OutputHeader with data from opts" do
        expect(mod.build_header(header_opts).encode).to eq(opts_header)
      end
    end
  end

  describe "#build_call" do
    context "when no opts" do
      it "creates a Rex::Proto::Rmi::Model::Call" do
        expect(mod.build_call).to be_a(Rex::Proto::Rmi::Model::Call)
      end

      it "creates a default Call" do
        expect(mod.build_call.encode).to eq(default_call)
      end
    end

    context "when opts" do
      it "creates a Rex::Proto::Rmi::Model::Call" do
        expect(mod.build_call(call_opts)).to be_a(Rex::Proto::Rmi::Model::Call)
      end

      it "creates a OutputHeader with data from opts" do
        expect(mod.build_call(call_opts).encode).to eq(opts_call)
      end
    end
  end
end

