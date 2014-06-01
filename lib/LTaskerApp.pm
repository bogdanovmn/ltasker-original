package LTaskerApp;

use Dancer ':syntax';
use Dancer::Plugin::Controller;

our $VERSION = '0.1';


get '/' => sub {
    controller template => 'index';
};

true;
