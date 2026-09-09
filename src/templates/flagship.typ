#import "../data.typ": normalize-candidate, validate-candidate, experience-totals
#import "../theme.typ": validate-theme
#import "../hero.typ": hero
#import "../experience.typ": experience-section
#import "../sections.typ": profile-summary, section-heading, synopsis
#import "../certificates.typ": certificates-section
#import "../education.typ": education-languages-section
#import "../page.typ": document-shell, page-header

#let validate-pages(pages, companies) = {
  let indices = pages.map(p => p.companies).flatten()
  assert.eq(indices.sorted(), range(companies.len()), message: "Page plan must include each company once")
  let synopses = pages.enumerate().filter(((i, p)) => p.at("synopsis", default: false))
  assert.eq(synopses.len(), 1, message: "Page plan requires exactly one synopsis")
  let final-experience = pages.enumerate().filter(((i, p)) => p.companies.len() > 0).last().at(0)
  assert.eq(synopses.first().at(0), final-experience, message: "Synopsis must follow the final Experience page")
}

#let flagship(body, candidate: none, theme: none, artwork: none, layout: none, show-vessel-durations: true) = {
  assert(candidate != none and theme != none and artwork != none and layout != none,
    message: "flagship requires candidate, theme, artwork and layout")
  let d = normalize-candidate(candidate)
  validate-theme(theme)
  validate-candidate(d, show-vessel-durations)
  validate-pages(layout.pages, d.companies)
  document-shell(d, theme, artwork, layout)[
    #for (i, page-plan) in layout.pages.enumerate() {
      if i > 0 {pagebreak()}
      set page(margin: if i == 0 {layout.opening-margin} else {layout.continuation-margin})
      if i == 0 {hero(d.identity, d.contacts, theme, artwork, layout.hero)}
      set par(spacing: 0pt, leading: theme.leading.body)
      if i > 0 {page-header(d.identity, d.copy.page-caption, theme, layout.header)}
      if i == 0 {profile-summary(d.profile, artwork.at("profile-illustration", default: none), theme, layout.profile)}
      if page-plan.companies.len() > 0 {
        section-heading("01", d.copy.experience, theme, layout.headings,
          if i == 0 {layout.headings.opening} else {layout.headings.continuation},
          subtitle: if i == 0 {d.copy.experience-subtitle} else {d.copy.continuation})
        experience-section(page-plan.companies.map(index => d.companies.at(index)), theme, layout.experience,
          if i == 0 {layout.experience.opening} else {layout.experience.continuation}, show-vessel-durations, d.copy.combined)
      }
      if page-plan.at("synopsis", default: false) {synopsis(experience-totals(d.companies), d.copy, theme, layout.synopsis)}
      if page-plan.at("certificates", default: false) and d.certificates.len() > 0 {certificates-section(d.certificates, d.copy, theme, layout)}
      if page-plan.at("education", default: false) and (d.education.len() + d.languages.len() > 0) {
        if layout.anchor-education {v(1fr)}
        education-languages-section(d.education, d.languages, d.copy, theme, layout)
      }
    }
    #body
  ]
}
