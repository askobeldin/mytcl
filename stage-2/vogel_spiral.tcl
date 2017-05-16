# http://wiki.tcl.tk/29258
#
# vogel-spiral.tcl
# Author:      Gerard Sookahet
# Modified by: Poor Yorick, 2013-08
# Date:        2012-02-28
# Description: Plot Vogel prime spiral and Vogel divisor spiral

package require Tk
package require platform
namespace import ::msgcat::*


proc nsproc {name args vars body} {
    foreach var $vars {
        lappend pre [list variable $var]
    }
    lappend pre $body
    proc $name $args [join $pre \n]
}


proc truekeypress {w serial arrayname} {
    upvar $arrayname state
    set state(press) $serial
    if {$serial ne $state(release)} {
        event generate $w <<TrueKeyPress>>
    }
}

proc truekeyrelease {w serial arrayname} {
    upvar $arrayname state
    set state(release) $serial
    after 0 [list apply [list {w arrayname} {
        upvar $arrayname state
        if {$state(release) ne $state(press)} {
            event generate $w <<TrueKeyRelease>>
        }
    } [namespace current]] $w $arrayname]
}

# Arbitrary color table
proc colormap n {
    set lcolor {
        #030303 #CD0000 #CD4F39 #EE4000 #EE6A50 #FF7F00 #EE9A00
        #FF8C69 #FFC125 #EEEE00 #EED5B7 #D2691E #BDB76B #00FFFF
        #7FFFD4 #FFEFD5 #AB82FF #E066FF
    }
    return [lindex $lcolor $n]
}


nsproc languageSet w windows {
    set locale [$w.p.choice.language get]
    mclocale $locale

    wm title [winfo toplevel $w] [mc %vogelSpiral]

    foreach varname [array names windows $w,*] {
        set windows($varname) $windows($varname)
    }

    foreach {path text} {bu %vogelSpiral bd %divisorSpiral bq %quit br %reset} {
        $w.f1.$path configure -text [mc $text]
    }
    $w.p.choose.label configure -text [mc %parameter]

    set selected {}
    if {[llength [array names windows $w,parameters]] != 0} {
        set selected [dict get $windows($w,parameters) [$w.p.choose.from get]]
    }
    set windows($w,parameters) [dict create]
    foreach parameter [info procs [namespace current]::param_*] {
        set param [string range $parameter [expr {[string first _ $parameter] + 1}] end]
        set text [mc %$param]
        dict set windows($w,parameters) $text $param
        lappend parameters $text
    }
    if {$selected ne {}} {
        $w.p.choose.from set [mc %$selected]
    }
    $w.p.choose.from configure -values $parameters
}


proc param_refresh {w} {
    pack {*}[winfo children $w.p.choice.refresh] -side left
}

proc param_rscript {w} {
    set wrscript $w.p.choice.rscript
    $wrscript.presets configure -values {
        {$refresh + 1}
        {$refresh + 10}
        {$refresh + 100}
        {$refresh - 100}
        {entier($refresh + ($refresh * .20))}
    }
    pack {*}[winfo children $wrscript] -anchor w
}

proc param_language w {
    set wrscript $w.p.choice.language
}

nsproc spin w windows {
    set rate [$w.p.choice.refresh.set get]
    if {$rate eq $windows($w,refresh)} {
        ::ttk::style configure TSpinbox -background blue -foreground white
        ::ttk::style configure TSpinbox -fieldbackground blue
    } else {
        ::ttk::style configure TSpinbox -background pink
        ::ttk::style configure TSpinbox -fieldbackground $windows($w,warnbackground)
        msg $w %confirm warn
        if {[string is entier -strict $rate] && [scan $rate %d rate] > 0} {
            set increment $windows($w,spinincr)
            if {$increment == 0} {
                set increment 1
            } elseif {$rate % ($increment * 10) == 0} {
                set increment [expr {$increment * 10}]
            }
            $w.p.choice.refresh.set configure -increment $increment
            $w.p.choice.refresh.set configure -from [expr {$rate - $increment}]
            $w.p.choice.refresh.set configure -to [expr {$rate + $increment}]
            set windows($w,spinincr) $increment
        }
    }
}

nsproc refreshChange w windows {
    ::ttk::style configure TSpinbox -background blue
    ::ttk::style configure TSpinbox -fieldbackground blue
    set rate [$w.p.choice.refresh.set get]
    if {[string is entier -strict $rate] && [scan $rate %d rate] > 0} {
        msg $w %confirmed normal
        set windows($w,refresh) $rate
    }
}

nsproc msg {w msg {level normal}} windows {
    set windows($w,status) $msg
    ::ttk::style configure Status.TLabel -foreground $windows($w,msg$level)
    $w.status configure -text [mc $msg]
}

nsproc reset w {tasks windows} {
    $windows($w,pix) blank
    foreach task $windows($w,tasks) {
        set tasks($task,alive) 0
    }
}

nsproc spinSet {w val} windows {
    set windows($w,spinincr) $val
    $w.p.choice.refresh.set configure -increment 1
}


nsproc rscriptSet w windows {
    set windows($w,rscript) [$w.p.choice.rscript.presets get]
    msg $w %confirmed normal
}


nsproc spiral {w N} {windows} {
    foreach {name val} {
        rscript {}
        spinincr 0
        refresh 0
        tasks {}
        N $N
        primecolor #00FFFF
        refreshtask {}
        warnbackground pink
        msgnormal black
        msgwarn pink4
        nonprimecolor #606060
        pix {[image create photo]}
    } {
        array set windows [list $w,$name [subst $val]]
    }


    if {[tk windowingsystem] ni [list aqua win32]} {
        ::ttk::style configure TButton -background blue -foreground white
        ::ttk::style configure TCombobox -background blue -fieldbackground blue -foreground white
    }
    ::ttk::style configure TEntry -background blue -foreground white
    ::ttk::style configure TSpinbox -background blue -foreground white
    ::ttk::style configure ComboboxPopdownFrame -fieldbackground blue -background blue

    set dim [expr {int(sqrt($N) + 10)}]
    set windows($w,mid) [expr {$dim/2}]
    canvas $w.c -width $dim -height $dim -bg black
    $w.c create image 0 0 -anchor nw -image $windows($w,pix)
    pack $w.c

    set f1 [frame $w.f1 -relief sunken -borderwidth 2]
    pack $f1 -fill x

    ::ttk::button $f1.bu -width 12 -command [list PlotVogel $w prime]
    ::ttk::button $f1.bd -width 12 -command [list PlotVogel $w divisor]
    ::ttk::button $f1.bq -width 5 -command [list spiralDestroy $w]
    ::ttk::button $f1.br -width 5 -command [list reset $w]
    pack {*}[winfo children $f1] -side left

    frame $w.p

    frame $w.p.choose
    ::ttk::label $w.p.choose.label -text [mc %parameters]
    ::ttk::combobox $w.p.choose.from -width 15

    bind $w.p.choose.from <<ComboboxSelected>> [list apply [list w {
        variable windows
        pack forget {*}[winfo children $w.p.choice]
        set param [dict get $windows($w,parameters) [$w.p.choose.from get]]
        param_$param $w
        pack $w.p.choice.$param
    } [namespace current]] $w]

    pack {*}[winfo children $w.p.choose] -side left

    frame $w.p.choice
    frame $w.p.choice.refresh
    ::ttk::spinbox $w.p.choice.refresh.set -width 8 -from 0 -to 100 -increment 1 -command [list spin $w]
    ::ttk::label $w.p.choice.refresh.current -width 8

    bind $w.p.choice.refresh.set <ButtonRelease> [list spinSet $w 0]
    bind $w.p.choice.refresh.set <<TrueKeyRelease>> [bind $w.p.choice.refresh.set <ButtonRelease>]
    bind $w.p.choice.refresh.set <Return> [list refreshChange $w]
    bind $w.p.choice.refresh.set <<TrueKeyPress>> [list spin $w]
    trace add variable windows($w,refresh) write [list apply [list {w args} {
        variable windows
        $w.p.choice.refresh.current configure -text $windows($w,refresh)
    } [namespace current]] $w]
    $w.p.choice.refresh.set set 0

    frame $w.p.choice.rscript
    ::ttk::combobox $w.p.choice.rscript.presets
    bind $w.p.choice.rscript.presets <Return> [list rscriptSet $w]
    bind $w.p.choice.rscript.presets <<ComboboxSelected>> [list [namespace which msg] $w %%confirm warn]

    ::ttk::combobox $w.p.choice.language -values {en ru}
    $w.p.choice.language set en
    bind $w.p.choice.language <<ComboboxSelected>> [list [namespace which languageSet] $w]

    pack $w.p -fill x
    pack {*}[winfo children $w.p] -side left -anchor w

    ::ttk::label $w.status -style Status.TLabel -justify left -relief sunken
    trace add variable windows($w,status) write [list apply [list {w args} {
        variable windows
        $w.status configure -text [mc $windows($w,status)]
    } [namespace current]] $w]
    set windows($w,status) %intro

    pack $w.status -fill x
    languageSet $w
}

nsproc spiralDestroy w windows {
    reset $w
    image delete $windows($w,pix)
    array unset windows $w,*
    destroy $w
}


nsproc ticktock task {tasks windows} {
    if {!$tasks($task,alive)} {
        #time for task to die
        return -level 2
    }
    set w $tasks($task,w)
    if {$windows($w,refreshtask) eq {} && $windows($w,refresh) != 0} {
        refreshNew $w
    }
}

nsproc refresh task {tasks windows} {
    ticktock $task
    set w $tasks($task,w)
    set refresh $windows($w,refresh)
    after idle [list after 0 [list PlotVogel $w $windows($w,type)]]
    if {$refresh != 0} {
        if {$windows($w,rscript) ne {}} {
            set windows($w,refresh) [expr $windows($w,rscript)]
        }
        after idle [list after $windows($w,refresh) [list refresh $task]]
    }
}

nsproc refreshNew w {tasks windows} {
    set task [task w $w alive 1]
    lappend windows($w,tasks) $task
    set windows($w,refreshtask) $task
    after idle [list after $windows($w,refresh) [list refresh $task]]
    return $task
}

nsproc task args tasks {
    set task [info cmdcount]
    foreach {name val} $args {
        set tasks($task,$name) $val
    }
    return $task
}





nsproc PlotVogel {w type} {tasks windows} {
    set windows($w,type) $type

    set N $windows($w,N)
    set mid $windows($w,mid)
    $windows($w,pix) blank

    set task [task w $w alive 1]
    lappend windows($w,tasks) $task

    set xo $mid
    set yo $mid
    set M [expr {$N/4}]

    if {$type == {prime}} {
        after idle [list after 0 [list PlotVogelPrime $task 1 $M $xo $yo]]
    } else {
        #set cmap #030303
        after idle [list after 0 [list PlotVogelDivisor $task 1 $M $xo $yo]]
    }
}

nsproc PlotVogelPrime {task n M xo yo} {tasks windows 2pi phi} {
    ticktock $task
    if {$n < $M} {
        set sqn [expr {sqrt($n)}]
        set 2piphi [expr {$2pi*$n/$phi/$phi}]
        set x [expr {int(cos($2piphi)*$sqn) + $xo}]
        set y [expr {int(sin($2piphi)*$sqn) + $yo}]
        set pix $windows($tasks($task,w),pix)
        if {[IsPrime $n]} {
            $pix put $windows($tasks($task,w),primecolor) -to $x $y
        } else {
            $pix put $windows($tasks($task,w),nonprimecolor) -to $x $y
        }
        after idle [list after 0 \
            [list [namespace which [lindex [info level 0] 0]] $task [incr n] $M $xo $yo]]
    }
}

nsproc PlotVogelDivisor {task n M xo yo} {tasks windows 2pi phi} {
    ticktock $task
    if {$n < $M} {
        set sqn [expr {sqrt($n)}]
        set 2piphi [expr {$2pi*$n/$phi/$phi}]
        set x [expr {int(cos($2piphi)*$sqn) + $xo}]
        set y [expr {int(sin($2piphi)*$sqn) + $yo}]
        $windows($tasks($task,w),pix) put [colormap [NbDivisor $n]] -to $x $y
        after idle [list after 0  \
            [list [namespace which [lindex [info level 0] 0]] $task [incr n] $M $xo $yo]]
    }
}

# Primality testing
proc IsPrime n {
    if {$n == 1} {return 0}
    set max [expr {int(sqrt($n))}]
    set d 2
    while {$d <= $max} {
       if {$n % $d == 0} {return 0}
       incr d
    }
    return 1
}

# Return the number of divisors of an integer
proc NbDivisor n {
    set max [expr {int(sqrt($n))}]
    set nd 0
    for {set i 2} {$i <= $max} {incr i} {
        if {$n % $i == 0} {incr nd}
    }
    return $nd
}

bind all <Escape> {exit}
bind all <KeyPress> +[list [namespace which truekeypress] %W %# [namespace current]::truepress]
bind all <KeyRelease> +[list [namespace which truekeyrelease] %W %# [namespace current]::truepress]

variable 2pi 6.28318531
variable phi [expr {(1+sqrt(5))/2.0}]
variable truepress
array set [namespace current]::truepress [list press 0 release 0]

# Set up localisation
variable messages {
    %confirm {en {press enter to confirm the setting} ru {нажать enter чтобы подвердить выбор}}
    %confirmed {en {setting confirmed} ru {выбор подверждён}}
    %intro {en ...  ru ...}
    %divisorSpiral {en {divisor spiral} ru {спираль делителя}}
    %language {en language ru язык}
    %parameter {en parameter ru параметр}
    %quit {en Quit ru выход}
    %refresh {en refresh ru обновить}
    %reset {en reset ru сброс}
    %rscript {en {refresh routine} ru {режим обновления}}
    %vogelSpiral {en {Vogel spiral} ru {спираль Вогеля}}
}

foreach {name languages} $messages {
    foreach {language message} $languages {
        mcset $language $name $message
    }
}

proc main {count N} {
    set w .[info cmdcount]
    toplevel $w
    wm withdraw .
    while {[incr i] <= $count} {
        wm geometry $w +[incr x 200]+10
        frame $w.spiral$i
        spiral $w.spiral$i $N
    }
    pack {*}[winfo children $w]
}

# The maximum integer. The canvas is sized from its square root
main 1 100000
main 2 100000
