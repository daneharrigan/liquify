class FooTag < Liquify::Tag
  def invoke(params)
    options = params.extract_options!
    output = params.first
    output << ' ' << options['bar'] if options['bar']
    output << ' ' << options['user']['first_name'] if options['user']
    return output
  end
end
