#import "@preview/polylux:0.3.1": *
#import "@preview/fontawesome:0.1.0": *

#import themes.metropolis: *

#show: metropolis-theme.with(
  aspect-ratio: "16-9",
  footer: [Optional Footnote]
)

#set text(font: "Inter", weight: "light", size: 20pt)
#show math.equation: set text(font: "Fira Math")
#set strong(delta: 350)
#set par(justify: true)

#set raw(tab-size: 4)
#show raw.where(block: true): block.with(
  fill: luma(240),
  inset: 1em,
  radius: 0.7em,
  width: 100%,
)


#let author = box[
  #table(inset: 0.5em, stroke: none, columns: (1fr, 4fr),  align: (left, left),
    [*Davide Domini*], [davide.domini\@unibo.it],
    [Gianluca Aguzzi], [gianluca.aguzzi\@unibo.it],
    [Lukas Esterle], [lukas.esterle\@ece.au.dk],
    [Mirko Viroli], [mirko.viroli\@unibo.it]
  )
]


#title-slide(
  title: "Field-based Coordination for Federated Learning",
  subtitle: "Talk @ COORDINATION 2024",
  author: author, //"Davide Domini, Gianluca Aguzzi, Lukas Esterle, Mirko Viroli",
  //date: datetime.today().display("[day] [month repr:long] [year]"),
)

#new-section-slide("Slide section 1")

#slide(title: "Slide")[
  *Bold* and _italic_ text.
  
  This is a citiation @nicolas_farabegoli_2024_10535841.

  #alert[
    This is an alert.
  ]
]

#slide(title: "Code slide")[
  ```kotlin
  fun main() {
      println("Hello, world!")

      for (i in 0..9) {
          println(i)
      }
      println("Goodbye, world!")
  }
  ```
]

#slide[
  = This is a title

  #lorem(24)

  == This is a subtitle

  #lorem(34)
]

#slide[

  == Icon in a title #fa-java()

  #fa-icon("github", fa-set: "Brands") -- Github icon

  #fa-icon("github", fa-set: "Brands", fill: blue) -- Github icon blue fill
]

#slide[
  #bibliography("bibliography.bib")
]
