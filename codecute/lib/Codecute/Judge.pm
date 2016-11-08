package Codecute::Judge;
use Mojo::Base 'Mojolicious::Plugin';
use paizaApi;
sub register {
    my ($self, $app) = @_;
    $app->minion->add_task(judge => sub {
        my $job = shift;
        my $id = shift;
        my $submission = $job->app->submission->getSubmissionInfo($id);
        $job->app->log->info("submission_id -> $id : Judging");
        my $t = $job->app->problem->getTest($submission->{problem_id});
        my $num = @$t;
        $job->app->log->debug("Got $num testcases");
        my $result='';
        for my $i(0..$#$t){
            $job->app->log->debug("Running case #$i");
            my $run=paizaApi->run($submission->{data}->{language},$submission->{data}->{source_code},$t->[$i]->{in});
            $job->app->log->debug($run->{stdout});
            $job->app->log->debug($t->[$i]->{out});
            if($run->{error}){
                $result = "API error";
                $job->app->log($result);
                last;
            }
            elsif($run->{build_exit_code} != 0){
                $result = "Build error";
                last;
            }
            elsif($run->{time} > 1){
                $result.='T';
            }
            elsif($run->{stdout} ne $t->[$i]->{out}){
                $result.='-';
            }
            else{
                $result.='P';
            }
        }
        $job->app->submission->updateSubmissionInfo($id,{
            result => $result,
            status => 'judged'
        });
        $job->finish($result);
        $job->app->log->info("submission_id -> $id : Finished");
    });
}

1;
