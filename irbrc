require 'irb/completion'
require 'irb/ext/save-history'

IRB.conf[:SAVE_HISTORY] = 1000
IRB.conf[:HISTORY_FILE] = "#{ENV['HOME']}/.irb-history"
IRB.conf[:PROMPT_MODE] = :SIMPLE

def o(&block) Object.new.tap {|o| o.instance_eval(&block) if block_given? } end
