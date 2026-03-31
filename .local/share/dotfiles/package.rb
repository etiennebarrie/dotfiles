class Package
  def initialize(name, overrides = nil)
    @overrides = overrides.to_h { |k, v| [k.to_sym, v] }
    @overrides.default =  -name.to_str
    @overrides.freeze
    freeze
  end

  singleton_class.include Enumerable
  def self.each(...) = load.each(...)

  %i[APT Homebrew].each do |package_manager|
    define_singleton_method(package_manager) { filter_map(&package_manager) }
    define_method(package_manager)           { @overrides[package_manager] }
  end

  def self.load(path = "#{ENV.fetch("HOME")}/.config/dotfiles/packages.yaml")
    require "yaml"
    YAML
      .load_file(path)
      .fetch("packages")
      .filter_map do
        call it
      rescue ArgumentError => error
        $stderr.puts error
      end
  end

  def self.call(package, overrides = nil)
    case package
    in String
      return new(package, overrides)
    in Hash if package.size == 1
      raise ArgumentError, "unexpected overrides: #{overrides.inspect}" if overrides
      return new(*package.first)
    end
  rescue ArgumentError, NoMatchingPatternError
    raise ArgumentError, "couldn't parse package: #{package.inspect}"
  end
end

if __FILE__ == $0
  require "minitest"
  include Minitest::Assertions
  singleton_class.attr_accessor :assertions
  @assertions = 0

  name = Object.new
  def name.to_str = "bash"
  overrides = Object.new
  def overrides.to_h = { Homebrew: "bash@5" }
  [
    Package.("bash", Homebrew: "bash@5"),
    Package.("bash", [["Homebrew", "bash@5"]]),
    Package.({ "bash" => { "Homebrew" => "bash@5" }}),
    Package.new(name, overrides)
  ].each do |package|
    assert_equal "bash@5", package.Homebrew
    assert_equal "bash", package.APT
  end
end
