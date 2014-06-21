#!/usr/bin/expect -f
set timeout 9
set hostname [lindex $argv 0]
set password [lindex $argv 1]

spawn sh -c "ssh-copy-id -i /home/picosafe/.ssh/id_rsa.pub  $hostname"

expect {
    "assword: " {
        send "$password\n"
        expect {
            "again."     { exit 1 }
            "expecting." { }
            timeout      { exit 1 }
        }
    }
    "(yes/no)? " {
        send "yes\n"
        expect {
            "assword: " {
                send "$password\n"
                expect {
                    "again."     { exit 1 }
                    "expecting." { }
                    timeout      { exit 1 }
                }
            }
        }
    }
}