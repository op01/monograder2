package rextesterApi;
use Mojo::UserAgent;
my $ua=Mojo::UserAgent->new;
sub run {
    my $shit=shift;
    my ($language,$source_code,$input) = @_;
    my %hash;
    my $ret = \%hash;
    if($language eq 'cpp'){
        $LanguageChoice = 7;
        $CompilerArgs = '-o a.out source_file.cpp';
    }
    elsif($language eq 'java'){
        $LanguageChoice = 4;
        $CompilerArgs = '';
    }
    else{
        $ret->{error} = 'Language not supported';
        return $ret;
    }
    my $result=$ua->post('http://rextester.com/rundotnet/api' =>
        form => {
            LanguageChoice => $LanguageChoice,
            Program => $source_code,
            CompilerArgs => $CompilerArgs,
            Input => $input
        }
    );
    my $json = $result->res->json;
    $ret->{stdout} = $json->{Result};
    if($json->{Errors} eq ''){
        $ret->{build_exit_code} = 0;
    }
    else{
        $ret->{build_exit_code} = 1;
        $ret->{build_stdout} = $json->{Errors};
        return $ret;
    }
    if(@match = $json->{Stats} =~ /absolute running time: (\d+\.\d+) sec/){
        $ret->{time} = $match[0];
    }
    else{
        $ret->{time} = '10';
        $ret->{error} = "Can't parse stats'";
    }
    # error build_exit_code time stdout
    return $ret;
}
