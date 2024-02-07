#import "@preview/commute:0.2.0": node, arr, commutative-diagram
#import "@preview/bob-draw:0.1.0": render

// The project function defines how your document looks.
// It takes your content and some metadata and formats it.
// Go ahead and customize it to your liking!
#let project(
  title: "",
  authors: (),
  date: none,
  logo: none,
  body,
) = {
  // Set the document's basic properties.
  set document(author: authors.map(a => a.name), title: title)
  set page(
    margin: (left: 25mm, right: 25mm, top: 25mm, bottom: 20mm),
    numbering: "1",
    number-align: start,
  )

  // Save heading and body font families in variables.
  let body-font = "Sarasa Mono SC"
  let sans-font = "更紗黑體 CL"

  // Set body font family.
  set text(font: body-font, lang: "zh")
  show heading: set text(font: sans-font)
  set heading(numbering: "1.1")

  // Set run-in subheadings, starting at level 3.
  show heading: it => {
    if it.level > 2 {
      parbreak()
      text(11pt, style: "italic", weight: "regular", it.body + ".")
    } else {
      it
    }
  }

  show raw: it => {
    set text(font: ("Fira Code", "等距更紗黑體 Slab CL"))
    stack(dir: ttb, ..it.lines)
  }
  show raw.line: it => {
    box(
      width: 100%,
      height: 1.75em,
      inset: 0.25em,
      fill: rgb(0 ,0 ,0, 10),
      align(horizon, stack(
        dir: ltr,
        box(width: 15pt)[#it.number],
        it.body,
      ))
    )
  }


  // Title page.
  // The page can contain a logo if you pass one with `logo: "logo.png"`.
  v(0.6fr)
  if logo != none {
    align(right, image(logo, width: 26%))
  }
  v(9.6fr)

  text(1.1em, date)
  v(1.2em, weak: true)
  text(font: sans-font, 2em, weight: 700, title)

  // Author information.
  pad(
    top: 0.7em,
    right: 20%,
    grid(
      columns: (1fr,) * calc.min(3, authors.len()),
      gutter: 1em,
      ..authors.map(author => align(start)[
        *#author.name* \
        #author.email
      ]),
    ),
  )

  v(2.4fr)
  pagebreak()

  // Table of contents.
  outline(depth: 3, indent: true)
  pagebreak()


  // Main body.
  set par(justify: true)

  body
}
