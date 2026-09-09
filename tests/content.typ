#import "../themes/flagship.typ": theme
#import "../layouts/flagship-v11.typ": layout
#import "../src/data.typ": normalize-candidate, experience-totals
#import "../src/experience.typ": experience-section
#import "../src/sections.typ": synopsis
#import "../src/certificates.typ": certificates-section
#import "../src/education.typ": education-languages-section
#let d = normalize-candidate(json("../content/extended-company-example.json"))
#set text(font: theme.fonts.body, size: theme.sizes.body, fill: theme.colors.ink, lang: "en")
#set par(spacing: 0pt, leading: theme.leading.body)
#set page(paper: "a4", margin: 16mm)
#experience-section(d.companies.slice(0, 1), theme, layout.experience, layout.experience.opening, sys.inputs.at("times", default: "true") == "true", d.copy.combined)
#synopsis(experience-totals(d.companies), d.copy, theme, layout.synopsis)
#certificates-section(d.certificates, d.copy, theme, layout)
#education-languages-section(d.education, d.languages, d.copy, theme, layout)
