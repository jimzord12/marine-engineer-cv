#import "../themes/flagship.typ": theme
#import "../layouts/flagship-v11.typ": layout
#import "../roles/engineer.typ": artwork
#import "../src/theme.typ": validate-theme
#validate-theme(theme)
#assert.eq(layout.hero.height, 77mm)
#assert.eq(layout.continuation-margin.bottom, 11mm)
#assert.eq(artwork.portrait-backdrop.width, 94mm)
