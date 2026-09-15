; SEGA MEGA DRIVE / GENESIS MINIMAL ROM
    dc.l    $00FFFE00, EntryPoint, Exception, Exception
    dc.l    Exception, Exception, Exception, Exception
    dc.l    Exception, Exception, Exception, Exception
    dcb.l   12, Exception
    dc.l    Exception, Exception, Exception, Exception
    dc.l    Exception, EntryPoint, Exception

    dc.b    "SEGA MEGA DRIVE "
    dc.b    "(C)2026 AI AGENT"
    dc.b    "MY CUSTOM GAME                          "
    dc.b    "MY CUSTOM GAME                          "
    dc.b    "GM 00000000-00"
    dc.w    $0000
    dc.b    "J               "
    dc.l    $00000000, $00010000, $00FF0000, $00FFFFFF
    dc.b    "            ", "            ", "                                ", "JUE             "

VDP_DATA    equ $00C00000
VDP_CTRL    equ $00C00004
VERSION_PORT equ $00A10001
HI_MARK     equ $00A14000

EntryPoint:
    move.b  VERSION_PORT, d0
    andi.b  #$0F, d0
    beq.s   SkipTMSS
    move.l  #"SEGA", HI_MARK
SkipTMSS:
    lea     VDPRegisters, a0
    move.q  #18, d0
    move.w  #$8000, d1
SetVDPRegs:
    move.b  (a0)+, d1
    move.w  d1, VDP_CTRL
    add.w   #$0100, d1
    dbra    d0, SetVDPRegs

    move.l  #$C0000000, VDP_CTRL
    move.w  #$0000, VDP_DATA
    move.w  #$0E22, VDP_DATA
    move.w  #$00EE, VDP_DATA

    move.l  #$40000000, VDP_CTRL
    lea     TileData, a0
    move.w  #7, d0
LoadTile:
    move.l  (a0)+, VDP_DATA
    dbra    d0, LoadTile

    move.l  #$46840000, VDP_CTRL
    move.w  #$0001, VDP_DATA

InfiniteLoop:
    bra.s   InfiniteLoop

Exception:
    rte

VDPRegisters:
    dc.b $04, $74, $30, $00, $07, $7C, $00, $00
    dc.b $00, $00, $01, $00, $81, $3F, $00, $02
    dc.b $01, $00, $00

TileData:
    dc.l $11111111, $12222221, $12111121, $12122121
    dc.l $12122121, $12111121, $12222221, $11111111
