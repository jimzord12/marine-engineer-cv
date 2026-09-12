#import "../lib.typ": flagship
#import "../themes/golden-blue.typ": theme
#import "../artwork/engineer.typ": artwork
#import "../layouts/flagship-v11.typ": layout
#let candidate = json("../content/engineer-example.json")
#show: flagship.with(candidate: candidate, theme: theme, artwork: artwork, layout: layout,
  show-vessel-durations: sys.inputs.at("vessel-durations", default: "true") == "true")
