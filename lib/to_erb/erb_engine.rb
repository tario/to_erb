# Fork of https://gist.github.com/17371
require "haml"
require "ruby_parser"
require "ruby2ruby"

module Haml
  class Buffer
    def extended_attributes(class_id, obj_ref, *attributes_hashes)
      attributes = class_id
      attributes_hashes.each do |old|
        self.class.merge_attrs(attributes, to_hash(old.map {|k, v| [k.to_s, v]}))
      end

      self.class.merge_attrs(attributes, parse_object_ref(obj_ref)) if obj_ref

      str_attrs = []
      attributes.each do |k,v|
        value = if Sexp === v
          "<%= #{Ruby2Ruby.new.process v} %>"
        else
          v.gsub("'","\\'")
        end

        str_attrs << "#{k}=#{value}"
      end   

      str_attrs.join(" ")
    end  
  end
end

class ErbEngine < Haml::Engine
  def initialize(*args)
    @rubyparser = RubyParser.new
    super(*args)
  end

  def push_script(text, preserve_script, in_tag = false, preserve_tag = false,
                  escape_html = false, nuke_inner_whitespace = false)
    push_text "<%= #{text.strip} %>"
  end
  
  def push_silent(text, can_suppress = false)
    push_text "<% #{text.strip} %>"
  end

  def push_generated_script(text)
    sexp = @rubyparser.parse text
    if sexp.node_type == :call and sexp[2] == :attributes
      sexp[2] = :extended_attributes
      arglist = sexp[3]
      last_hash_arg = arglist[3]
      
      (1..(last_hash_arg.size-1)/2).each do |i|
        last_hash_arg[i*2] = @rubyparser.parse(last_hash_arg[i*2].to_s) 
      end
      text = Ruby2Ruby.new.process sexp
    end

    super(text)
  end
end

