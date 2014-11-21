#
# Copyright (c) 1999 Regents of the University of California.
# All rights reserved.
#
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions
# are met:
# 1. Redistributions of source code must retain the above copyright
#    notice, this list of conditions and the following disclaimer.
# 2. Redistributions in binary form must reproduce the above copyright
#    notice, this list of conditions and the following disclaimer in the
#    documentation and/or other materials provided with the distribution.
# 3. All advertising materials mentioning features or use of this software
#    must display the following acknowledgement:
#       This product includes software developed by the MASH Research
#       Group at the University of California Berkeley.
# 4. Neither the name of the University nor of the Research Group may be
#    used to endorse or promote products derived from this software without
#    specific prior written permission.
#
# THIS SOFTWARE IS PROVIDED BY THE REGENTS AND CONTRIBUTORS ``AS IS'' AND
# ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
# IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
# ARE DISCLAIMED.  IN NO EVENT SHALL THE REGENTS OR CONTRIBUTORS BE LIABLE
# FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
# DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS
# OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
# HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT
# LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY
# OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF
# SUCH DAMAGE.
#
# Contributed by Tom Henderson, UCB Daedalus Research Group, June 1999
#
# $Header: /cvsroot/nsnam/ns-2/tcl/ex/sat-iridium.tcl,v 1.4 2001/11/06 06:20:11 tomh Exp $
#
# Example of a broadband LEO constellation with orbital configuration 
# similar to that of Iridium.  The script sets up two terminals (one in 
# Boston, one at Berkeley) and sends a packet from Berkeley to Boston
# every second for a whole day-- the script illustrates how the latency
# due to propagation delay changes depending on the satellite configuration. 
#
# This script relies on sourcing two additional files:
# - sat-iridium-nodes.tcl
# - sat-iridium-links.tcl
# Iridium does not have crossseam ISLs-- to enable crossseam ISLs, uncomment 
# the last few lines of "sat-iridium-links.tcl"
#
# Iridium parameters [primary reference:  "Satellite-Based Global Cellular
# Communications by Bruno Pattan (1997-- McGraw-Hill)]
# Altitude = 780 km
# Orbital period = 6026.9 sec
# intersatellite separation = 360/11 deg
# interplane separation = 31.6 deg
# seam separation = 22 deg
# inclination = 86.4
# eccentricity =  0.002 (not modelled)
# minimum elevation angle at edge of coverage = 8.2 deg
# ISL cross-link pattern:  2 intraplane to nearest neighbors in plane, 
#   2 interplane except at seam where only 1 interplane exists

global ns
set ns [new Simulator]

Trace set show_tcphdr 2


# Global configuration parameters 
HandoffManager/Term set elevation_mask_ 8.2
#HandoffManager/Term set term_handoff_int_ 10
HandoffManager/Term set term_handoff_int_ 1
HandoffManager/Sat set sat_handoff_int_ 10
HandoffManager/Sat set latitude_threshold_ 60 
HandoffManager/Sat set longitude_threshold_ 10 
#HandoffManager set handoff_randomization_ true
HandoffManager set handoff_randomization_ 0
SatRouteObject set metric_delay_ true
# Set this to false if opt(wiredRouting) == ON below
SatRouteObject set data_driven_computation_ true
# "ns-random 0" sets seed heuristically; other integers are deterministic
ns-random [lindex $argv 6]
Agent set ttl_ 32; # Should be > than max diameter in network

# One plane of Iridium-like satellites

global opt
set opt(chan)           Channel/Sat
#set opt(bw_down)        1.5Mb; # Downlink bandwidth (satellite to ground)
#set opt(bw_up)          1.5Mb; # Uplink bandwidth
set opt(bw_down)        1.0Mb; # Downlink bandwidth (satellite to ground)
set opt(bw_up)          0.5Mb; # Uplink bandwidth
set opt(bw_isl)         3.0Mb
set opt(phy)            Phy/Sat
set opt(mac)            Mac/Sat
set opt(ifq)            Queue/DropTail
#set opt(qlim)           50
#set opt(qlim)           100
set opt(qlim)           80
set opt(ll)             LL/Sat
set opt(wiredRouting) 	OFF

set opt(alt)            780; # Polar satellite altitude (Iridium)
set opt(inc)            86.4; # Orbit inclination w.r.t. equator

# XXX This tracing enabling must precede link and node creation
#set outfile [open hy.tr w]
set name [lindex $argv 0]
set time [lindex $argv 1]
set outfile [open $name.tr w]
$ns trace-all $outfile

# Create the satellite nodes
# Nodes 0-99 are satellite nodes; 100 and higher are earth terminals


$ns node-config -satNodeType polar \
		-llType $opt(ll) \
		-ifqType $opt(ifq) \
		-ifqLen $opt(qlim) \
		-macType $opt(mac) \
		-phyType $opt(phy) \
		-channelType $opt(chan) \
		-downlinkBW $opt(bw_down) \
		-wiredRouting $opt(wiredRouting) 

set alt $opt(alt)
set inc $opt(inc)

source sat-iridium-nodes.tcl


# configure the ISLs
source sat-iridium-links.tcl
#$ns add-isl intraplane $n0 $n1 $opt(bw_isl) $opt(ifq) $opt(qlim)
#$ns add-isl intraplane $n1 $n2 $opt(bw_isl) $opt(ifq) $opt(qlim)
#$ns add-isl intraplane $n2 $n3 $opt(bw_isl) $opt(ifq) $opt(qlim)
#$ns add-isl intraplane $n3 $n4 $opt(bw_isl) $opt(ifq) $opt(qlim)
#$ns add-isl intraplane $n4 $n5 $opt(bw_isl) $opt(ifq) $opt(qlim)
#$ns add-isl intraplane $n5 $n6 $opt(bw_isl) $opt(ifq) $opt(qlim)
#$ns add-isl intraplane $n6 $n7 $opt(bw_isl) $opt(ifq) $opt(qlim)
#$ns add-isl intraplane $n7 $n8 $opt(bw_isl) $opt(ifq) $opt(qlim)
#$ns add-isl intraplane $n8 $n9 $opt(bw_isl) $opt(ifq) $opt(qlim)
#$ns add-isl intraplane $n9 $n10 $opt(bw_isl) $opt(ifq) $opt(qlim)
#$ns add-isl intraplane $n10 $n0 $opt(bw_isl) $opt(ifq) $opt(qlim)



$ns node-config -satNodeType terminal


set n100 [$ns node]
set n101 [$ns node]
set n100_0 [$ns node]
set n100_1 [$ns node]
set n101_0 [$ns node]
set n101_1 [$ns node]

#mptcp sender

$ns multihome-add-interface $n100 $n100_0
$ns multihome-add-interface $n100 $n100_1

#mptcp reveiver

$ns multihome-add-interface $n101 $n101_0
$ns multihome-add-interface $n101 $n101_1

# Set up terrestrial nodes
set n102 [$ns node]
set n103 [$ns node]

set n104 [$ns node]
set n105 [$ns node]

## disturbance############################################ 


#mptcp sender
$n100 set-position [lindex $argv 2] [lindex $argv 3]; # Berkeley
$n101 set-position [lindex $argv 4] [lindex $argv 5]; # Berkeley
$n100_0 set-position [expr {[lindex $argv 2]-1}] [expr {[lindex $argv 3]-1}]; # Berkeley
$n100_1 set-position [expr {[lindex $argv 2]+1}] [expr {[lindex $argv 3]+1}]; # Berkeley
$n101_0 set-position [expr {[lindex $argv 4]-1}] [expr {[lindex $argv 5]-1}]; # Berkeley
$n101_1 set-position [expr {[lindex $argv 4]+1}] [expr {[lindex $argv 5]+1}]; # Berkeley
$n102 set-position [lindex $argv 2] [lindex $argv 3]; # Berkeley
$n103 set-position [lindex $argv 4] [lindex $argv 5]; # Berkeley
$n104 set-position [lindex $argv 2] [lindex $argv 3]; # Berkeley
$n105 set-position [lindex $argv 4] [lindex $argv 5]; # Berkeley


#$n100 add-gsl polar $opt(ll) $opt(ifq) $opt(qlim) $opt(mac) $opt(bw_up) \
  $opt(phy) [$n0 set downlink_] [$n0 set uplink_]
$n100_0 add-gsl polar $opt(ll) $opt(ifq) $opt(qlim) $opt(mac) $opt(bw_up) \
  $opt(phy) [$n0 set downlink_] [$n0 set uplink_]
$n100_1 add-gsl polar $opt(ll) $opt(ifq) $opt(qlim) $opt(mac) $opt(bw_up) \
  $opt(phy) [$n0 set downlink_] [$n0 set uplink_]
#$n101 add-gsl polar $opt(ll) $opt(ifq) $opt(qlim) $opt(mac) $opt(bw_up) \
  $opt(phy) [$n1 set downlink_] [$n1 set uplink_]
$n101_0 add-gsl polar $opt(ll) $opt(ifq) $opt(qlim) $opt(mac) $opt(bw_up) \
  $opt(phy) [$n1 set downlink_] [$n1 set uplink_]
$n101_1 add-gsl polar $opt(ll) $opt(ifq) $opt(qlim) $opt(mac) $opt(bw_up) \
  $opt(phy) [$n1 set downlink_] [$n1 set uplink_]


######################################################################3

$ns trace-all-satlinks $outfile
set win 1000;
set tcp0 [new Agent/TCP/FullTcp/Sack/Multipath]
$tcp0 set window_ $win 
$tcp0 set packetSize_ 1000
$ns attach-agent $n100_0 $tcp0
set tcp1 [new Agent/TCP/FullTcp/Sack/Multipath]
$tcp1 set window_ $win
$tcp1 set packetSize_ 1000
$ns attach-agent $n100_1 $tcp1
set mptcp [new Agent/MPTCP]
$mptcp attach-tcp $tcp0
$mptcp attach-tcp $tcp1
$ns multihome-attach-agent $n100 $mptcp
set ftp [new Application/FTP]
$ftp attach-agent $mptcp

set mptcpsink [new Agent/MPTCP]
set sink0 [new Agent/TCP/FullTcp/Sack/Multipath]
$ns attach-agent $n101_0 $sink0 
set sink1 [new Agent/TCP/FullTcp/Sack/Multipath]
$ns attach-agent $n101_1 $sink1 
$mptcpsink attach-tcp $sink0
$mptcpsink attach-tcp $sink1
$ns multihome-attach-agent $n101 $mptcpsink
$ns connect $tcp0 $sink0
$ns connect $tcp1 $sink1
$ns multihome-connect $mptcp $mptcpsink
$mptcpsink listen
##############################################################
set rn_long [new RandomVariable/Uniform]
set rn_lat [new RandomVariable/Uniform]
$rn_long set max_ 130
$rn_long set min_ -10
$rn_lat set max_ 35
$rn_lat set min_ -5

# Set up terrestrial nodes
$ns node-config -satNodeType terminal

for {set j 0} {$j < 5} {incr j 1} {
        set send($j) [$ns node]
        set rcv($j) [$ns node]
        $send($j) set-position [$rn_lat value] [$rn_long value]
        $rcv($j) set-position [$rn_lat value] [$rn_long value]
        $send($j) add-gsl polar $opt(ll) $opt(ifq) $opt(qlim) $opt(mac) $opt(bw_up) \
          $opt(phy) [$n0 set downlink_] [$n0 set uplink_]
        $rcv($j) add-gsl polar $opt(ll) $opt(ifq) $opt(qlim) $opt(mac) $opt(bw_up) \
          $opt(phy) [$n0 set downlink_] [$n0 set uplink_]

        # Attach agents for FTP
        set tcp($j) [$ns create-connection TCP $send($j) TCPSink $rcv($j) $j]
        set ftp1 [$tcp($j) attach-app FTP]
        $ns at 3 "$ftp1 start"
        $ns at $time "$ftp1 stop"
}
#########################################################################
$ns at 3 "$ftp start"
$ns at $time "finish" ; # one earth rotation 

set satrouteobject_ [new SatRouteObject]
$satrouteobject_ compute_routes

proc finish {} {
	global ns outfile 
	$ns flush-trace
	close $outfile

	exit 0
}
$ns run

