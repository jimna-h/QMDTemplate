#let qmdtemplate(
  title: "Statistics Homework",
  author: "Your Name",
  //date: datetime.today().display(),
  body
) = {
  // 1. Page & Font Setup
  set page(
    paper: "us-letter",
    margin: (x: 1in, y: 1in),
    numbering: "1 / 1",
  )
  set text(font: "Linux Libertine", size: 12pt)
  
  // 2. Title Block
  align(center)[
    #block(inset: 2.4em)[
      #text(weight: "bold", size: 1.6em)[#title] \
      #v(0.5em)
      #text(size:1.2em, gray.darken(50%))[#author] \
      //#date
    ]
  ]

  // 3. Heading Styling
  show heading: it => {
    set text(blue.darken(70%))
    block(it)
    v(0.5em)
  }

  // 4. Raw Block Styling (For the R Code and Output)
  show raw.where(block: true): it => {
    block(
      width: 100%,
      fill: luma(248),
      inset: 10pt,
      radius: 4pt,
      stroke: 0.5pt + luma(200),
      it
    )
  }

  // 5. Math Styling
  set math.equation(numbering: "(1)")

  // 6. Pretty URLs
  show link: underline
  show link: set text(eastern)
  show regex("\b[\w-]+\.[a-z]{2,}(\/\S*)?\b"): it => {
    let txt = it.text
    link("https://" + txt, txt)
  }

  body
}



#let questionbox(body) = {
  block(
    fill: rgb("#eef4ff").lighten(30%),
    stroke: (left: 3pt + rgb("#2d5da1").lighten(25%)), 
    inset: (x: 12pt, y: 10pt),
    width: 100%,
    radius: 2pt,
    [
      #set text(style: "italic", weight: "medium")
      #body
    ]
  )
}


// define question counters
#let question_counter = counter("question")
#let subquestion_counter = counter("subquestion")

// question headers
#let nextquestion() = {
  question_counter.step()
  subquestion_counter.update(0) 
  
  context [= Question #question_counter.display()]
}

// subquestion headers
#let subquestion() = {
  subquestion_counter.step()

  context [== #question_counter.display()#subquestion_counter.display("a").]
}

// Change "binom" to "choose"
#let choose = math.binom

// Allow "bar(x)" to act as "overline(x)"
#let bar = math.overline

// Easy Line
#let line= line(length: 100%, stroke: 0.5pt)

// Easy d
#let dx = $"d"x$
#let dy = $"d"y$
#let dz = $"d"z$
#let du = $"d"u$
#let dv = $"d"v$
#let dw = $"d"w$
#let dtheta = $"d"theta$

// Easy gap
#let gap = v(0.5in)

// Easy iid
#let iid = $limits(tilde)^"iid"$



