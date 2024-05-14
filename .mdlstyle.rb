all
exclude_rule "MD014" # shell commands often have no output
rule "MD026", punctuation: ".,;:!" # allow question mark in headers
rule "MD013", line_length: 120
rule "MD029", style: :ordered
