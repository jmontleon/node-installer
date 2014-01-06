require 'spec_helper'

describe 'foreman::install' do
  let :default_facts do
    {
      :concat_basedir           => '/tmp',
      :interfaces               => '',
      :postgres_default_version => '8.4',
    }
  end

  context 'RedHat' do
    let :facts do
      default_facts.merge({
        :operatingsystem => 'RedHat',
        :osfamily        => 'RedHat',
      })
    end

    describe 'without parameters' do
      let :pre_condition do
        "class {'foreman':}"
      end

      it { should contain_class('foreman::database::postgresql') }

      it { should contain_foreman__rake('db:migrate') }
      it { should contain_foreman__rake('db:seed') }
    end
  end

  context 'on debian' do
    let :facts do
      default_facts.merge({
        :operatingsystem => 'Debian',
        :osfamily        => 'Debian',
      })
    end

    describe 'without parameters' do
      let :pre_condition do
        "class {'foreman':}"
      end

      it { should contain_class('foreman::database::postgresql') }

      it { should contain_foreman__rake('db:migrate') }
      it { should contain_foreman__rake('db:seed') }
    end
  end
end
