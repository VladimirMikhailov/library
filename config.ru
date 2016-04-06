require_relative "config/environment"

use Library::BooksController
use Library::Authors::BooksController
use Library::GraphsController
run Library::ApplicationController
