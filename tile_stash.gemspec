# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{tile_stash}
  s.version = "0.0.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Aubrey Holland"]
  s.date = %q{2009-06-02}
  s.description = %q{Hooya!}
  s.email = %q{aubreyholland@gmail.com}
  s.extra_rdoc_files = [
    "README.rdoc"
  ]
  s.files = [
    ".gitignore",
     "CHANGELOG",
     "README.rdoc",
     "Rakefile",
     "VERSION",
     "lib/tile_stash.rb",
     "lib/tile_stash/core_extensions.rb",
     "lib/tile_stash/disk_cache.rb",
     "lib/tile_stash/layer.rb",
     "lib/tile_stash/mapnik_layer.rb",
     "lib/tile_stash/response.rb",
     "lib/tile_stash/stash.rb",
     "lib/tile_stash/stash_configuration.rb",
     "lib/tile_stash/tile.rb",
     "lib/tile_stash/tms_service.rb",
     "script/console",
     "spec/configs/config1.yml",
     "spec/configs/config2.yml",
     "spec/configs/config3.yml",
     "spec/custom_matchers.rb",
     "spec/disk_cache_spec.rb",
     "spec/mounting_spec.rb",
     "spec/spec_helper.rb",
     "spec/stash_configuration_spec.rb",
     "spec/stash_spec.rb",
     "spec/tms_spec.rb",
     "tasks/rcov.rake",
     "tasks/spec.rake"
  ]
  s.homepage = %q{http://github.com/aub/tile_stash/tree/master}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.3}
  s.summary = %q{A tile caching tool for rack-based web frameworks.}
  s.test_files = [
    "spec/custom_matchers.rb",
     "spec/disk_cache_spec.rb",
     "spec/mounting_spec.rb",
     "spec/spec_helper.rb",
     "spec/stash_configuration_spec.rb",
     "spec/stash_spec.rb",
     "spec/tms_spec.rb"
  ]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end
