class FooBlock < Liquify::Block
  def invoke
    "<div id=\"block-wrapper\">#{yield}</div>"
  end

  def name(params)
    "<p>#{params.first}</p>"
  end

  def email
    "<p>foo.bar@baz.com</p>"
  end

  def foo(params)
    options = params.extract_options!
    "<span>#{options['with']}</span>"
  end
end
