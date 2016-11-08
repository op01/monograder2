package Codecute::Model::Oauth;

use strict;
use warnings;
use Net::Facebook::Oauth2;

my $fb = Net::Facebook::Oauth2->new(
    application_id     => '1763891843879110',
    application_secret => $ENV{'CONFIG_FB_SECRET'},
    callback           => $ENV{'CONFIG_FB_CBURL'}
);

sub new { bless {}, shift }

sub getFacebookAuthUrl {
    my $url=$fb->get_authorization_url(
          scope   => [ 'public_profile', 'email'],
          display => 'page'
    );
    return $url;
}

sub getFacebookToken {
    my ($self,$code)=@_;
    my $token = $fb->get_access_token(code => $code);
    return $token;
}

sub getFacebookEmail {
    my ($self,$token) = @_;
    my $fbx = Net::Facebook::Oauth2->new(access_token => $token);
    my $info = $fbx->get('https://graph.facebook.com/v2.7/me?fields=email');
    return $info->as_hash->{email};
}

1;
