# frozen_string_literal: true

module PseudoL10n
  module Transformer
    module_function

    MARKER = "√"
    TEMPLATE = "%{marker}%{msg}%{marker}"

    ESCAPE_PATTERN =
      Regexp.new(
        "(#{
          [
            "<.*?>",
            "{{.*?}}",
            "%{.*?}",
            "https?:\/\/\\S+",
            "&\\S*?;"
          ].join('|')
        })"
      )

    def call(original)
      if original.is_a?(Hash)
        original.transform_values { |value| call(value) }
      elsif original.is_a?(Array)
        original.map { |value| call(value) }
      elsif original.is_a?(String)
        result = original
        result = lengthen_string(result)
        result = mark_string(result)
        result
      else
        original
      end
    end
  
    def mark_string(string)
      format(TEMPLATE, marker: MARKER, msg: string)
    end

    def lengthen_string(string)
      parts = 
        string.split(ESCAPE_PATTERN).map do |part|
          if part.match?(ESCAPE_PATTERN)
            part
          else
            half_to_full_width(part)
          end
        end

      parts.join
    end

    def half_to_full_width(string)
      string.tr('0-9a-zA-Z', '０-９ａ-ｚＡ-Ｚ')
    end
  end
end
