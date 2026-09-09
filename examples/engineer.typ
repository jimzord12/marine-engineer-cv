#import "../lib.typ": flagship
#import "../themes/flagship.typ": theme
#import "../roles/engineer.typ": artwork
#import "../layouts/flagship-v11.typ": layout
#let candidate = json("../content/engineer-example.json")
#show: flagship.with(candidate: candidate, theme: theme, artwork: artwork, layout: layout,
  show-vessel-durations: sys.inputs.at("vessel-durations", default: "true") == "true")
