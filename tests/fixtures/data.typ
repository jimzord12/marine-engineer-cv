#import "../../src/data.typ": normalize-candidate, validate-candidate, duration-parts, experience-totals
#for months in (0, 1, 11, 12, 13, 138) {
  let parts = duration-parts(months)
  assert.eq(parts.years * 12 + parts.months, months)
}
#assert.eq(duration-parts(13), (years: 1, months: 1))
#assert.eq(duration-parts(138), (years: 11, months: 6))
#let candidate = normalize-candidate(json("../../content/engineer-example.json"))
#validate-candidate(candidate, true)
#assert.eq(experience-totals(candidate.companies), (months: 138, vessels: 23, companies: 6))
#let company = candidate.companies.first()
#let repeated = (..company, id: "another-company")
#assert.eq(experience-totals((company, repeated)).vessels, 6)
#assert.eq(experience-totals((company, repeated)).months, 72)
#let missing = (..company, service-months: 36, groups: company.groups.map(g => (..g, ships: g.ships.map(s => (..s, months: none)))))
#let mode = sys.inputs.at("case", default: "valid")
#if mode == "missing-visible" {
  validate-candidate((..candidate, companies: (missing,)), true)
} else if mode == "mismatch" {
  validate-candidate((..candidate, companies: ((..company, service-months: 37),)), false)
} else if mode == "negative" {
  duration-parts(-1)
} else {
  validate-candidate((..candidate, companies: (missing,)), false)
  assert.eq(experience-totals((missing,)).months, 36)
}
