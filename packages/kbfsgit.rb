require 'package'

class Kbfsgit < Package
  description 'Keybase encrypted git repositories.'
  homepage 'https://keybase.io/docs/kbfs'
  version '4.0.0' # Bump as per https://github.com/keybase/client/releases

  depends_on 'kbfsfuse'
  depends_on 'go'

  # NOTE: In order for users to get the latest Keybase code securely, do not add binary_url.

  def self.install
    system "go get github.com/keybase/client/go/kbfs/kbfsgit/git-remote-keybase"
    system "cd ~/go/src/github.com/keybase/client/ && git checkout v#{version}"
    system "go build -o #{CREW_DEST_PREFIX}/bin/git-remote-keybase -tags production github.com/keybase/client/go/kbfs/kbfsgit/git-remote-keybase"
  end

  def self.postinstall
    puts
    puts "Start keybase with `run_keybase -g`, then `keybase login`, and `keybase git create <repo name>`."
    puts
  end
end
