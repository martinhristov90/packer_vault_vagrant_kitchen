control 'vault_install' do
    title 'vault_install'
    desc 'Checks if vault is installed'
    
    describe service('vault') do
        it { should be_enabled }
        it { should be_running }
    end
end