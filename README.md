Library
--
[![Build
Status](https://semaphoreci.com/api/v1/projects/6b0b1fdd-a687-4a67-a6e9-193a9486898a/537477/badge.svg)](https://semaphoreci.com/VladimirMikhailov/library)
[![Code
Climate](https://codeclimate.com/github/VladimirMikhailov/library/badges/gpa.svg)](https://codeclimate.com/github/VladimirMikhailov/library)

The app generating and showing the fake collection of authors
and their publishments

Requirements
--

- Ruby 2.2.2
- Redis
- PostgreSQL >= 9.2

Bootstrap Application
--

- Run `bin/setup`
- Make sure you have right db connection values at `config/database.yml`


Generate Content
--

- Run `bin/seed`


Start Dev Server
--

- Run `bin/server`
