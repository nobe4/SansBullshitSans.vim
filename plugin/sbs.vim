let s:bs_abbreviations = ['bs', 'b.s.', 'bullshit', 'bull fucking shit']

" http://ngenworks.com/culture/250-buzzwords-we-love-to-hate/
let s:buzzwords = [
      \ "accelerate", "accountability", "action items", "actionable", "aggregator", "agile", "algorithm",
      \ "alignment", "analytics", "at the end of the day", "B2B", "B2C", "bandwidth", "below the fold",
      \ "best of breed", "best practices", "beta", "big data", "bleeding edge", "blueprint", "boil the ocean",
      \ "bottom line", "bounce rate", "brand evangelist", "bricks and clicks", "bring to the party",
      \ "bring to the table", "brogrammer", "BYOD", "change agent", "clickthrough", "close the loop",
      \ "codify", "collaboration", "collateral", "come to Jesus", "content strategy", "convergence",
      \ "coopetition", "create value", "credibility", "cross the chasm", "cross-platform", "cross-pollinate",
      \ "crowdfund", "crowdsource", "curate", "cutting-edge", "data mining", "deep dive", "design pattern",
      \ "digital divide", "digital natives", "discovery", "disruptive", "diversity", "DNA", "do more with less",
      \ "dot-bomb", "downsizing", "drink the Kool Aid", "DRM", "e-commerce hairball", "eat your own dog food",
      \ "emerging", "empathy", "enable", "end-to-end", "engagement", "engaging", "enterprise", "entitled",
      \ "epic", "evangelist", "exit strategy", "eyeballs", "face time", "fail fast", "fail forward", "fanboy",
      \ "finalize", "first or best", "flat", "flow", "freemium", "funded", "funnel", "fusion", "game changer",
      \ "gameify", "gamification", "glamour metrics", "globalization", "green", "groupthink", "growth hack",
      \ "guru", "headlights", "heads down", "herding cats", "high level", "holistic", "homerun", "html5",
      \ "hyperlocal", "iconic", "ideation", "ignite", "immersive", "impact", "impressions", "in the weeds",
      \ "infographic", "innovate", "integrated", "jellyfish", "knee deep", "lean", "lean in",
      \ "let's shake it and see what falls off", "let's socialize this", "let's table that", "level up", "leverage",
      \ "lizard brain", "long tail", "low hanging fruit", "make it pop", "make the logo bigger", "maker",
      \ "marketing funnel", "mashup", "milestone", "mindshare", "mobile-first", "modernity", "monetize",
      \ "moving forward", "multi-channel", "multi-level", "MVP", "netiquette", "next gen", "next level",
      \ "ninja", "no but", "yes if", "offshoring", "on the runway", "open the kimono", "operationalize",
      \ "opportunity", "optimize", "organic", "out of pocket", "outside the box", "outsourcing", "over the top",
      \ "paradigm shift", "patent pending design", "peeling the onion", "ping", "pipeline", "pivot", "pop",
      \ "portal", "proactive", "productize", "proof of concept", "public facing", "pull the trigger",
      \ "push the envelope", "put it in the parking lot", "qualified leads", "quick-win", "reach out",
      \ "Ready. Fire. Aim.", "real time", "rearranging the deck chairs on the Titanic", "reimagining", "reinvent the wheel",
      \ "responsive", "revolutionize", "rich", "rightshoring", "rightsizing", "rockstar", "ROI",
      \ "run it up the flagpole", "scalability", "scratch your own itch", "scrum", "sea change", "seamless",
      \ "SEM", "SEO", "sexy", "shift", "sizzle", "slam dunk", "social currency", "social media",
      \ "social media expert", "social proof", "soft launch", "solution", "stakeholder", "standup", "startup",
      \ "stealth mode", "stealth startup", "sticky", "storytelling", "strategery", "strategy", "sustainability",
      \ "sweat your assets", "synergy", "take it offline", "team building", "tee off", "the cloud", "thought leader",
      \ "tiger team", "tollgate", "top of mind", "touch base", "touchpoints", "transgenerate", "transparent",
      \ "trickthrough", "uber", "unicorn", "uniques", "unpack", "user", "usercentric", "value proposition",
      \ "value-add", "vertical cross-pollination", "viral", "visibility", "vision", "Web 2.0", "webinar",
      \ "what is our solve", "what's the ask?", "win-win", "wizard"]

function! s:MakeConceal()

  for l:buzzword in s:buzzwords
    " Get the corresponding bullshit word, based on the buzzword length
    " Will fail for long buzzword, that's fine, default to the last one.
    try
      let l:bs_word = s:bs_abbreviations[len(l:buzzword) / 4]
    catch
      let l:bs_word = s:bs_abbreviations[-1]
    endtry

    " Slices are groups of buzzword-bullshit letters to conceal together:
    "  epic -> b.s.
    "  [
    "   ['e', 'b'], ['p', '.'],
    "   ['i', 's'], ['c', '.'],
    "  ]
    let l:slices = []
    let l:i = 0
    while l:i < len(l:bs_word) - 1
      call add(l:slices, [l:buzzword[l:i], l:bs_word[l:i]])
      let l:i += 1
    endwhile
    " The last element will have the remainings chars, depending on the lenght
    " difference between the buzzword and the bullshit word.
    call add(l:slices, [l:buzzword[len(l:bs_word)-1:], l:bs_word[-1:]])

    " Clean the buzzword for group making
    let l:buzzword_clean = substitute(l:buzzword, "[ '-.?]" , '', 'g')

    " Record all buzzowrd groups
    let l:buzzword_groups = []

    " Register the current group name, minus the index
    let l:group_name = 'Group_'. l:buzzword_clean . '_'

    let l:i = 0
    while l:i < len(l:slices)
      " Generate a next group so taht the matching is restricted more to one
      " sequence of letter in particular.
      let l:next_group = ''
      if l:i < len(l:slices) - 1
        let l:next_group = ' nextgroup=' . l:group_name . (l:i + 1) . ' '
      endif

      " Save the current group.
      call add(l:buzzword_groups, l:group_name . l:i)

      " Register the new syntax matching, with the group, next group, slice
      " char and slice conceal char(s).
      execute 'syn match ' . l:group_name . l:i . l:next_group . ' contained /'. l:slices[l:i][0].'/ conceal cchar='.l:slices[l:i][1]

      let l:i += 1
    endwhile

    " Finally execute the syntax matchting for the word and contain all
    " groups.
    execute 'syn match ' . l:buzzword_clean . ' /' . l:buzzword  .'/ contains='. join(l:buzzword_groups, ',')
  endfor

  " Conceal default: always display the concealed word.
  set conceallevel=1 concealcursor=nvic
  hi conceal ctermfg=black ctermbg=white guifg=black guibg=white
endfunction

" Run this once, on Vim enter.
autocmd VimEnter * call <SID>MakeConceal()
