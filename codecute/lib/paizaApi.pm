package paizaApi;
use Mojo::UserAgent;
my $ua=Mojo::UserAgent->new;
my $api_key = 'guest';
sub run {
    my $shit=shift;
    my ($language,$source_code,$input) = @_;
    my $result=$ua->post('http://api.paiza.io/runners/create' =>
        form => {
            source_code => $source_code,
            language => $language,
            input => $input,
            longpoll => 'true',
            api_key => $api_key
        }
    );
    my $data=$result->res->json;
    if($data->{error}){
        return $data;
    }
    my $id=$data->{id};
    $result=$ua->get('http://api.paiza.io/runners/get_details' =>
        form => {
            id => $id,
            api_key => $api_key
        }
    );
    return $result->res->json;
}
