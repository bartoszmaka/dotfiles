require 'nokogiri'
require 'pry'

class Parser
  attr_accessor :path

  def initialize(path)
    @path = path
  end

  def parse
    labels.zip(entries).map do |label_node, entry_node|
      LineParser.new(label_node, entry_node).parsed_line
    end
  end

  private

  def labels
    @labels = doc.xpath('//plist/dict/key')
  end

  def entries
    @entries = doc.xpath('//plist/dict/dict')
  end

  def file
    @file ||= File.open(path, 'r')
  end

  def doc
    @doc ||= Nokogiri::XML(file)
  end

  class LineParser
    attr_accessor :label_node, :entry_node

    def initialize(label_node, entry_node)
      @label_node = label_node
      @entry_node = entry_node
    end

    def parsed_line
      "#{label} \t##{parsed_hex_values}"
    end

    private

    def label
      @label ||= label_node
        .text
        .gsub('Ansi','')
        .split
        .reverse
        .join
        .downcase
    end

    def relevant_node_text
      @relevant_node_text ||= entry_node
        .text
        .lines[3..-1]
    end

    def relevant_node_values
      @relevant_node_values ||= relevant_node_text
        .map.with_index { |x, i| relevant_node_text[i + 1] if x.match?(/Red|Green|Blue/) }
        .compact
    end

    def parsed_hex_values
      @parsed_hex_values ||= relevant_node_values
        .reverse
        .map { |value| (value.to_f * 255).round.to_s(16).rjust(2, '0') }
        .join
    end
  end
end

puts Parser.new(ARGV[0]).parse
