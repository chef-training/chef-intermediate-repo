#
# Cookbook Name:: apache
# Spec:: default
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

require 'spec_helper'

describe 'apache::default' do
  context 'When all attributes are default, on an unspecified platform' do
    let(:chef_run) do
      runner = ChefSpec::ServerRunner.new
      runner.converge(described_recipe)
    end

    it 'converges successfully' do
      expect { chef_run }.to_not raise_error
    end

    it 'installs the necessary packages' do
      expect(chef_run).to install_package('httpd')
    end

    it 'starts the necessary service' do
      expect(chef_run).to start_service('httpd')
    end

    it 'enables the necessary service' do
      expect(chef_run).to enable_service('httpd')
    end

    describe 'for the default site' do
      it 'writes out a new home page' do
        expect(chef_run).to render_file('/var/www/html/index.html').with_content('<h1>Welcome home!</h1>')
      end
    end

    describe 'for the admin site' do
      it 'creates the directory' do
        expect(chef_run).to create_directory('/srv/apache/admins/html')
      end

      it 'creats the configuration' do
        expect(chef_run).to render_file('/etc/httpd/conf.d/admins.conf').with_content('Listen 8080')
      end

      it 'creates a new home page' do
        expect(chef_run).to render_file('/srv/apache/admins/html/index.html').with_content('<h1>Welcome admins!</h1>')
      end

    end
  end
end
