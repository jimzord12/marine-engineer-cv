# Professional Skills component

Το `skills-section` συνθέτει `skills-heading` και `skill-list`. Εξάγονται από το `lib.typ`, μαζί με το `skills-layout` που ορίζει τις εσωτερικές αποστάσεις.

```typst
#import "../lib.typ": skills-section, skills-layout
#import "../themes/golden-blue.typ": theme

#skills-section(
  (("Navigation", "GMDSS"), ("Cargo handling", "Safety")),
  theme,
  title: "Professional Skills",
  bullet: (source: "/assets/captain/compass-bullet.svg"),
  geometry: (..skills-layout, column-gap: 8mm),
)
```

Κάθε εσωτερική λίστα είναι μία στήλη. Η ανάγνωση γίνεται από πάνω προς τα κάτω μέσα στη στήλη και μετά στην επόμενη. Μπορούν να δοθούν μία, δύο ή περισσότερες στήλες, με περιεχόμενο Typst ή απλό κείμενο. Τα groups πρέπει να είναι μη κενά.

Το `bullet` δέχεται οποιοδήποτε artwork descriptor του `decoration`: source, προαιρετικό opacity και θεματικούς SVG χρωματισμούς. Όταν παραλείπεται, χρησιμοποιείται απλό bullet. Οι πυξίδες είναι PDF artifacts, ενώ το κείμενο παραμένει κανονική λίστα.

Ο τίτλος ακολουθεί `theme.sizes.section-title`, τα bullets και η γραμμή τα χρώματα του theme. Το σώμα κληρονομεί τη γραμματοσειρά του εγγράφου και χρησιμοποιεί `theme.sizes.skill`, με προεπιλογή 10pt. Τα εξωτερικά περιθώρια και η θέση στη σελίδα ανήκουν στον γονέα. Το section διατηρείται ενιαίο: σε μεγάλες λίστες ο γονέας πρέπει να κατανείμει το περιεχόμενο σε περισσότερα sections/σελίδες.

Το `tests/skills.typ` καλύπτει διαφορετικούς τίτλους, 1/2/3 στήλες, αναδίπλωση κειμένου, δύο themes και SVG/απλά bullets. Δεν περιλαμβάνει προσωπικά δεδομένα υποψηφίων.
