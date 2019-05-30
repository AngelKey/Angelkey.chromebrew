require 'package'

class Kbfsfuse < Package
  description 'Keybase filesystem for secure file storage'
  homepage 'https://keybase.io/docs/kbfs'
  version '4.0.0' # Bump as per https://github.com/keybase/client/releases

  depends_on 'keybase'
  depends_on 'go'

  # NOTE: In order for users to get the latest Keybase code securely, do not add binary_url.

  def self.install
    system "go get github.com/keybase/client/go/kbfs/kbfsfuse"
    system "cd ~/go/src/github.com/keybase/client/ && git checkout v#{version}"
    system "go build -o #{CREW_DEST_PREFIX}/bin/kbfsfuse -tags production github.com/keybase/client/go/kbfs/kbfsfuse"
  end

  def self.postinstall
    puts
    puts "Start by running `run_keybase -g`, provided by the `keybase` package."
    puts "Run `keybase config get -d -b mountdir` to find the path to your KBFS directory."
    puts
    puts "More information available at https://keybase.io/docs/linux-user-guide."
    puts
  end
end
