Pry.config.editor = 'nvim'

def caller_local
  caller.reject { |x| x.include?('.rvm') || x.include?('.asdf') }
end

def exit1
  exit!
end

def exut!
  exit!
end

def test_exception
  yield
rescue e =>
  binding.pry
end


## Formatting SQL strings
class String
  SQL_JOINS = (%w[LEFT RIGHT FULL].reduce([]) do |accum, join_type|
    accum << "#{join_type} JOIN" << "#{join_type} OUTER JOIN"
  end << 'INNER JOIN').freeze
  SQL_COMMANDS = SQL_JOINS +
                 %w[SELECT
                    FROM
                    DISTINCT
                    WHERE
                    AND
                    GROUP\ By
                    ORDER
                    HAVING
                    INSERT
                    UPDATE
                    DELETE].freeze

  def f
    formatted = SQL_COMMANDS.inject(self) do |string, command|
      string.gsub(/#{command}/i, command)
            .gsub(/ #{command}/, "\n#{command}")
    end

    if formatted.starts_with?('SELECT')
      temp = formatted.split(',').map(&:strip)
      temp [1..-1] = temp[1..-1].map do |string|
        string = ' ' * 7 + string
      end
      formatted = temp.join(",\n")
    end

    puts formatted

    formatted
  end
end

if defined? ActiveRecord::Relation
  ActiveRecord::Relation.delegate :f, to: :to_sql
end
