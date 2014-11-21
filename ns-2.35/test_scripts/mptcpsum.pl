if (! open throughput1,"<","mptcp1_1.throughput"){
	die "can't open mptcp1.throughput";
}

if (! open throughput2,"<","mptcp1_2.throughput"){
	die "can't open mptcp2.throughput";
}

if (! open throughputsum, ">","mptcpsum1.throughput"){
	die "can't open mptcpsum.throughput";
}

while ($line1=<throughput1>){
	chmod($line1);
	chmod($line2=<throughput2>);
	($num, $throughput1)=split / /,$line1;
	($num, $throughput2)=split / /,$line2;
	$sum = $throughput1 +$throughput2;
	print throughputsum "$num $sum\n";
}

if (! open throughput1,"<","mptcp2_1.throughput"){
	die "can't open mptcp1.throughput";
}

if (! open throughput2,"<","mptcp2_2.throughput"){
	die "can't open mptcp2.throughput";
}

if (! open throughputsum, ">","mptcpsum2.throughput"){
	die "can't open mptcpsum.throughput";
}

while ($line1=<throughput1>){
	chmod($line1);
	chmod($line2=<throughput2>);
	($num, $throughput1)=split / /,$line1;
	($num, $throughput2)=split / /,$line2;
	$sum = $throughput1 +$throughput2;
	print throughputsum "$num $sum\n";
}

if (! open throughput1,"<","mptcp3_1.throughput"){
	die "can't open mptcp1.throughput";
}

if (! open throughput2,"<","mptcp3_2.throughput"){
	die "can't open mptcp2.throughput";
}

if (! open throughputsum, ">","mptcpsum3.throughput"){
	die "can't open mptcpsum.throughput";
}

while ($line1=<throughput1>){
	chmod($line1);
	chmod($line2=<throughput2>);
	($num, $throughput1)=split / /,$line1;
	($num, $throughput2)=split / /,$line2;
	$sum = $throughput1 +$throughput2;
	print throughputsum "$num $sum\n";
}

if (! open throughput1,"<","mptcp4_1.throughput"){
	die "can't open mptcp1.throughput";
}

if (! open throughput2,"<","mptcp4_2.throughput"){
	die "can't open mptcp2.throughput";
}

if (! open throughputsum, ">","mptcpsum4.throughput"){
	die "can't open mptcpsum.throughput";
}

while ($line1=<throughput1>){
	chmod($line1);
	chmod($line2=<throughput2>);
	($num, $throughput1)=split / /,$line1;
	($num, $throughput2)=split / /,$line2;
	$sum = $throughput1 +$throughput2;
	print throughputsum "$num $sum\n";
}

if (! open throughput1,"<","mptcp5_1.throughput"){
	die "can't open mptcp1.throughput";
}

if (! open throughput2,"<","mptcp5_2.throughput"){
	die "can't open mptcp2.throughput";
}

if (! open throughputsum, ">","mptcpsum5.throughput"){
	die "can't open mptcpsum.throughput";
}

while ($line1=<throughput1>){
	chmod($line1);
	chmod($line2=<throughput2>);
	($num, $throughput1)=split / /,$line1;
	($num, $throughput2)=split / /,$line2;
	$sum = $throughput1 +$throughput2;
	print throughputsum "$num $sum\n";
}

if (! open throughput1,"<","mptcp6_1.throughput"){
	die "can't open mptcp1.throughput";
}

if (! open throughput2,"<","mptcp6_2.throughput"){
	die "can't open mptcp2.throughput";
}

if (! open throughputsum, ">","mptcpsum6.throughput"){
	die "can't open mptcpsum.throughput";
}

while ($line1=<throughput1>){
	chmod($line1);
	chmod($line2=<throughput2>);
	($num, $throughput1)=split / /,$line1;
	($num, $throughput2)=split / /,$line2;
	$sum = $throughput1 +$throughput2;
	print throughputsum "$num $sum\n";
}

if (! open throughput1,"<","mptcp7_1.throughput"){
	die "can't open mptcp1.throughput";
}

if (! open throughput2,"<","mptcp7_2.throughput"){
	die "can't open mptcp2.throughput";
}

if (! open throughputsum, ">","mptcpsum7.throughput"){
	die "can't open mptcpsum.throughput";
}

while ($line1=<throughput1>){
	chmod($line1);
	chmod($line2=<throughput2>);
	($num, $throughput1)=split / /,$line1;
	($num, $throughput2)=split / /,$line2;
	$sum = $throughput1 +$throughput2;
	print throughputsum "$num $sum\n";
}

if (! open throughput1,"<","mptcp8_1.throughput"){
	die "can't open mptcp1.throughput";
}

if (! open throughput2,"<","mptcp8_2.throughput"){
	die "can't open mptcp2.throughput";
}

if (! open throughputsum, ">","mptcpsum8.throughput"){
	die "can't open mptcpsum.throughput";
}

while ($line1=<throughput1>){
	chmod($line1);
	chmod($line2=<throughput2>);
	($num, $throughput1)=split / /,$line1;
	($num, $throughput2)=split / /,$line2;
	$sum = $throughput1 +$throughput2;
	print throughputsum "$num $sum\n";
}

if (! open throughput1,"<","mptcp9_1.throughput"){
	die "can't open mptcp1.throughput";
}

if (! open throughput2,"<","mptcp9_2.throughput"){
	die "can't open mptcp2.throughput";
}

if (! open throughputsum, ">","mptcpsum9.throughput"){
	die "can't open mptcpsum.throughput";
}

while ($line1=<throughput1>){
	chmod($line1);
	chmod($line2=<throughput2>);
	($num, $throughput1)=split / /,$line1;
	($num, $throughput2)=split / /,$line2;
	$sum = $throughput1 +$throughput2;
	print throughputsum "$num $sum\n";
}

if (! open throughput1,"<","mptcp10_1.throughput"){
	die "can't open mptcp1.throughput";
}

if (! open throughput2,"<","mptcp10_2.throughput"){
	die "can't open mptcp2.throughput";
}

if (! open throughputsum, ">","mptcpsum10.throughput"){
	die "can't open mptcpsum.throughput";
}

while ($line1=<throughput1>){
	chmod($line1);
	chmod($line2=<throughput2>);
	($num, $throughput1)=split / /,$line1;
	($num, $throughput2)=split / /,$line2;
	$sum = $throughput1 +$throughput2;
	print throughputsum "$num $sum\n";
}
