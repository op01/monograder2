package Codecute;
use Mojo::Base 'Mojolicious';
use Mojo::Pg;
use Codecute::Route;
use Codecute::Model::Oauth;
use Codecute::Model::Account;
use Codecute::Model::Problem;
use Codecute::Model::Submission;

# This method will run once at server start
sub startup {
    my $self = shift;
    $self->secrets([$ENV{MOJO_SECRET}]);

    $self->plugin(Minion=>{Pg => $ENV{DATABASE_URL}});
    $self->plugin('Codecute::Judge');
    $self->helper(pg=>sub{ state $pg = Mojo::Pg->new($ENV{DATABASE_URL})});

    $self->helper(oauth=>sub{ state $oauth = Codecute::Model::Oauth->new });
    $self->helper(account=>sub{ state $account = Codecute::Model::Account->new(pg => shift->pg) });
    $self->helper(problem=>sub{ state $problem = Codecute::Model::Problem->new(pg => shift->pg) });
    $self->helper(submission=>sub{ state $submission = Codecute::Model::Submission->new(pg => shift->pg) });
    Codecute::Route->setup($self->routes);
    $self->log->info('Startup OK');
}

1;
