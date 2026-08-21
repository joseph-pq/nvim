" Do not spell-check TeX comments (% through end of line).
syntax clear texComment
syntax match texComment '\(^\|[^\\]\)\zs%.*$' contains=@NoSpell

" Do not spell-check TeX commands (\command).
syntax match texCmdRef "\\[Tt]extcite\>" contained containedin=texOpt
      \ nextgroup=texRefOpt,texRefArg skipwhite skipnl
