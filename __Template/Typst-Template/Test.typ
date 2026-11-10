/* packages */
#import "../../__Template/Typst-Template/Packages-for-Typst-Template.typ": *

/* abbrs */
#import "../../__Template/Typst-Template/Abbrs-for-Typst-Template.typ": *
#let proof = proof-template.with(prefix: [证明：]) // more recommended by GPT 5.6 Luna, and get ce when try to use set/show

#import "@preview/fletcher:0.5.8": diagram as fletcher-diagram, node as fletcher-node, edge as fletcher-edge

#let state-graph(zero-zero, zero-one, one-zero, one-one) = {
    fletcher-diagram(
        node-shape: circle,
        node-stroke: black,
        node-fill: white,
        edge-stroke: 0.8pt,
        spacing: (10em, 4em),
        fletcher-node((0, 0), [$0$]),
        fletcher-node((1, 0), [$1$]),
        fletcher-edge((0, 0), (0, 0), marks: "->", bend: 120deg, loop-angle: 180deg, label: zero-zero, label-angle: 90deg),
        fletcher-edge((0, 0), (1, 0), marks: "->", bend: 30deg, label: zero-one),
        fletcher-edge((1, 0), (0, 0), marks: "->", bend: 30deg, label: one-zero),
        fletcher-edge((1, 0), (1, 0), marks: "->", bend: 120deg, loop-angle: 0deg, label: one-one, label-angle: -90deg),
    )
}

#state-graph(1, 2, 3, 4)