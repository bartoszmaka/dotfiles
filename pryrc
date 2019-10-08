Pry.config.editor = 'nvim'

def caller_local
  caller.reject { |x| x.include?('.rvm') || x.include?('.asdf') }
end

def exit1
  exit!
end

def test_exception
  yield
rescue e =>
  binding.pry
end
