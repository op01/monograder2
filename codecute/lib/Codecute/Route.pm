package Codecute::Route;

sub setup{
    my $r=shift;
    $r=shift;
    $r->any('/api/test')->to('Example#welcome')->name('index');

    my $auth=$r->any('/login')->to(controller=>'auth');
    $auth->get('/ok')->to(action=>'ok');
    $auth->get('/facebook')->to(action=>'toFacebook');
    $auth->get('/facebook/ok')->to(action=>'fromFacebook');

    $r->get('/api/me')->to('account#me');
    my $api=$r->under('/api')->to('auth#check');
    # $api->websocket('/ws')->to('websocket#ws');
    

    my $problem = $api->any('/problem')->to(controller=>'problem');
    $problem->get('/')->to(action=>'list');
    $problem->get('/:problem_id')->to(action=>'view');
    $problem->post('/:problem_id/submit')->to(action=>'submit');
    my $submit = $api->any('/submission')->to(controller=>'submission');
    $submit->get('/:submission_id')->to(action=>'view');

    my $admin=$api->under('/')->to('auth#checkAdmin');
    $problem=$admin->any('/problem')->to(controller=>'problem');
    $problem->post('/')->to(action=>'create');
    $problem->post('/:problem_id/test')->to('testcase#create');
}

1;
