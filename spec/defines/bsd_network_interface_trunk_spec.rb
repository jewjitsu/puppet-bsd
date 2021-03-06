require 'spec_helper'

describe "bsd::network::interface::trunk" do
  context "on OpenBSD" do
    let(:facts) { {:kernel => 'OpenBSD'} }
    let(:title) { 'trunk0' }
    context " a minimal example" do
      let(:params) { {:interface => ['em0', 'em1']} }
      it do
        should contain_bsd__network__interface('trunk0')
        should contain_file('/etc/hostname.trunk0').with_content(/trunkproto lacp trunkport em0 trunkport em1\nup\n/)
      end
    end

    context "a medium example" do
      let(:params) { {:interface => ['em0', 'em1'], :description => "TestNet"} }
      it do
        should contain_bsd__network__interface('trunk0')
        should contain_file('/etc/hostname.trunk0').with_content(/description \"TestNet\"\ntrunkproto lacp trunkport em0 trunkport em1\nup\n/)
      end
    end
  end

  context "when a bad name is used" do
    let(:facts) { {:kernel => 'OpenBSD'} }
    let(:title) { 'notcorrect0' }
    let(:params) { {:interface => ['em0', 'em1'], :description => "TestNet"} }
    it do
      expect {
          should contain_bsd__network__interface__trunk('notcorrect0')
      }.to raise_error(Puppet::Error, /does not match/)
    end
  end
end
