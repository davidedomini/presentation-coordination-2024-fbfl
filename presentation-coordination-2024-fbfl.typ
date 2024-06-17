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
    [#alert[*Davide Domini*]], [davide.domini\@unibo.it],
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
    image("imgs/pc2.jpg", width: 78%)
  )
]

#let arrow = box[ #figure(
    image("imgs/arrow.svg", width: 2%)
  )]

#slide(title: "Main characteristics")[

  #arrow Huge amount of data

  #arrow Naturally distributed data

  #arrow Privacy concerns

  #arrow Cooperation to solve collective tasks
]

#slide(title:"A real world use case: Google Virtual Keyboard")[
    #table(inset: 1em, stroke: none, columns: (1fr, 1fr), align: (left, left),
    [
      - *Task*: Next word prediction // TODO - add cit
      - *Problem*: Users' privacy
      // - *Solution*: Share weights not data
    ],
    [
      #figure(
        image("imgs/keyboard.svg", width: 70%)
      )
    ]  
  )
]

#slide(title: "Traditional DL training loop")[
  #figure(
    image("imgs/classic-ml.png", width: 48%)
  )
]

#slide(title: "What Federated Learning is?")[
 #align(center)[
  #alert[
    _*How can we train a model without collecting data?*_
  ]
 ]
 
 #figure(
    image("imgs/federated-learning-schema.svg", width: 40%)
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


#slide(title: "Data heterogeneity")[
  - In real life, data are often #underline[non-independently and identically distributed]
  - Example: differences in UK-US slang
  - A possible categorization:
    - Feature skew
    - Label skew
    - Quantity skew
]


#slide(title: "Towards peer-to-peer Federated Learning")[
  #figure(
    image("imgs/federated-learning-schema-p2p.svg", width: 50%)
  )
]

#slide(title: "How can we address data heterogeneity?")[
  - Adding a regularization term to classic FL algorithms @scaffold @fedprox
  - #underline[*Personalized*] Federated Learning
    - #underline[*Cluster level*] @hcfl @ecfl @tapfl
    - Client level @atldd @dasbct @dalba
    - Graph level @fedu @pflwg @9832778
]

#new-section-slide("Field based coordination for FL")


#slide(title:"Field-based coordination operators")[

  ```scala
  rep(0)(x => x + 1) // Repetition over time
  fooldhood(0)(_ + _)(nbr(1)) // Iteration over neighbors
  
  ```

  ```scala
  C[V](source: Boolean, accumulator: V => V, localValue: V, null: V)
  G[V](source: Boolean, value: V, accumulator: V => V)
  S(radius: Double): Boolean
  ```

]


#slide(title: "Full peer-to-peer learning")[
  ```scala
  rep(init())(model => { // Local model initialization
    // 1. Local training
    model.evolve(localEpochs)
    // 2. Model sharing
    val info = foldhood(Set(model))(_ ++ _)(nbr(model))
    // 3. Model aggregation
    aggregation(info)
  })
  ```  
]


#slide(title:"SCR for Federated Learning")[

  #figure(
     image("imgs/scr.svg", width: 100%)  
  )


]


#slide(title: "Learning in zones")[
  ```scala
  val aggregators = S(area, nbrRange) // Dynamic aggregator selection
  rep(init())(model => { // Local model initialization
    model.evolve() // 1. Local training step
    val pot = gradient(aggregators) // Potential field for model sharing
    // 2. model sharing
    val info = C(pot, _ ++ _, Set(model), Set.empty)
    val aggregateModel = aggregation(info) // 3. Aggregation
    sharedModel = broadcast(aggregators, aggregateModel) // 4. Gossiping
    mux(impulsesEvery(epochs)){ combineLocal(sharedModel, model) } { model }
  })
  ```
]

#let adv = box[ #figure(
    image("imgs/checkmark.svg", width: 2%)
  )]

#slide(title: "Advantages")[
 
 #arrow Dynamic number of clusters

 #arrow Decentralized clustering

 #arrow Supports both peer-to-peer interactions and the formation of specialized zones

 #arrow Dynamic model aggregation without a centralized authority

 #arrow Exploits spatial distribution of the devices

]


#slide(title: "Experiment: Air Quality Prediction ")[

  #table(inset: 1em, stroke: none, columns: (1fr, 1fr), align: (left, left),
    [
      - *Task*: PM10 prediction
      - *Problems*:
        - Different distributions in space
        - A lot of distributed data
    ],
    [

      #figure(
        image("imgs/concentration.png", width: 48%)
      )

      #figure(
        image("imgs/pm10-stations-deploy-alchemist.png", width: 46%)
      )

    ]  
  )

]


#slide(title: "Results")[

]

#slide(title:"What's next?")[
  #arrow More exploration with non-iid data

  #arrow Space fluidity for self-adaptive clustering

  #arrow Sparse neural networks for low resource settings
]


#slide[
  #bibliography("bibliography.bib")
]
