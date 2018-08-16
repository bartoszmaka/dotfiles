def caller_local
  caller.reject { |x| x.include? '.rvm'}
end

