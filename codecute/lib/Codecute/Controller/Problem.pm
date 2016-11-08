package Codecute::Controller::Problem;
use Mojo::Base 'Mojolicious::Controller';

sub list {
    my $self=shift;
    my $problem;
    if($self->stash('account_info')->{role} eq 'admin'){
        $problem= $self->problem->listAllProblem;
    }else{
        $problem= $self->problem->listProblem;
    } 
    $self->render(json=>$problem);
}

sub create {
    my $self = shift;
    my $data = $self->req->json;
    my $id=$self->problem->createProblem($data->{name},$data->{body});
    $self->render(json=>{id=>$id});
}


sub submit {
    my $self = shift;
    my $problem_id=$self->param('problem_id');
    my $data = $self->req->json;
    my $id = $self->submission->createSubmission(
        $problem_id,
        $self->session->{id},
        $data->{source_code},
        $data->{language}
    );
    $self->minion->enqueue(judge=>[$id]);
    $self->render(json=>{id=>$id});
}

1;
