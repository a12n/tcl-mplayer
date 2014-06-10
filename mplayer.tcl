package provide mplayer 0.0.1

namespace eval ::mplayer {
    variable command {mplayer}
}

proc ::mplayer::start {parent} {
    variable command
    set fd [open "| $command -idle -really-quiet -slave -wid [winfo id $parent]" WRONLY]
    fconfigure $fd -buffering line
    bind $parent <Destroy> "::mplayer::quit $fd"
    return $fd
}

proc ::mplayer::quit {fd} {
    catch {
        puts $fd quit
        close $fd
    }
}
