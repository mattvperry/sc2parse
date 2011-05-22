# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run 'rake gemspec'
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{sc2parse}
  s.version = "0.1.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Matthew Perry"]
  s.date = %q{2011-05-22}
  s.description = %q{
    Ruby library to parse data from Starcraft II replay files. Provides
    and interface for reading data about Starcraft II games from their
    replay files.
  }
  s.email = %q{perrym5@rpi.edu}
  s.executables = ["sc2parse"]
  s.extra_rdoc_files = [
    "LICENSE.txt",
    "README.markdown"
  ]
  s.files = [
    ".document",
    "Gemfile",
    "Gemfile.lock",
    "LICENSE.txt",
    "README.markdown",
    "Rakefile",
    "VERSION",
    "bin/sc2parse",
    "lib/sc2parse.rb",
    "lib/sc2parse/bitstream.rb",
    "lib/sc2parse/parsers.rb",
    "lib/sc2parse/parsers/replay_details.rb",
    "lib/sc2parse/serial_data.rb",
    "test/fixtures/replay.sc2replay",
    "test/helper.rb",
    "test/test_sc2parse.rb"
  ]
  s.homepage = %q{http://github.com/perrym5/sc2parse}
  s.licenses = ["MIT"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.7.2}
  s.summary = %q{Ruby library to parse data from Starcraft II replay files}

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<ruby-libmpq>, [">= 0"])
      s.add_development_dependency(%q<bundler>, ["~> 1.0.0"])
      s.add_development_dependency(%q<jeweler>, ["~> 1.6.0"])
    else
      s.add_dependency(%q<ruby-libmpq>, [">= 0"])
      s.add_dependency(%q<bundler>, ["~> 1.0.0"])
      s.add_dependency(%q<jeweler>, ["~> 1.6.0"])
    end
  else
    s.add_dependency(%q<ruby-libmpq>, [">= 0"])
    s.add_dependency(%q<bundler>, ["~> 1.0.0"])
    s.add_dependency(%q<jeweler>, ["~> 1.6.0"])
  end
end
