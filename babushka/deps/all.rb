dep 'Spotify.app'
dep 'tree.bin'

dep 'homebrew tap', :tap_name do
  met? {
    shell!('brew tap').split.include? tap_name
  }
  meet {
    log_shell "Tapping homebrew tap '#{tap_name}'", "brew tap '#{tap_name}'"
  }
end

dep 'thoughtbot-repo' do
  requires {
    on :brew, 'homebrew tap'.with('thoughtbot/formulae')
    otherwise 'software-properties-common.bin', 'ppa'.with('ppa:martin-frost/thoughtbot-rcm')
  }
end

dep 'software-properties-common.bin' do
  provides 'add-apt-repository'
end

dep 'rcm', template: 'bin' do
  provides 'rcup', 'lsrc'
  requires_when_unmet 'thoughtbot-repo'
end

dep 'cli' do
  requires 'babushka'
  requires Babushka.host.pkg_helper.manager_dep

  requires 'rcm'
  requires 'tree.bin'
end

dep 'all' do
  requires 'cli'
  requires 'benhoskings:Google Chrome.app'
  requires 'Spotify.app'
end
