#import "../lib.typ": flagship
#import "../themes/golden-blue.typ": theme
#import "../artwork/captain.typ": artwork
#import "../layouts/flagship-v11.typ": layout
#let candidate = json("../content/captain-example.json")
#show: flagship.with(candidate: candidate, theme: theme, artwork: artwork, layout: layout,
  show-vessel-durations: sys.inputs.at("vessel-durations", default: "true") == "true")
