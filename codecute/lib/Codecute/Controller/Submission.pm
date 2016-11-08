package Codecute::Controller::Submission;
use Mojo::Base 'Mojolicious::Controller';

sub view {
    my $self = shift;
    my $id = $self->param('submission_id');
    my $info = $self->submission->getSubmissionInfo($id);
    $self->render(json=>$info);
}

1;
