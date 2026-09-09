# Η βιβλιοθήκη Marine CV

Το ενεργό entry point είναι το `lib.typ`. Το `main.typ` ανοίγει το engineer παράδειγμα. Η αναφορά `designs/11-flagship-balance.typ` και το PDF v11 είναι κλειδωμένα: δεν τα χρησιμοποιούμε ως χώρο πειραματισμού.

Η βιβλιοθήκη αποτελείται από μικρές Typst functions που παράγουν περιεχόμενο. Δεν απαιτεί React, εξωτερικό framework ή online υπηρεσία.

## Πέντε ανεξάρτητα inputs

| Input | Αρχείο / ρόλος |
|---|---|
| Candidate | `content/engineer-example.json` ή `content/captain-example.json`: πραγματικά δεδομένα, labels και εμφανιζόμενο κείμενο |
| Theme | `themes/flagship.typ`, `themes/silver-bridge.typ`: χρώματα, fonts, μεγέθη, tracking, leading και αποχρώσεις SVG |
| Artwork | `roles/engineer.typ`, `roles/captain.typ`: SVG ανά θέση και μικρές διορθώσεις width/x/y/opacity |
| Layout | `layouts/flagship-v11.typ`: margins, hero geometry, gaps, πυκνότητα εταιρειών/γραμμών, page allocations |
| Display option | `show-vessel-durations`: εμφανίζει ή αποκρύπτει όλους τους χρόνους πλοίων, χωρίς αλλαγή στηλών |

Το `flagship` δέχεται αυτά τα inputs, ελέγχει τα δεδομένα και συνθέτει το έγγραφο. Τα παιδιά δεν διαβάζουν JSON και δεν έχουν διακλαδώσεις ανά επαγγελματικό ρόλο.

## Σύνθεση components

```text
flagship → document-shell
  ├─ hero
  │   ├─ portrait-backdrop + portrait-frame + portrait
  │   ├─ contact-group → contact-item → label
  │   └─ identity-plate + decorations
  ├─ profile-summary
  ├─ section-heading + experience-section
  │   └─ company-experience
  │       ├─ company-period → duration
  │       └─ vessel-type-group → vessel-row cells
  ├─ synopsis → metric + duration-value
  ├─ certificates-section → certificate-table
  └─ education-languages-section
      ├─ education-entry
      └─ language-entry
```

PageHeader/PageFooter/PageBackground βρίσκονται στο `src/page.typ`. Η καθαρή λογική δεδομένων στο `src/data.typ`, η κατανομή εταιρειών σε σελίδες στο `src/pagination.typ`. Τα συγγενικά components μένουν στο ίδιο μικρό module.

## Ποιος ορίζει τις αποστάσεις

Ο γονέας ορίζει τα εξωτερικά κενά. Το παιδί ορίζει την εσωτερική διάταξη χρησιμοποιώντας το layout input του. Η επιλογή opening/continuation spacing γίνεται στη σύνθεση σελίδας. Το Education section δεν αποφασίζει μόνο του να κατέβει χαμηλά: αυτό γίνεται από το `anchor-education` και το ελαστικό κενό του template.

Στις γραμμές πλοίων, ο γονέας έχει ένα κοινό grid τριών στηλών. Το VesselRow επιστρέφει τα cells. Όταν κρύβονται οι χρόνοι, η τρίτη στήλη παραμένει γεωμετρικά παρούσα, χωρίς κείμενο στο PDF. Δεν μετακινείται ο βαθμός. Όταν είναι διαθέσιμος ο αναλυτικός χρόνος, μετριέται και το ύψος του, ώστε ακόμη και ένας χρόνος που αναδιπλώνεται να μη μετακινεί τις επόμενες γραμμές.

## Δεδομένα και σύνοψη

Οι μήνες είναι χρόνος υπηρεσίας, όχι διαφορά ημερολογιακών περιόδων. Κάθε εταιρεία έχει μοναδικό ID και κάθε πλοίο σταθερό ID. Ίδιο πλοίο σε δύο rows διαφορετικού βαθμού ή εταιρείας μετρά μία φορά στο πλήθος πλοίων, ενώ οι μήνες προστίθενται.

Αν δεν υπάρχουν χρόνοι ανά πλοίο, το hidden mode δέχεται `service-months` στην εταιρεία. Δεν μετατρέπει άγνωστο χρόνο σε μηδέν. Αν υπάρχουν όλοι οι αναλυτικοί μήνες και company total, απαιτεί να συμφωνούν. Τα page fragments δεν ξαναϋπολογίζουν τα σύνολα από τα εμφανιζόμενα υποσύνολα.

## Σελιδοποίηση με οπτικό έλεγχο

Το page plan κατανέμει ρητά εταιρείες ή τμήματα εταιρειών. Ελέγχεται ότι κάθε vessel row εμφανίζεται ακριβώς μία φορά, με την αρχική σειρά. Το Synopsis ανήκει στην τελευταία σελίδα Experience. Αν η σύνθεση δημιουργήσει επιπλέον σελίδα, δίνεται μήνυμα overflow και ζητείται αλλαγή στο page plan, όχι αυτόματη σμίκρυνση γραμμάτων.

Οι φυσιολογικές εταιρείες παραμένουν ενιαία blocks. Μεγάλες εταιρείες χωρίζονται ρητά με row ranges και εμφανίζουν ένδειξη συνέχειας. Ο πίνακας πιστοποιητικών επαναλαμβάνει την κεφαλίδα αν συνεχιστεί σε άλλη σελίδα. Σε πλήρες CV, η προβλεπόμενη κατανομή πρέπει να εγκρίνεται από τον page-count check και τον οπτικό έλεγχο.

## Επαλήθευση

`tests/run.py` εκτελεί τις δοκιμές δεδομένων, υπερχείλισης, κρυφών χρόνων, εταιρειών σε συνέχεια, προαιρετικών πεδίων και διαφορετικών themes. Το engineer συγκρίνεται με v11 σε 144 dpi και normalized text ανά σελίδα. Ελέγχονται embedded fonts, όρια σελίδας και hashes των frozen αρχείων.

Το τελικό PDF εξακολουθεί να χρειάζεται οπτική ματιά όταν αλλάζει ουσιαστικά το περιεχόμενο. Οι έλεγχοι εξαγωγής κειμένου και τα PDF artifacts δεν αποτελούν εμπορική πιστοποίηση ATS.

Για την παραμετρική απόδοση SVG χρησιμοποιείται το επίσημο API [Typst image / bytes](https://typst.app/docs/reference/visualize/image/). Τα SVG χρωματίζονται στη μνήμη, χωρίς τροποποίηση των αρχικών αρχείων.
