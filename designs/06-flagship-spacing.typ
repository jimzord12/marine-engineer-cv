#let d = json("../content/flagship-example.json")
#let navy = rgb("102f3a")
#let teal = rgb("236a70")
#let brass = rgb("c8a579")
#let grey = rgb("546870")
#let mist = rgb("eef4f3")
#set document(title: "Alex Morgan | Second Engineer | Flagship Mechanical prototype", author: "Marine CV Studio")
#set text(font: "Source Sans 3", size: 10.5pt, fill: navy, lang: "en")
#set par(leading: 0.55em)
#set page(paper: "a4", margin: (x: 16mm, top: 12mm, bottom: 15mm),
  footer: context [#line(length: 100%, stroke: 0.5pt + brass)
  #v(2pt)#text(size: 7pt, fill: grey)[FICTIONAL CANDIDATE & AI PORTRAIT / DESIGN STUDY #h(1fr) FLAGSHIP #h(6pt) #counter(page).display("01")]],
  background: context {
    place(top + left, pdf.artifact(image(if counter(page).get().first() == 1 { "../assets/workshop-background-1.svg" } else { "../assets/workshop-background-2.svg" }, width: 210mm, height: 297mm)))
    if counter(page).get().first() == 1 {
      place(top, rect(width: 100%, height: 83mm, fill: navy, stroke: none))
    }
  })
#let screw = pdf.artifact(image("../assets/screw-bullet.svg", width: 3mm))
#set list(marker: screw, indent: 0pt, body-indent: 4pt, spacing: 3pt)
#let label(t, color: grey) = text(size: 8pt, weight: "bold", tracking: 1.1pt, fill: color)[#upper(t)]
// Shared spacing scale for the body. The portrait hero is deliberately unchanged.
#let space = (xs: 1.5mm, sm: 3mm, md: 5mm, lg: 7mm, xl: 9mm)
#let heading(n, title, sub: none) = block(above: space.lg, below: space.md)[
  #grid(columns: (12mm, 1fr), align: horizon,
    text(font: "Barlow", size: 28pt, fill: brass)[#n],
    stack(spacing: space.xs, text(size: 15pt, weight: "bold")[#title], if sub != none {text(size: 9pt, fill: grey)[#sub]}))
]
#let voyage(trip, i, compact: false) = block(breakable: false, above: 0pt, below: space.lg)[
  #grid(columns: (31mm, 1fr), column-gutter: space.md,
    block(inset: (top: 1mm))[
      #stack(spacing: space.xs,
        label("VOYAGE " + str(i)),
        stack(spacing: 0.8mm, text(size: 9pt)[#trip.start], text(size: 9pt)[#("to ")#trip.end]),
        text(font: "Barlow", size: 22pt, fill: teal)[#trip.days #text(size: 9pt, font: "Source Sans 3")[days]])
    ],
    block(stroke: (left: 2pt + teal), inset: (left: space.md, top: 2mm, bottom: 2mm))[
      #stack(spacing: 2.5mm,
        grid(columns: (1fr, auto), column-gutter: space.sm, align: horizon,
          text(size: 14pt, weight: "bold")[#trip.ship],
          box(fill: mist, inset: (x: 2mm, y: 0.8mm))[#text(size: 9pt, weight: "semibold", fill: teal)[#trip.rank]]),
        text(size: 9.5pt, fill: grey)[#trip.company / #trip.kind],
        text(size: 9pt, weight: "semibold")[#trip.engine #h(4pt) / #h(4pt) #trip.power #h(4pt) / #h(4pt) #trip.size])
      #v(space.sm)
      #text(size: 10pt)[#list(trip.description)]
    ])
]
// The nameplate overlaps the lower edge of the portrait by 4 mm.
#block(width: 100%, height: 77mm)[
  #place(top + center, dy: -10mm)[#pdf.artifact(image("../assets/crossed-spanners.svg", width: 90mm))]
  #place(top + center, dy: -2mm)[#image("../assets/porthole.svg", width: 56mm)]
  #place(top + center, dy: 3mm)[#block(width: 46mm, height: 46mm, radius: 50%, clip: true)[#image("../assets/fictional-engineer.png", width: 46mm, height: 46mm, fit: "cover", alt: "AI-generated portrait of the fictional candidate")]]
  #place(top + left, dy: 13mm)[#block(width: 54mm)[
    #set text(fill: white, size: 10pt)
    #stack(spacing: 4mm,
      [#label("Based in", color: brass) \ #d.location],
      [#label("Telephone", color: brass) \ #d.phone],
      [#label("Nationality", color: brass) \ #d.nationality])]]
  #place(top + right, dy: 13mm)[#block(width: 54mm)[
    #set align(right)
    #set text(fill: white, size: 10pt)
    #stack(spacing: 4mm,
      [#label("Email", color: brass) \ #link("mailto:"+d.email)[#d.email]],
      [#label("Availability", color: brass) \ #d.availability],
      [#label("Discipline", color: brass) \ Marine / mechanical])]]
  #place(top + center, dy: 45mm)[#block(width: 100mm, fill: rgb("f7f4ee"), inset: (x: 5mm, y: 3mm))[
    #align(center)[#stack(spacing: 2mm,
      text(font: "Barlow", weight: "semibold", size: 34pt)[#d.name],
      text(size: 11pt, tracking: 2.2pt, weight: "bold", fill: teal)[#d.rank])]]]
]
#set par(spacing: 0pt, leading: 0.6em)
#grid(columns: (1fr, 48mm), column-gutter: space.lg, align: horizon,
  [#d.profile],
  [#image("../assets/vessel-profile.svg", width: 48mm)])
#heading("01", "Sea service", sub: "One contract. One vessel. One clearly documented voyage.")
#for (i, v) in d.voyages.slice(0, 3).enumerate() { voyage(v, i+1) }
#v(space.xs)
#block(fill: navy, width: 100%, inset: (x: space.lg, y: space.md))[
 #set text(fill: white)
 #grid(columns: (1fr, 1fr, 1fr), column-gutter: 5mm,
   stack(spacing: space.xs, text(font: "Barlow", size: 25pt)[#d.total_days], label("Days at sea", color: brass)),
   stack(spacing: space.xs, text(font: "Barlow", size: 25pt)[#d.rank_days], label("Days as 2nd engineer", color: brass)),
   stack(spacing: space.xs, text(font: "Barlow", size: 25pt)[#d.voyages.len()], label("Recorded voyages", color: brass)))
]
#pagebreak()
#grid(columns: (1fr, auto), align: horizon,
  stack(spacing: 1mm, text(font: "Barlow", size: 23pt)[#d.name], label(d.rank, color: teal)),
  text(size: 9pt, fill: grey)[SEA SERVICE / CREDENTIALS])
#v(space.sm)
#line(length: 100%, stroke: 1pt + brass)
#heading("01", "Earlier sea service", sub: "Continuation of individual embarkations")
#for (i, v) in d.voyages.slice(3).enumerate() { voyage(v, i+4, compact: true) }
#heading("02", "Certificates & endorsements", sub: "Illustrative register - dates and credentials are fictional")
#set table(inset: (x: 3mm, y: 2.2mm), stroke: (left: none, right: none, top: none, bottom: 0.4pt + rgb("cfdddd")))
#text(size: 9.5pt)[
#table(columns: (1.25fr, 1.15fr, 0.65fr, 0.8fr),
 fill: (x,y) => if y == 0 {navy} else if calc.odd(y) {mist} else {white},
 table.header(..("Certificate", "Scope / record", "Issued", "Expires / review").map(t => text(fill: white, weight: "bold")[#t])),
 ..d.certificates.flatten())]
#heading("03", "Engineering toolkit")
#grid(columns: (1fr, 1fr), column-gutter: space.lg,
 ..d.skills.map(s => stack(spacing: space.sm, text(weight: "bold", fill: teal)[#s.at(0)], text(size: 10pt)[#list(s.at(1))])))
#v(space.lg)
#line(length: 100%, stroke: 0.5pt + brass)
#v(space.md)
#grid(columns: (24mm, 1fr), column-gutter: space.sm, row-gutter: space.sm,
 label("Education"), text(size: 9.5pt)[#d.education],
 label("Languages"), text(size: 9.5pt)[#d.languages])
