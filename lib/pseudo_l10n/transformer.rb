# frozen_string_literal: true

module PseudoL10n
  module Transformer
    module_function

    MARKER = "√"
    TEMPLATE = "%{marker}%{msg}%{marker}"

    ESCAPE_PATTERN =
      Regexp.new(
        "(#{
          ["<.*?>", "{{.*?}}", "%{.*?}", "https?://\\S+", "&\\S*?;"].join("|")
        })"
      )

    def call(original, key: [])
      return original if ignore_key?(key)
      if original.is_a?(Hash)
        original
          .map do |next_key, value|
            [next_key, call(value, key: key + [next_key])]
          end
          .to_h
      elsif original.is_a?(Array)
        original.map { |value| call(value) }
      elsif original.is_a?(String)
        result = original
        result = lengthen_string(result)
        mark_string(result)
      else
        original
      end
    end

    def mark_string(string)
      format(TEMPLATE, marker: MARKER, msg: string)
    end

    def lengthen_string(string)
      parts =
        string
          .split(ESCAPE_PATTERN)
          .map do |part|
            part.match?(ESCAPE_PATTERN) ? part : half_to_full_width(part)
          end

      parts.join
    end

    def half_to_full_width(string)
      string.tr("0-9a-zA-Z", "０-９ａ-ｚＡ-Ｚ")
    end

    def ignore_key?(key_parts)
      key = key_parts.join(".")
      PseudoL10n.ignored_keys.any? do |pattern|
        case pattern
        when String, Symbol
          File.fnmatch(pattern.to_s, key)
        when Regexp
          key =~ pattern
        end
      end
    end
  end
end
