package provide vlc 0.0.1

namespace eval ::vlc {
    variable command
    switch [tk windowingsystem] {
        x11 {
            set path [exec which vlc]
            set command "$path -I rc --drawable-xid"
        }
        win32 {
            package require registry
            set path [registry get HKEY_LOCAL_MACHINE\\SOFTWARE\\VideoLAN\\VLC {}]
            set command "$path -I rc --drawable-hwnd"
        }
    }
}

proc ::vlc::open {parent} {
    variable command
    set fd [::open "| $command [winfo id $parent]" WRONLY]
    fconfigure $fd -buffering line
    bind $parent <Destroy> "::vlc::close $fd"
    return $fd
}

proc ::vlc::close {fd} {
    catch {
        puts $fd quit
        close $fd
    }
}
