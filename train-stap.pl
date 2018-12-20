#!/usr/bin/perl
my $TF=$ARGV[0]; ####TF

open (INP,"<$ARGV[1]"); ###Motif list
my @list=<INP>;
close INP;

my $files="";
my $col="1,2";
my $n=3;
foreach (@list){
 chomp ($_);
 my $motifname;
 if ($_=~/(.*?)\.wtmx/){
  $motifname=$1;
 }
 my $i=15; ### Hardcoded et
 my $data=$TF."-train-chip.bed";
 my $seq=$TF."-train-seq.fa";
 my $motif=$motifname.".wtmx";
 print $motif."\n";
 my $output=$TF.".".$motifname.".et".$i."_train_score.txt";
 my $output2=$TF.".".$motifname.".et".$i."_train_sort.txt";
 my $output3=$TF.".".$motifname.".et".$i."_train_result.txt";
 my $loc="et".$i;
 my $output4=$TF.".".$motifname.".et".$i."_train_model.txt";
 open (OUT,">~/16sp/STAP-train/output/$output");
 my $com=`/shared-mounts/sinhas/xiaoman/STAP2/seq2binding -d ./train-chip/$data -s ./train-seq/$seq -m ./motif/$motif -td ./train-chip/$data -ts ./train-seq/$seq -co 0 -cc 11 -rr 50 -et $i -tp ./train-output/scores/$output -pm ./train-output/model/$output4 >./train-output/result/$output3`;
 print $com;
 close OUT;
 my $com2=`sort -g -k 3 ./train-output/scores/$output >./train-output/sort/$output2`;
 print $com2;
 $files = $files." ./train-output/scores/$output";
 $col=$col.",".$n;
 $n=$n+3;
}
my $com=`paste $files|cut -f $col`;

open (OUT,">$TF-train-matrix.txt");
print OUT $com;
close OUT;
