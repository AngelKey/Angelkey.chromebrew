require 'package'

class Keybase < Package
  description 'Keybase command-line client for secure communication and GPG'
  homepage 'https://keybase.io'
  version '4.0.0' # Bump as per https://github.com/keybase/client/releases

  depends_on 'go'

  # NOTE: In order for users to get the latest Keybase code securely, do not add binary_url.

  def self.install
    system "go get github.com/keybase/client/go/keybase"
    system "cd ~/go/src/github.com/keybase/client/ && git checkout v#{version}"
    system "go build -o #{CREW_DEST_PREFIX}/bin/keybase -tags production github.com/keybase/client/go/keybase"
    system "wget -O #{CREW_DEST_PREFIX}/bin/run_keybase https://github.com/keybase/client/blob/v#{version}/packaging/linux/run_keybase"
    system "chmod +x #{CREW_DEST_PREFIX}/bin/run_keybase"
  end

  def self.postinstall
    puts
    puts "Optionally, also install `kbfsfuse` and `kbfsgit` for the Keybase Filesystem and git integration."
    puts
    puts "Start keybase with `run_keybase -g`, then `keybase signup` or `keybase login`."
    puts "  (-g to avoid attempting to start the GUI, which is not supported on this platform)"
    puts
    puts "More information available at https://keybase.io/docs/linux-user-guide."
    puts
  end
end
