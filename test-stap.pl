#!/usr/bin/perl
open (INP,"<$ARGV[1]"); # Motifs list
my @list=<INP>;
close INP;

my $TF=$ARGV[0]; # TF name, use "sample" when working with the sample data

my $files="";
my $col="1";
my $n=3;

foreach (@list){
 print $_;
 chomp ($_);
 my $motifname;
 if ($_=~/(.*?)\.wtmx/){
  $motifname=$1;
 }
 my $i=15;
 $model=$TF.".".$motifname.".et".$i."_train_model.txt";;
 $traindata=$TF."-train-chip.bed";
 $trainseq=$TF."-train-seq.fa";
 $motif=$motifname.".wtmx";
 $testdata="$ARGV[2]-data.bed"; # Test data name, use "test" when working with the sample data
 $testseq="$ARGV[2]-seq.fa";
 $output=$ARGV[2].".".$ARGV[0].".".$motifname.".stap.txt";
 $output2=$ARGV[2].".".$ARGV[0].".".$motifname."stap.output.txt";
 my $com=`/shared-mounts/sinhas/xiaoman/STAP2/seq2binding -d ./train-chip/$traindata -s ./train-seq/$trainseq -td ./test-data/$testdata -ts ./test-seq/$testseq -m ./motif/$motif -pin ./train-output/model/$model -co 0 -cc 11 -et $i -tp ./test-output/$output >./test-output/$output2`;
 $files = $files." ./test-output/$output";
 $col=$col.",".$n;
 $n=$n+3;
}
my $com=`paste $files|cut -f $col`;

open (OUT,">$TF-$ARGV[2]-matrix.txt");
print OUT $com;
close OUT;
