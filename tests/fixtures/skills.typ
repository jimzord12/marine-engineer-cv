#import "../../lib.typ": skills-section
#import "../../themes/golden-blue.typ": theme
#import "../../themes/silver-bridge.typ": theme as silver
#set page(paper: "a4", margin: 16mm)
#set text(font: theme.fonts.body)
#skills-section((("Navigation", "A longer skill that should wrap naturally within its column without losing its bullet"), ("Cargo handling", "GMDSS")), theme,
  bullet: (source: "/assets/captain/compass-bullet.svg"))
#v(10mm)
#skills-section((("One column", "Plain bullet"),), silver, title: "Technical Skills")
#v(10mm)
#skills-section((("First",), ("Second",), ("Third",)), silver, title: "Three columns",
  bullet: (source: "/assets/captain/compass-bullet.svg"))
