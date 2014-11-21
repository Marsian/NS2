if (! open throughput1,"<","mptcpsum1.throughput"){
	die "can't open mptcp1.throughput";
}

if (! open throughput2,"<","mptcpsum2.throughput"){
	die "can't open mptcp2.throughput";
}
#if (! open throughput3,"<","mptcpsum3.throughput"){
#	die "can't open mptcp2.throughput";
#}
if (! open throughput4,"<","mptcpsum4.throughput"){
	die "can't open mptcp2.throughput";
}
if (! open throughput5,"<","mptcpsum5.throughput"){
	die "can't open mptcp2.throughput";
}
if (! open throughput7,"<","mptcpsum7.throughput"){
	die "can't open mptcp2.throughput";
}
if (! open throughput8,"<","mptcpsum8.throughput"){
	die "can't open mptcp2.throughput";
}
if (! open throughput10,"<","mptcpsum10.throughput"){
	die "can't open mptcp2.throughput";
}

if (! open throughputsum, ">","mptcpsum100.throughput"){
	die "can't open mptcpsum.throughput";
}

while ($line1=<throughput1>){
	chmod($line1);
	chmod($line2=<throughput2>);
#	chmod($line3=<throughput3>);
	chmod($line4=<throughput4>);
	chmod($line5=<throughput5>);
#	chmod($line6=<throughput6>);
	chmod($line7=<throughput7>);
	chmod($line8=<throughput8>);
	chmod($line10=<throughput10>);
	($num, $throughput1)=split / /,$line1;
	($num, $throughput2)=split / /,$line2;
#	($num, $throughput3)=split / /,$line3;
	($num, $throughput4)=split / /,$line4;
	($num, $throughput5)=split / /,$line5;
#	($num, $throughput6)=split / /,$line6;
	($num, $throughput7)=split / /,$line7;
	($num, $throughput8)=split / /,$line8;
	#($num, $throughput9)=split / /,$line9;
	($num, $throughput10)=split / /,$line10;
	$sum = $throughput1 +$throughput2+$throughput4+$throughput5+$throughput7+$throughput8+$throughput10;
	$sum = $sum/7;
	print throughputsum "$num $sum\n";
}

