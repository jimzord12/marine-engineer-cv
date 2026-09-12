#import "../../themes/golden-blue.typ": theme
#import "../../layouts/flagship-v11.typ": layout
#import "../../src/certificates.typ": certificate-table
#set text(font: theme.fonts.body, size: theme.sizes.body)
#set page(paper: "a4", margin: 16mm)
#let records = range(50).map(i => (title: "Certificate " + str(i+1), scope: "Illustrative training record", issued: "2024", review: "2029"))
#certificate-table(records, ("Certificate", "Scope / record", "Issued", "Expires / review"), theme, layout.certificates)
