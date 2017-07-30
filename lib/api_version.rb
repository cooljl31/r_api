class ApiVersion
  attr_reader :version, :default

  def initialize(version, default = false)
    @version, @default = version, default
  end

  def matches? request
    check_hearders(request.headers) || default
  end

  private

  def check_hearders headers
    accept = headers[:headers]
    accept && accept.include?("application/vnd.todos.#{version}+json")
  end
end
