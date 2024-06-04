#import "@preview/polylux:0.3.1": *
#import "@preview/fontawesome:0.1.0": *

#import themes.metropolis: *

#show: metropolis-theme.with(
  aspect-ratio: "16-9",
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

#new-section-slide("Context")

#slide(title: "Scenario: computation everywhere")[
  // TODO - maybe I can find a better image :)
    #figure(
    image("imgs/pervasive.png", width: 73%)
  )
]

#slide(title: "Main characteristics")[
  - a lot of data
  - distributed data
  - privacy
  - cooperation
]

#slide(title: "Traditional ML training loop")[
  #figure(
    image("imgs/classic-ml.png", width: 48%)
  )
]

#slide(title:"A real world use case: Google Virtual Keyboard")[
    #table(inset: 1em, stroke: none, columns: (1fr, 1fr), align: (left, left),
    [
      - *Task*: Next word prediction // TODO - add cit
      - *Problem*: Users' privacy
      - *Solution*: Share weights not data
    ],
    [
      #figure(
        image("imgs/keyboard.svg", width: 70%)
      )
    ]  
  )
]

#slide(title: "What Federated Learning is?")[
 #figure(
    image("imgs/federated-learning-schema.svg", width: 50%)
  )
]

#let check = box[ #figure(
    image("imgs/checkmark.svg", width: 6%)
  )]

#let cross = box[ #figure(
    image("imgs/crossmark.svg", width: 6%)
  )]

#slide(title: "Pros & Cons")[

  #table(inset: 1em, stroke: none, columns: (1fr, 1fr), align: (left, left),
    [
      #check Reduces privacy concerns

      #check Transfers less data to the server
    ],
    [
      #cross Need for a central trusted entity

      #cross Single point of failure

      #cross Data heterogeneity 
    ]  
  )

]

#slide(title: "Towards peer-to-peer Federated Learning")[
  #figure(
    image("imgs/federated-learning-schema-p2p.svg", width: 50%)
  )
]

#slide(title: "Data heterogeneity")[
  - In real life, data are often #underline[non-independently and identically distributed]
  - Example: differences in UK-US slang
  - A possible categorization:
    - Feature skew
    - Label skew
    - Quantity skew
]

#slide(title: "How can we address data heterogeneity?")[
  - Adding a regularization term to classic FL algorithms @scaffold @fedprox
  - #underline[*Personalized*] Federated Learning
    - #underline[*Cluster level*] @hcfl @ecfl @tapfl
    - Client level @atldd @dasbct @dalba
    - Graph level @fedu @pflwg @9832778
]


#slide[
  #bibliography("bibliography.bib")
]
