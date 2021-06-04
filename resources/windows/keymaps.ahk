; https://www.autohotkey.com/
; copy to following dir for autostart
; C:\Users\<username>\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup
; --------------------------------------------------------------
; ! = ALT
; ^ = CTRL
; + = SHIFT
; # = WIN

#Persistent
SetCapsLockState, AlwaysOff

; fn to ctrl
SC163::LCtrl

; CapsLock to fn
CapsLock::SC163

; right ctrl to alt
$RCtrl::RAlt

; --------------------------------------------------------------
; vim like movement

Capslock & h::Send {Blind}{Left DownTemp}
Capslock & h up::Send {Blind}{Left Up}

Capslock & j::Send {Blind}{Down DownTemp}
Capslock & j up::Send {Blind}{Down Up}

Capslock & k::Send {Blind}{Up DownTemp}
Capslock & k up::Send {Blind}{Up Up}

Capslock & l::Send {Blind}{Right DownTemp}
Capslock & l up::Send {Blind}{Right Up}

; --------------------------------------------------------------
; Pok3r like media control

CapsLock & q::SendInput {Media_Prev}
CapsLock & w::SendInput {Media_Play_Pause}
CapsLock & e::SendInput {Media_Next}

CapsLock & s::SendInput {Volume_Down}
CapsLock & d::SendInput {Volume_Up}
CapsLock & f::SendInput {Volume_Mute}

; --------------------------------------------------------------
; osx like controls

Capslock & BS::SendInput {Del Down}
Capslock & BS up::SendInput {Del Up}
$!x::Send ^x
$!c::Send ^c
$!v::Send ^v
$!s::Send ^s
$!a::Send ^a
$!z::Send ^z
$!+z::Send ^y
$!w::Send ^w
$!f::Send ^f
$!n::Send ^n
$!q::Send !{f4}
$!r::Send ^{f5}
$!m::Send {LWin Down}{Down}{LWin Up}
$!`::Send {Alt Down}{Shift Down}{Tab}{Shift Up}

; --------------------------------------------------------------
; osx like chrome improvements

#IfWinActive ahk_exe Chrome.exe
$!t::Send ^t
$!l::Send ^l
$!+t::Send ^+t
$!#i::Send ^+i
!LButton::Send ^{LButton}
$!{::Send ^+{Tab}
$!}::Send ^{Tab}

$!1::Send ^1
$!2::Send ^2
$!3::Send ^3
$!4::Send ^4
$!5::Send ^5
$!6::Send ^6
$!7::Send ^7
$!8::Send ^8
$!9::Send ^9
$!0::Send ^0
#IfWinActive
