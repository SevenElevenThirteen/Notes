/* 中文伪粗体 */
#import "@preview/cuti:0.4.0": show-cn-fakebold

/* graphic */
#import "@preview/cetz:0.5.2" // using #cetz.balabala
#import "@preview/fletcher:0.5.8" as fletcher: diagram, node, edge // using directly, but may conflict with other packages

/* a more friendly template for numbering */
#import "@preview/numbly:0.1.0": numbly

#let environment(body) = { // add all show/set rules here !
    show: show-cn-fakebold
    show math.equation: set block(breakable: true) // 允许行间公式跨页，但只会在显式换行处切分

    body // never forget this !
}