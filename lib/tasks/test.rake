task "test:javascripts" => "konacha:run"
task "test" => %w[test:units test:functionals test:integration test:javascripts]
