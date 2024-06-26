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
  #figure(image("imgs/DIP INFORMATICA-SCIENZA E INGEGNERIA_DISI_EN.svg", width:45%))
  //#pad(x:0.5em, "University of Bologna")
]


#title-slide(
  title: "Field-based Coordination for Federated Learning",
  subtitle: "Talk @ COORDINATION 2024",
  author: author, //"Davide Domini, Gianluca Aguzzi, Lukas Esterle, Mirko Viroli",
  //date: datetime.today().display("[day] [month repr:long] [year]"),
)

#new-section-slide("Federated Learning Background")

// #slide(title: "Scenario: computation everywhere")[
//   // TODO - maybe I can find a better image :)
//     #figure(
//     image("imgs/pc2.jpg", width: 78%)
//   )
// ]

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

#let arrow = box[ #figure(
    image("imgs/arrow.svg", width: 2%)
  )]

#slide(title: "Main characteristics")[

  #arrow Huge amount of data

  #arrow Naturally distributed data

  #arrow Privacy concerns

  #arrow Cooperation to solve collective tasks
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

#slide(title: "How can data heterogeneity be addressed?")[
  - Adding a regularization term to classic FL algorithms @scaffold @fedprox
  - #underline[*Personalized*] Federated Learning
    - #underline[*Cluster level*] @hcfl @ecfl @tapfl
    - Client level @atldd @dasbct @dalba
    - Graph level @fedu @pflwg @9832778
]

#new-section-slide("Field based coordination for FL")


#slide(title:"Field-Based Coordination - one slide")[
  #figure(
    image("imgs/ac-one-slide.png", width: 88%)
  )
]

#slide(title:"Why field-based coordination?")[

 #arrow Failure tolerance

 #arrow Decentralized clustering

 #arrow Dynamic number of clusters

 #arrow Exploits spatial distribution of the devices

 #arrow Supports both peer-to-peer and specialization

 #arrow Dynamic model aggregation without a centralized authority

]

 // rep(0)(x => x + 1) 
 // fooldhood(0)(_ + _)(nbr(1))

#slide(title:"Field-based coordination operators")[

  ```scala
  // Repetition over time
  rep[V](init: V)(f: (V) => V) 
  // Iteration over neighbors
  fooldhood[V](init: V)(accumulator: (V,V) => V)(nbrExpression: V) 
  
  ```

  ```scala
  // Collect cast
  C[V](source: Boolean, accumulator: V => V, localValue: V, null: V)
  // Gradient cast
  G[V](source: Boolean, value: V, accumulator: V => V)
  // Leader election
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


#slide(title:"Self-organising Coordination Regions for FL")[

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

// #slide(title: "Advantages")[
 


// ]

#new-section-slide("Experimental Evaluation")

#slide(title:"Experiments")[
  - #underline[*Field-Based P2P vs Centralized Federated Learning*]
    - Task: Classification
    - Dataset: MNIST and Fashion MNIST
    - Number of devices: 8
    - Model: LeNet CNN

  - #underline[*Field-Based Specialized Federated Learning*]
    - Task: Time-series prediction
    - Dataset: PM10 samples in Europe
    - Number of devices: 250
    - Model: RNN
]

#slide(title: "Results: MNIST Classification ")[

  #table(inset: 1em, stroke: none, columns: (1fr, 1fr, 1fr), align: (left, left, left),
    [
      #figure(
        image("imgs/avg_train_loss_mnist.png", width: 100%)
      )
    ],
        [
      #figure(
        image("imgs/avg_validation_loss_mnist.png", width: 100%)
      )
    ],
        [
      #figure(
        image("imgs/avg_validation_accuracy_mnist.png", width: 100%)
      )
    ]
  )
]

#slide(title: "Results: Fashion MNIST Classification ")[

  #table(inset: 1em, stroke: none, columns: (1fr, 1fr, 1fr), align: (left, left, left),
    [
      #figure(
        image("imgs/avg_train_loss_fashion.png", width: 100%)
      )
    ],
        [
      #figure(
        image("imgs/avg_validation_loss_fashion.png", width: 100%)
      )
    ],
        [
      #figure(
        image("imgs/avg_validation_accuracy_fashion.png", width: 100%)
      )
    ]
  )
]



#slide(title: "Experiment: Air Quality Prediction ")[

  #table(inset: 1em, stroke: none, columns: (1fr, 1fr), align: (left, left),
    [
      #figure(
        image("imgs/concentration.png", width: 120%)
      )

    ],
    [


      #figure(
        image("imgs/pm10-stations-deploy-alchemist.png", width: 100%)
      )

    ]  
  )

]


#slide(title: "Results: Air Quality Prediction")[
#table(inset: 1em, stroke: none, columns: (1fr, 1fr), align: (left, left),
    [
      #figure(
        image("imgs/trainvalpm10.png", width: 100%)
      )

    ],
    [


      #figure(
        image("imgs/mse-pm10.png", width: 100%)
      )

    ]  
  )
]

#new-section-slide("Future Work")

#slide(title:"What's next?")[
  #arrow More exploration with non-iid data

  #arrow Space fluidity for self-adaptive clustering

  #arrow Sparse neural networks for low resource settings
]


#slide[
  #bibliography("bibliography.bib")
]
