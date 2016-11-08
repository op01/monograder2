use rextesterApi;
my $test=rextesterApi->run('java',"class Rextester{ public static void main(String[] args){System.out.println(123);}}");
print($test->{stdout},"\n");
print($test->{error},"\n");
print($test->{build_exit_code},"\n");
print($test->{build_stdout},"\n");
print($test->{time},"\n");
